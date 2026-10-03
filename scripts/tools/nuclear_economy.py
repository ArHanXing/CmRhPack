"""核燃料产线的经济性核算：一条浓缩线 <> 一个反应堆的发电潜力。

数值来源全部是**已考证的实测/字节码**，不是估计：
  · RF_PER_PULSE = 64          (oritech-common.toml [reactor] rfPerPulse)
  · 棒型内部脉冲：单联 1 / 双联 4 / 四联 12   (ReactorRodBlock 构造参数 + 官方文档)
  · 能量 = P × 64 RF/t × 堆叠高度             (ReactorControllerBlockEntity 字节码)
  · 燃料容量 = t2.zs 里 _reactor() 的 time；实际燃烧时长 = time ÷ 棒数
  · RPM：耗时 ×(1−0.5r)、耗能 ×(1+3r)（每轮耗电由 1.0 单调升到 2.0，无降级）
配方侧数值直接读 scripts/nuclear_fuel.zs，改脚本后重跑即可。
"""
import pathlib
import re
import sys

ROOT = pathlib.Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "scripts/tools"))
import fuel_ledger as L  # noqa: E402

RF_PER_PULSE = 64
TICKS_PER_HOUR = 72000

# 棒型：内部脉冲 / 占用的燃料容量单位
RODS = {"single": (1, 1), "double": (4, 2), "quad": (12, 4)}

# t2.zs 里的燃料容量
CAPACITY = {"uranium": 36000, "dual_uranium": 72000, "thorium": 72000,
            "mox": 108000, "naquadria": 360000}


