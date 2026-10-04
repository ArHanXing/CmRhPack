"""核燃料产线的经济性核算：一条浓缩线 <> 一个反应堆的发电潜力。

所有反应堆侧数值都来自 `reactor_model.py`（字节码 + 上游源码交叉验证），
不再手写 P 值 —— 这是本脚本 2026-04 重写的核心原因：

  ⚠️ 旧版三处系统性错误（已修）：
    1. 参照堆芯写成「四联+6邻（7棒）P=36」—— 那是 **8 邻** 的算法。
       实际邻居是 4 邻（上下左右），四联棒 P 上限 = 12 + 4×4 = **28**。
    2. 堆芯总脉冲写成 `棒数 × 单棒最大P` —— 只有中心棒能达到最大值。
       必须**逐棒求和**（十字 5 棒实为 92，不是 5×28=140，旧版高估 1.52×）。
    3. 热/冷却被当成随高度缩放 —— 实际是**每层（2D 剖面）**量纲，高度中性。

配方侧数值直接读 scripts/nuclear_fuel.zs / t2.zs，改配方后重跑即可。
"""
from __future__ import annotations

import pathlib
import re
import sys

ROOT = pathlib.Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "scripts/tools"))

import fuel_ledger as L          # noqa: E402
import reactor_model as RM       # noqa: E402

TICKS_PER_HOUR = 72000

# t2.zs 里 _reactor() 的燃料容量（= 配方 time 字段）
CAPACITY = {
    "uranium": 36000, "dual_uranium": 72000, "thorium": 72000,
    "dual_thorium": 144000, "mox": 108000, "dual_mox": 216000,
    "naquadria": 360000, "dual_naquadria": 720000,
}

# 燃料棒 -> (棒型, 容量 key)。本包 8 种燃料棒都是四联/双联。
FUEL_RODS = {
    "jsonreg:uranium_fuel_rod":          ("rod4", "uranium"),
    "jsonreg:dual_uranium_fuel_rod":     ("rod2", "dual_uranium"),
    "jsonreg:thorium_fuel_rod":          ("rod4", "thorium"),
    "jsonreg:dual_thorium_fuel_rod":     ("rod2", "dual_thorium"),
    "jsonreg:mox_fuel_rod":              ("rod4", "mox"),
    "jsonreg:dual_mox_fuel_rod":         ("rod2", "dual_mox"),
    "jsonreg:naquadria_fuel_rod":        ("rod4", "naquadria"),
    "jsonreg:dual_naquadria_fuel_rod":   ("rod2", "dual_naquadria"),
}

# 参照堆芯：**4 邻下真实可达且能稳定冷却的最优单棒配置**。
# 1 反射器 + 3 热管 + 吸收器 ⇒ P=16，实测稳态 61 热（远低于 maxHeat 2000）。
# 这是「单棒单元」的最优解；阵列则是把该单元按间距 ≥3 平铺（见 §三）。
# 注：P=20 起无论配什么冷却都熔毁 ⇒ 16 是可行上限，不是 28。
REFERENCE_UNIT_PULSES = 16
REFERENCE_UNIT_RF = REFERENCE_UNIT_PULSES * RM.RF_PER_PULSE


def load_recipes() -> dict[str, tuple[int, int]]:
    """从 nuclear_fuel.zs 读 (time, power)。"""
    text = L.strip_comments((ROOT / "scripts/nuclear_fuel.zs").read_text(encoding="utf-8"))
    out: dict[str, tuple[int, int]] = {}
    for name, body in L.iter_recipes(text):
        tm = re.search(r"\btime:\s*(\d+)", body)
        pw = re.search(r"\bpower:\s*(\d+)", body)
        out[name] = (int(tm.group(1)) if tm else 0, int(pw.group(1)) if pw else 0)
    return out


def _reflector_unit(n_refl: int, n_pipe: int, cooler: str) -> RM.Grid:
    """单根棒：n_refl 个反射器 + n_pipe 个热管（其余面空），热管外圈包 cooler。

    用于求「用反射器换 P」的可行上限。
    """
    grid: RM.Grid = {(0, 0): "rod4"}
    dirs = list(RM.NEIGHBORS_4)
    for d in dirs[:n_refl]:
        grid[d] = RM.REFLECTOR
    for d in dirs[n_refl:n_refl + n_pipe]:
        grid[d] = RM.PIPE
    for p in [d for d in dirs if grid.get(d) == RM.PIPE]:
        for dx in (-1, 0, 1):
            for dy in (-1, 0, 1):
                n = (p[0] + dx, p[1] + dy)
                if n not in grid:
                    grid[n] = cooler
    return grid