def main() -> int:
    t = L.strip_comments((ROOT / "scripts/nuclear_fuel.zs").read_text(encoding="utf-8"))
    rec = {}
    for name, body in L.iter_recipes(t):
        tm = re.search(r'\btime:\s*(\d+)', body)
        pw = re.search(r'\bpower:\s*(\d+)', body)
        rec[name] = (int(tm.group(1)) if tm else 0, int(pw.group(1)) if pw else 0)

    # ---------- 1. 一条浓缩线的产能 ----------
    cascade_cycles = {"nuclear.3.stage1": 4, "nuclear.4.stage2": 2, "nuclear.5.stage3": 1}
    t_casc = max(rec[k][0] for k in cascade_cycles)
    total_cycles = sum(cascade_cycles.values())

    print("=" * 68)
    print("一、一条浓缩线的产能（4:2:1 阵列 = 7 台同位素分离机）")
    print("=" * 68)
    print(f"  单台一轮耗时 {t_casc} tick；每颗燃料棒需 "
          f"④×{cascade_cycles['nuclear.3.stage1']} + ⑤×{cascade_cycles['nuclear.4.stage2']} "
          f"+ ⑥×{cascade_cycles['nuclear.5.stage3']} = {total_cycles} 轮")
    print()
    print("  %-6s %-10s %-12s %-12s %s" % ("转速", "单轮耗时", "颗/小时", "台数", "说明"))
    lines = {}
    for label, R in (("R=0%", 0.0), ("R=60%", 0.6), ("R=100%", 1.0)):
        te = round(t_casc * (1 - 0.5 * R))
        per_h = TICKS_PER_HOUR / te if te else 0
        n = 4 + 2 + 1
        note = ("甜点（快 1.43×，每轮贵 1.96×）" if R == 0.6
                else ("最快（快 2×，每轮贵 2×）" if R > 0.6 else "基准"))
        lines[label] = per_h
        print("  %-6s %-10s %-12.1f %-12d %s" % (label, f"{te} t", per_h, n, note))

    # ---------- 2. 反应堆的胃口 ----------
    print()
    print("=" * 68)
    print("二、反应堆的燃料胃口（铀丸，四联棒）")
    print("=" * 68)
    rods, units = RODS["quad"]
    burn = CAPACITY["uranium"] // units
    print(f"  四联棒：容量 {CAPACITY['uranium']} ÷ 棒数 {units} = 燃烧 {burn} tick "
          f"({burn/TICKS_PER_HOUR*60:.1f} 分钟)/颗")
    print()
    print("  %-22s %-8s %-10s %-12s %s" % ("堆芯", "每棒P", "总输出", "颗/小时", "说明"))
    cores = {}
    for label, n_rods, P in (("单根四联裸棒", 1, 12), ("四联+4邻（5棒）", 5, 28), ("四联+6邻（7棒）", 7, 36)):
        out = n_rods * P * RF_PER_PULSE
        per_h = n_rods * TICKS_PER_HOUR / burn
        cores[label] = (out, per_h)
        print("  %-22s %-8d %-10s %-12.1f %s" % (
            label, P, f"{out:,} EU/t", per_h, f"{out/2048:.2f} A EV" if out < 8192 else f"{out/8192:.2f} A IV"))

    # ---------- 3. 供需比 ----------
    print()
    print("=" * 68)
    print("三、一条线能喂多少反应堆？（核心结论）")
    print("=" * 68)
    ref_out, ref_need = cores["四联+6邻（7棒）"]
    print("  以「四联+6邻 7 棒核心」为参照：输出 %s，需 %.1f 颗/小时" % (f"{ref_out:,} EU/t", ref_need))
    print()
    print("  %-8s %-12s %-14s %-14s %-12s %s" % ("转速", "线产能", "需几条线", "分离机台数", "支撑功率", "级联耗电"))
    for label, R in (("R=0%", 0.0), ("R=60%", 0.6), ("R=100%", 1.0)):
        per_h = lines[label]
        nl = ref_need / per_h
        draw = nl * 7 * rec["nuclear.3.stage1"][1] * (1 + 3 * R)
        print("  %-8s %-12s %-14.2f %-14.0f %-12s %s" % (
            label, f"{per_h:.1f} 颗/h", nl, nl * 7, f"{ref_out/nl:,.0f} EU/t", f"{draw:,.0f} EU/t"))

    # ---------- 4. 能量回收率 ----------
    print()
    print("=" * 68)
    print("四、能量账（以 1 颗铀燃料棒、四联棒、P=36 计）")
    print("=" * 68)
    out_eu = burn * 36 * RF_PER_PULSE
    steps = [("① 溶出", "nuclear.0.leach", 1), ("② 氟化", "nuclear.1.fluorinate", 1),
             ("③ 配料", "nuclear.2.blend", 4), ("⑨ 还原", "nuclear.6.reduce", 1),
             ("⑩ 制棒", "nuclear.7.rod_uranium", 1)]
    chem = sum(rec[k][0] * rec[k][1] * n for _, k, n in steps)
    print("  产出：%d tick × 36 脉冲 × 64 = %s EU" % (burn, f"{out_eu:,}"))
    print()
    print("  %-14s %-12s %-12s %s" % ("环节", "轮数", "能耗/轮", "小计"))
    for nm, k, n in steps:
        tt, pp = rec[k]
        print("  %-14s %-12d %-12s %s" % (nm, n, f"{tt}×{pp}", f"{tt*pp*n:,}"))
    for label, R in (("R=0%", 0.0), ("R=60%", 0.6), ("R=100%", 1.0)):
        te = round(t_casc * (1 - 0.5 * R))
        pe = rec["nuclear.3.stage1"][1] * (1 + 3 * R)
        casc = te * pe * total_cycles
        tot = casc + chem + 131_600          # +131.6k = T1.5 采选（2.67 矿 × 49.3k）
        print(f"  级联（{label}）: {te} t × {pe:.0f} EU/t × {total_cycles} 轮 = {casc:,.0f}")
        print(f"  ⇒ 总投入 {tot:,.0f} EU，净赚 {out_eu-tot:,.0f} EU，"
              f"**EROI = {out_eu/tot:.2f}×**（投入占产出 {tot/out_eu*100:.0f}%）")
        print()

    # ---------- 5. 矿石消耗 ----------
    print("=" * 68)
    print("五、矿石消耗")
    print("=" * 68)
    ore_per_rod = 8 / 3
    print("  1 颗棒 = 8 铀粉 = %.2f 铀矿（T1.5 每矿出 3 粉）" % ore_per_rod)
    print("  1 铀矿 ≈ %s EU ≈ %.0f 桶硝基碳燃油（244,000 EU/桶）"
          % (f"{out_eu/ore_per_rod:,.0f}", out_eu / ore_per_rod / 244000))
    for label, (out, need) in cores.items():
        print("  %-22s 需 %.1f 铀矿/小时" % (label, need * ore_per_rod))
    return 0


if __name__ == "__main__":
    sys.exit(main())