def section(title: str) -> None:
    print()
    print("=" * 72)
    print(title)
    print("=" * 72)


def _sparse_array(side: int, cooler: str, spacing: int = 3) -> RM.Grid:
    """稀疏阵列：每根棒四邻全热管，热管外圈包 cooler。

    棒间距 3 ⇒ 棒之间不相邻 ⇒ 各自 P=12 独立，但每根都有完整冷却套件。
    这是 4 邻下唯一能规模化且稳定的布局。
    """
    grid: RM.Grid = {}
    for i in range(side):
        for j in range(side):
            x0, y0 = i * spacing, j * spacing
            grid[(x0, y0)] = "rod4"
            pipes = []
            for dx, dy in RM.NEIGHBORS_4:
                p = (x0 + dx, y0 + dy)
                grid[p] = RM.PIPE
                pipes.append(p)
            for p in pipes:
                for dx in (-1, 0, 1):
                    for dy in (-1, 0, 1):
                        n = (p[0] + dx, p[1] + dy)
                        if n not in grid:
                            grid[n] = cooler
    return grid


def main() -> int:
    rec = load_recipes()

    # ---------------------------------------------------------- 1. 浓缩线产能
    cycles = {"nuclear.3.stage1": 4, "nuclear.4.stage2": 2, "nuclear.5.stage3": 1}
    t_casc = max(rec[k][0] for k in cycles)
    total_cycles = sum(cycles.values())

    section("一、一条浓缩线的产能（4:2:1 阵列 = 7 台同位素分离机）")
    print(f"  单台一轮 {t_casc} tick；每颗燃料棒需 "
          f"④×{cycles['nuclear.3.stage1']} + ⑤×{cycles['nuclear.4.stage2']} "
          f"+ ⑥×{cycles['nuclear.5.stage3']} = {total_cycles} 轮")
    print()
    print("  %-7s %-11s %-13s %-6s %s" % ("转速", "单轮耗时", "颗/小时", "台数", "说明"))
    line_throughput: dict[str, float] = {}
    for label, R in (("R=0%", 0.0), ("R=60%", 0.6), ("R=100%", 1.0)):
        te = round(t_casc * (1 - 0.5 * R))
        per_h = TICKS_PER_HOUR / te if te else 0.0
        line_throughput[label] = per_h
        note = ("甜点（快 1.43×，每轮贵 1.96×）" if R == 0.6
                else ("最快（快 2×，每轮贵 2×）" if R > 0.6 else "基准"))
        print("  %-7s %-11s %-13.1f %-6d %s" % (label, f"{te} t", per_h, 7, note))

    # ---------------------------------------------------------- 2. 堆芯（4 邻）
    section("二、4 邻下可达的堆芯（每层；P 逐棒求和）")
    print("  ⚠️ 邻居是 4 邻（上下左右），不是 8 邻。四联棒 P 上限 = 12 + 4×4 = 28。")
    print("  ⚠️ 堆芯总 P 必须逐棒求和：边缘棒邻居少，达不到最大 P。")
    print()
    print("  %-20s %-5s %-7s %-11s %-9s %s" % ("堆芯", "棒数", "总P", "RF/t(每层)", "热(每层)", "RF/heat"))
    cores: dict[str, RM.CoreStats] = {}
    for name, grid in RM.CANONICAL_CORES.items():
        s = RM.core_stats(grid)
        cores[name] = s
        print("  %-20s %-5d %-7d %-11s %-9s %.2f" % (
            name, s.rods, s.total_pulses, f"{s.rf_per_tick:,}", f"{s.heat_per_tick:,}", s.rf_per_heat))

    # ---------------------------------------------------------- 3. 冷却可行性
    section("三、冷却可行性（4 邻下最硬的约束）")
    print("  燃料棒的 4 个面【既是脉冲来源、又是唯一散热通道】，两者直接竞争。")
    print("  · 散热口：只对【自己最热的那个邻居】移除 min(h/100+4, h)，多个可叠加")
    print("  · 吸收器：对【每个】邻居各移除 16（需持续供冰）")
    print("  · 回收口：对【每个】邻居各移除 8，并按 8×2×高度 RF/t 发电")
    print()
    print("  ① 裸堆（无热管）的平衡点：")
    for kind, key in (("散热口", RM.VENT), ("吸收器", RM.ABSORBER), ("回收口", RM.RECOVERY)):
        g = {(0, 0): "rod4"}
        for p in [(1, 0), (-1, 0), (0, 1), (0, -1)]:
            g[p] = key
        r = RM.simulate(g, max_ticks=40000)
        print(f"     4×{kind:4} -> 稳态 {r.steady_heat:8.0f}  "
              f"{'OK 稳定' if not r.melted else '✗ 熔毁'}")
    print("     ⇒ 裸堆只有 4 个散热口压得住（吸收器 64 < 76、回收口 32 < 76）。")
    print("     ⇒ 且【加任何外部脉冲都会烧穿】：P=16 发热 132 > 4×24=96。")
    print()
    print("  ② 但用【热管网络】可以把热搬出去，代价是棒必须稀疏：")
    print("     布局 = 每根棒 4 邻全放热管，热管外圈再包冷却件；棒间距 ≥3 才互不干扰。")
    print()
    print("     %-30s %-5s %-10s %-9s %s" % ("阵列", "棒数", "RF/t(每层)", "稳态热", "结果"))
    for side in (1, 2, 3, 4, 5):
        g = _sparse_array(side, RM.ABSORBER)
        s = RM.core_stats(g)
        r = RM.simulate(g, max_ticks=50000)
        print("     %-30s %-5d %-10s %-9.0f %s" % (
            f"{side}x{side} 稀疏阵列（吸收器）", s.rods, f"{s.rf_per_tick:,}",
            r.steady_heat, "OK" if not r.melted else "✗ 熔毁"))
    print()
    print("     ⇒ **吸收器阵列可以无限扩展**（5x5=25 棒稳态仅 53 热）。")
    print("     ⇒ 散热口阵列同样可行，但稳态温度更高（1 棒 594 / 4 棒 829）。")
    print("     ⇒ 回收口阵列最多 1 棒（4 棒即熔毁）—— 它散热最弱（8/邻居）。")
    print()
    print("  ③ 核心权衡：**密度换 P，稀疏换冷却**。")
    print("     · 棒相邻 → 互相加成（每邻 +4），但吃掉冷却面")
    print("     · 棒间距 ≥3 → 各自独立 P=12，但每根都能配完整冷却套件")
    print("     · 实测：3x3 密堆总 P=204 但必熔毁；")
    print("             3x3 稀疏阵列总 P=108（每棒 12）但稳态 20 热，完全可行。")
    print()
    print("  ④ 用【反射器】换 P 的极限（每棒 4 个面：反射器 + 热管 + 冷却）：")
    print()
    print("     %-34s %-4s %-10s %-7s %-9s %s" % (
        "单棒配置", "P", "RF/t", "发热", "稳态热", "结果"))
    for n_refl in range(0, 3):
        n_pipe = 4 - n_refl
        for kind, key in (("吸收器", RM.ABSORBER), ("散热口", RM.VENT)):
            g = _reflector_unit(n_refl, n_pipe, key)
            P = RM.pulse_of(g, (0, 0))
            r = RM.simulate(g, max_ticks=50000)
            print("     %-34s %-4d %-10s %-7d %-9.0f %s" % (
                f"{n_refl}反射器+{n_pipe}热管+{kind}", P, f"{P * 64:,}",
                RM.heat_of(P), r.steady_heat, "OK" if not r.melted else "✗ 熔毁"))
    print()
    print("     ⇒ **P=16 是可行上限**（1 反射器 + 3 热管 + 吸收器/散热口）。")
    print("     ⇒ P≥20（2 个反射器）无论配什么冷却都熔毁 —— 热管数量不够搬运。")
    print()
    print("  ⇒ 结论：本包核电的可行域 = **稀疏阵列，每棒 P≤16**。")
    print("     规模由燃料吞吐与机器数量决定，而非散热。")

    # ---------------------------------------------------------- 4. 供需比
    section("四、一条浓缩线能喂多少反应堆？")
    cap = CAPACITY["uranium"]
    burn_ticks = cap // RM.ROD_TYPES["rod4"][0]
    # 单棒单元（P=16）的耗料：一根四联棒每 tick 吃 4，每颗丸 9000 tick
    rods_per_hour_per_unit = TICKS_PER_HOUR * RM.ROD_TYPES["rod4"][0] / cap
    unit_rf = REFERENCE_UNIT_RF
    print(f"  参照单元：1 反射器 + 3 热管 + 吸收器 ⇒ P={REFERENCE_UNIT_PULSES}，"
          f"{unit_rf:,} RF/t(每层)")
    print(f"  每颗铀丸喂 1 根四联棒：容量 {cap} ÷ 棒数 4 = 燃烧 {burn_ticks} tick "
          f"= {burn_ticks / TICKS_PER_HOUR * 60:.1f} 分钟/颗 "
          f"⇒ {rods_per_hour_per_unit:.1f} 颗/h/单元")
    print()
    print("  注：反应堆规模由【铺多少单元】决定，不受散热限制（吸收器阵列可无限扩展）。")
    print("      下表是「一条浓缩线能养几个单元」。")
    print()
    print("  %-8s %-13s %-14s %-12s %-13s %s" % (
        "转速", "线产能", "能养几个单元", "单元总RF/t", "级联耗电", "级联占产出"))
    for label, _R in (("R=0%", 0.0), ("R=60%", 0.6), ("R=100%", 1.0)):
        per_h = line_throughput[label]
        n_units = per_h / rods_per_hour_per_unit
        # 一条线的机器数固定 7 台，与它喂几个单元无关
        draw = 7 * rec["nuclear.3.stage1"][1] * (1 + 3 * _R)
        out = n_units * unit_rf
        print("  %-8s %-13s %-14.2f %-12s %-13s %.1f%%" % (
            label, f"{per_h:.1f} 颗/h", n_units, f"{out:,.0f} RF/t",
            f"{draw:,.0f} EU/t", draw / out * 100))

    # ---------------------------------------------------------- 5. 能量账
    # ⚠️ 口径：以「单根四联棒、1 反射器 + 3 热管 + 吸收器（P=16，可行上限）」计。
    #    每颗铀丸喂 1 根四联棒 ⇒ 燃烧 time/rodCount = 9000 tick。
    unit = _reflector_unit(1, 3, RM.ABSORBER)
    unit_p = RM.pulse_of(unit, (0, 0))
    section(f"五、能量账（以 1 颗铀燃料丸、单棒 P={unit_p}（可行上限）计）")
    out_rf = burn_ticks * unit_p * RM.RF_PER_PULSE
    steps = [("① 溶出", "nuclear.0.leach", 1), ("② 氟化", "nuclear.1.fluorinate", 1),
             ("③ 配料", "nuclear.2.blend", 4), ("⑨ 还原", "nuclear.6.reduce", 1),
             ("⑩ 制棒", "nuclear.7.rod_uranium", 1)]
    chem = sum(rec[k][0] * rec[k][1] * n for _, k, n in steps)
    print(f"  产出：{burn_ticks} tick × P{unit_p} × 64 = {out_rf:,} RF")
    print(f"  （若用 P=12 裸棒则为 {burn_ticks * 12 * RM.RF_PER_PULSE:,} RF；"
          f"P=28 理论极限 {burn_ticks * 28 * RM.RF_PER_PULSE:,} RF 但必然熔毁）")
    print()
    print("  %-14s %-10s %-13s %s" % ("环节", "轮数", "能耗/轮", "小计"))
    for nm, k, n in steps:
        tt, pp = rec[k]
        print("  %-14s %-10d %-13s %s" % (nm, n, f"{tt}×{pp}", f"{tt * pp * n:,}"))
    for label, R in (("R=0%", 0.0), ("R=60%", 0.6), ("R=100%", 1.0)):
        te = round(t_casc * (1 - 0.5 * R))
        pe = rec["nuclear.3.stage1"][1] * (1 + 3 * R)
        casc = te * pe * total_cycles
        tot = casc + chem + 131_600          # +131.6k = T1.5 采选（2.67 矿 × 49.3k）
        print(f"  级联（{label}）: {te} t × {pe:.0f} EU/t × {total_cycles} 轮 = {casc:,.0f}")
        print(f"  ⇒ 总投入 {tot:,.0f} EU，净赚 {out_rf - tot:,.0f} EU，"
              f"**EROI = {out_rf / tot:.2f}×**（投入占产出 {tot / out_rf * 100:.0f}%）")
        print()

    # ---------------------------------------------------------- 6. 矿石消耗
    section("六、矿石消耗")
    ore_per_rod = 8 / 3
    print("  1 颗棒 = 8 铀粉 = %.2f 铀矿（T1.5 每矿出 3 粉）" % ore_per_rod)
    print("  1 铀矿 ≈ %s EU ≈ %.0f 桶硝基碳燃油（244,000 EU/桶）"
          % (f"{out_rf / ore_per_rod:,.0f}", out_rf / ore_per_rod / 244000))
    for name, s in cores.items():
        print("  %-20s 需 %.1f 铀矿/小时" % (name, s.rods_per_hour(cap) * ore_per_rod))
    return 0


if __name__ == "__main__":
    sys.exit(main())
