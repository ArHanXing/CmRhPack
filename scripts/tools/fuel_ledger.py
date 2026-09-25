#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""fuel_ledger.py —— 石化燃料热值账本（离线分析工具，不参与游戏运行）

用途：解析 scripts/*.zs 的燃烧配方与加工配方，算清每一步的热值收支，
      验证「产物热值 = 原料热值 + 本步能耗 + 小赚」这条标定原则是否成立。

── 两个换算常数（实测定标，非猜测）────────────────────────────────────────────
· TR 流体发电机：每桶恒定烧 1000 tick，每桶能量 = power × 1000 EU
    依据 techreborn BaseFluidGeneratorBlockEntity.tick() 字节码：
      每 tick 抽取 = euTick × 81 / (power×1000/81000)
      ⇒ 每桶 tick 数 = 1000 × power / euTick
      ⇒ 每桶能量   = euTick × 1000 × power / euTick = power × 1000（与机器 euTick 无关）
· OR 燃油发电机：每桶能量 = time × 5120 FE
    依据 config/oritech-common.toml：generators.fuelGeneratorData.energyPerTick = 512
    配方 fluidInput.amount = 8100 即 100 mB（81000 = 1000 mB）
  ⇒ 两族等价条件 power = 5.12 × time。本包历史配方正是按此标定（柴油 128 ↔ 25）。

── 机器能耗 ─────────────────────────────────────────────────────────────────
· TR 机器：配方自带 power 即 EU/t，本步能耗 = power × time
· OR 机器：oritech-common.toml [machineSettings.processingMachines.*].energyPerTick
· lychee:*：世界交互，无机器能耗（但 time 单位是**秒**，见 Lychee EntityMixin
  `tickCount % 20 == 10`，每秒判一次，不是每 tick）

── 热值口径 ─────────────────────────────────────────────────────────────────
· 市场热值：可燃流体由燃烧配方直接给出。
· 账面热值：不可燃中间体（裂解气混合物、硝酸、异丙苯…）没有燃烧配方，
  若按 0 计会制造「假利润」。这里按生产它的**最省路线**递归推定成本，
  并保守地把整条路线的开销全额摊到该流体上（高估成本 ⇒ 判定偏严格）。
用法：
    python fuel_ledger.py              # 热值表 + 逐步收支 + 问题清单
    python fuel_ledger.py --fluid X    # 查某流体的所有出处
"""
from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
SCRIPTS = HERE.parent
FILES = ["oil_chemistry.zs", "bio_chemistry.zs", "uni.zs", "misc.zs",
         "process_naquada.zs", "process_naquadah.zs", "etst&magic.zs",
         "t1.zs", "t2.zs", "t3.zs", "refinedstorage.zs", "lathe.zs",
         "precision_assembly.zs", "multiblock_casing.zs"]

BUCKET = 81000
OR_FUELGEN_FE_PER_TICK = 512
TR_EU_PER_BUCKET_PER_POWER = 1000
TARGET_MARGIN = 4000          # 作者注记的「小赚 ≈ +4k」

OR_MACHINE_FE = {
    "oritech:refinery": 128, "oritech:centrifuge": 64, "oritech:centrifuge_fluid": 64,
    "oritech:assembler": 128, "oritech:foundry": 256, "oritech:atomic_forge": 1024,
    "oritech:pulverizer": 32, "oritech:cooler": 32, "oritech:fragment_forge": 256,
    "oritech:furnace": 16, "oritech:deep_drill": 64,
}
TR_GENERATORS = ("techreborn:gas_generator", "techreborn:semi_fluid_generator",
                 "techreborn:diesel_generator", "techreborn:plasma_generator")
OR_GENERATOR = "oritech:fuel_generator"
GENERATORS = TR_GENERATORS + (OR_GENERATOR,)

SOLID_FUEL = {"jsonreg:petroleum_coke": 20000}   # 作者 burnTime=2000 注记下的估值

# 取之不尽、热值应视作 0 的流体；否则会通过「产水」的副产配方被赋上账面值，
# 污染乙醇、盐水电解等一整串判定。
FREE_FLUIDS = {"minecraft:water", "techreborn:compressed_air", "jsonreg:low_oxygen_nitrogen"}


# ── 词法工具 ──────────────────────────────────────────────────────────────────
def strip_comments(text: str) -> str:
    """去掉 // 行注释与 /* */ 块注释（保留换行以维持行号）。字符串内的 // 不动。"""
    out, i, n = [], 0, len(text)
    while i < n:
        c = text[i]
        if c == '"':
            j = i + 1
            while j < n:
                if text[j] == "\\":
                    j += 2
                    continue
                if text[j] == '"':
                    break
                j += 1
            out.append(text[i:j + 1])
            i = j + 1
        elif c == "/" and i + 1 < n and text[i + 1] == "/":
            j = text.find("\n", i)
            j = n if j < 0 else j
            i = j
        elif c == "/" and i + 1 < n and text[i + 1] == "*":
            j = text.find("*/", i + 2)
            j = n if j < 0 else j + 2
            out.append("\n" * text.count("\n", i, j))
            i = j
        else:
            out.append(c)
            i += 1
    return "".join(out)


def match_pair(s: str, start: int) -> int:
    """s[start] 为 { 或 [，返回匹配的闭合下标。"""
    open_c = s[start]
    close_c = "}" if open_c == "{" else "]"
    depth, in_str, esc = 0, False, False
    for i in range(start, len(s)):
        c = s[i]
        if in_str:
            if esc:
                esc = False
            elif c == "\\":
                esc = True
            elif c == '"':
                in_str = False
            continue
        if c == '"':
            in_str = True
        elif c == open_c:
            depth += 1
        elif c == close_c:
            depth -= 1
            if depth == 0:
                return i
    return -1


def array_span(body: str, *keys: str):
    for k in keys:
        m = re.search(r'\b' + k + r':\s*\[', body)
        if m:
            s = body.index("[", m.start())
            return (s, match_pair(body, s))
    return None


def enclosing(body: str, idx: int):
    stack: list[tuple[int, str]] = []
    in_str, esc = False, False
    for i in range(idx + 1):
        c = body[i]
        if in_str:
            if esc:
                esc = False
            elif c == "\\":
                esc = True
            elif c == '"':
                in_str = False
            continue
        if c == '"':
            in_str = True
        elif c in "{[":
            stack.append((i, c))
        elif c in "}]":
            if stack:
                stack.pop()
    if not stack:
        return (0, len(body))
    s, oc = stack[-1]
    return (s, match_pair(body, s))


def iter_recipes(text: str):
    for m in re.finditer(r'addJsonRecipe\(\s*"([^"]+)"\s*,', text):
        b = text.find("{", m.end())
        if b < 0:
            continue
        e = match_pair(text, b)
        if e > 0:
            yield m.group(1), text[b:e + 1]


# ── 配方解析 ──────────────────────────────────────────────────────────────────
CELL_FLUID = re.compile(r'components:\s*\{\s*"techreborn:fluid"\s*:\s*"([^"]+)"\s*\}')
OR_FLUID = re.compile(r'\{\s*fluid:\s*"([^"]+)"\s*,\s*amount:\s*(\d+)\s*\}')
ANY_ITEM = re.compile(r'"((?:jsonreg|techreborn|oritech|minecraft):[a-z0-9_]+)"')


def parse_recipe(body: str) -> dict:
    rtype = re.search(r'type:\s*"([^"]+)"', body)
    power = re.search(r'\bpower:\s*(\d+)', body)
    time = re.search(r'\btime:\s*(\d+)', body)
    r = {"type": rtype.group(1) if rtype else "?",
         "power": int(power.group(1)) if power else None,
         "time": int(time.group(1)) if time else None,
         "in_fluids": {}, "out_fluids": {}, "in_solids": {}, "out_solids": {}}

    ing = array_span(body, "ingredients")
    out = array_span(body, "outputs", "results")

    def is_in(span, pos):
        return bool(span) and span[0] <= pos <= span[1]

    for m in CELL_FLUID.finditer(body):
        fluid = m.group(1)
        if fluid == "minecraft:empty":
            continue
        s, _ = enclosing(body, m.start())
        obj = body[s:enclosing(body, m.start())[1] + 1]
        cnt = re.search(r'\bcount:\s*(\d+)', obj)
        vol = (int(cnt.group(1)) if cnt else 1) * BUCKET
        if is_in(ing, s):
            r["in_fluids"][fluid] = r["in_fluids"].get(fluid, 0) + vol
        elif is_in(out, s):
            r["out_fluids"][fluid] = r["out_fluids"].get(fluid, 0) + vol
        elif re.search(r'\bbase:\s*\{', obj):
            r["in_fluids"][fluid] = r["in_fluids"].get(fluid, 0) + vol
        else:
            r["out_fluids"][fluid] = r["out_fluids"].get(fluid, 0) + vol

    fi = re.search(r'fluidInput:\s*\{', body)
    fi_span = None
    if fi:
        fi_span = (fi.start(), match_pair(body, body.index("{", fi.start())))
        m = OR_FLUID.search(body, fi_span[0], fi_span[1] + 1)
        if m:
            r["in_fluids"][m.group(1)] = r["in_fluids"].get(m.group(1), 0) + int(m.group(2))
    for m in OR_FLUID.finditer(body):
        if fi_span and fi_span[0] <= m.start() <= fi_span[1]:
            continue
        r["out_fluids"][m.group(1)] = r["out_fluids"].get(m.group(1), 0) + int(m.group(2))

    # TR 发电机配方用裸 `fluid: "X"` 表示「每桶」，没有 fluidInput 结构。
    # 不收进来的话 `--fluid X` 会漏报 TR 端的燃烧配方。
    if r["type"] in TR_GENERATORS:
        f = re.search(r'\bfluid:\s*"([^"]+)"', body)
        if f:
            r["in_fluids"][f.group(1)] = r["in_fluids"].get(f.group(1), 0) + BUCKET

    for m in ANY_ITEM.finditer(body):
        fid = m.group(1)
        if fid not in SOLID_FUEL:
            continue
        s, e = enclosing(body, m.start())
        cnt = re.search(r'\bcount:\s*(\d+)', body[s:e + 1])
        n = int(cnt.group(1)) if cnt else 1
        if is_in(ing, s):
            r["in_solids"][fid] = r["in_solids"].get(fid, 0) + n
        elif is_in(out, s):
            r["out_solids"][fid] = r["out_solids"].get(fid, 0) + n
    return r


def step_energy(r: dict) -> int:
    t = r["time"]
    if t is None:
        return 0
    ty = r["type"]
    if ty.startswith("techreborn:"):
        return (r["power"] or 0) * t
    if ty.startswith("oritech:"):
        return OR_MACHINE_FE.get(ty, 0) * t
    return 0


# ── 数据收集 ──────────────────────────────────────────────────────────────────
def collect():
    heat, recipes = {}, []
    for fn in FILES:
        p = SCRIPTS / fn
        if not p.is_file():
            continue
        for name, body in iter_recipes(strip_comments(p.read_text(encoding="utf-8"))):
            r = parse_recipe(body)
            r["_name"], r["_file"] = name, fn
            recipes.append(r)
            if r["type"] in TR_GENERATORS and r["power"]:
                f = re.search(r'\bfluid:\s*"([^"]+)"', body)
                if f:
                    e = heat.setdefault(f.group(1), {})
                    e.setdefault("tr", r["power"] * TR_EU_PER_BUCKET_PER_POWER)
                    e.setdefault("tr_src", f"{fn}:{name}")
            elif r["type"] == OR_GENERATOR and r["time"]:
                for fluid, vol in r["in_fluids"].items():
                    if vol:
                        e = heat.setdefault(fluid, {})
                        e.setdefault("or", r["time"] * (BUCKET / vol) * OR_FUELGEN_FE_PER_TICK)
                        e.setdefault("or_src", f"{fn}:{name}")
    return heat, recipes


def book_values(heat, recipes):
    """不可燃中间体的账面热值。

    用**残值分摊**而非全额分摊：一条配方先把可燃产物按市场热值计价，只有覆盖不了
    的那部分（残值）才摊给不可燃副产物。否则「脱盐」会把自身成本摊给 saline_water，
    再被算回同一条配方的产出里，形成循环定价并把 Δ 虚增。
    残值对每个副产物全额计（不按体积分摊）⇒ 高估成本 ⇒ 判定偏严格。
    """
    market = {f: e.get("tr", e.get("or", 0.0)) for f, e in heat.items()}
    for f in FREE_FLUIDS:
        market.setdefault(f, 0.0)
    eff = dict(market)
    for f in FREE_FLUIDS:
        eff[f] = 0.0

    prod: dict[str, list] = {}
    for r in recipes:
        if r["type"] in GENERATORS:
            continue
        for f in r["out_fluids"]:
            prod.setdefault(f, []).append(r)

    for _ in range(40):
        changed = False
        for f, rs in prod.items():
            if f in market:
                continue
            best = None
            for r in rs:
                vol = r["out_fluids"].get(f, 0)
                if vol <= 0:
                    continue
                pool = sum(eff.get(i, 0.0) * v / BUCKET for i, v in r["in_fluids"].items())
                pool += sum(SOLID_FUEL.get(k, 0) * n for k, n in r["in_solids"].items())
                pool += step_energy(r)
                earned = sum(eff.get(o, 0.0) * v / BUCKET
                             for o, v in r["out_fluids"].items() if o in market)
                per_bucket = max(0.0, pool - earned) * BUCKET / vol
                if best is None or per_bucket < best:
                    best = per_bucket
            if best is not None and abs(best - eff.get(f, 0.0)) > 1:
                eff[f] = best
                changed = True
        if not changed:
            break
    return market, eff


def main() -> int:
    ap = argparse.ArgumentParser(description="石化燃料热值账本")
    ap.add_argument("--fluid", default=None, help="只查某个流体")
    a = ap.parse_args()

    heat, recipes = collect()
    if not heat:
        print("没解析到燃烧配方，检查 FILES 路径。")
        return 1
    market, eff = book_values(heat, recipes)

    if a.fluid:
        f = a.fluid
        print(f"=== {f} ===")
        print(f"市场热值: {market.get(f, 0):,.0f} EU/桶" if f in market
              else f"不可燃 → 账面热值 {eff.get(f, 0):,.0f} EU/桶")
        print("出现于:")
        for r in recipes:
            if f in r["in_fluids"] or f in r["out_fluids"]:
                tag = "出" if f in r["out_fluids"] else "入"
                v = (r["out_fluids"].get(f) or r["in_fluids"].get(f, 0)) / BUCKET
                print(f"  [{tag}] {v:g} 桶  {r['_file']} :: {r['_name']}  ({r['type']})")
        return 0

    print("=" * 100)
    print("流体热值表（每桶 = 1000 mB）")
    print("=" * 100)
    print(f"{'流体':<40}{'TR power':>9}{'EU/桶':>11}{'OR time':>9}{'FE/桶':>11}{'偏差':>7}  口径")
    print("-" * 100)
    for f in sorted(set(list(heat) + [x for x in eff if eff.get(x)])):
        e = heat.get(f, {})
        tr = e.get("tr")
        orv = e.get("or")
        dev = f"{(orv/tr - 1)*100:+.0f}%" if (tr and orv) else ""
        basis = "市场" if f in market else "账面"
        print(f"{f:<40}{(f'{tr/TR_EU_PER_BUCKET_PER_POWER:.0f}' if tr else '—'):>9}"
              f"{(f'{tr:,.0f}' if tr else '—'):>11}"
              f"{(f'{orv/(10*OR_FUELGEN_FE_PER_TICK):.0f}' if orv else '—'):>9}"
              f"{(f'{orv:,.0f}' if orv else '—'):>11}{dev:>7}  {basis}")

    print()
    print("=" * 100)
    print("逐步热值收支 —— 准则：Δ = 产出 − 投入 − 本步能耗，作者标定为 Δ ≈ +4k")
    print("  （只列产出至少一种可燃流体的步骤；投入/产出按「市场热值优先，否则账面热值」计价）")
    print("=" * 100)
    print(f"{'配方':<46}{'投入':>10}{'产出':>10}{'能耗':>8}{'Δ':>10}  判定")
    print("-" * 100)
    bad = []
    # 某流体若还被别的加工配方当原料消耗，说明它是化工原料而非终端燃料；
    # 把它转出去的那一步倒亏是「燃料换材料」的合理代价，不该算作燃料链缺陷。
    feedstock_of: dict[str, list[str]] = {}
    for r in recipes:
        if r["type"] in GENERATORS:
            continue
        for f in r["in_fluids"]:
            feedstock_of.setdefault(f, []).append(r["_name"])

    for r in recipes:
        if r["type"] in GENERATORS:
            continue
        if not any(f in market for f in r["out_fluids"]):
            continue
        hin = sum(eff.get(i, 0.0) * v / BUCKET for i, v in r["in_fluids"].items())
        hin += sum(SOLID_FUEL.get(k, 0) * n for k, n in r["in_solids"].items())
        hout = sum(eff.get(f, 0.0) * v / BUCKET for f, v in r["out_fluids"].items())
        hout += sum(SOLID_FUEL.get(k, 0) * n for k, n in r["out_solids"].items())
        e = step_energy(r)
        d = hout - hin - e
        mark = "✓ 小赚"
        if d < 0:
            is_feed = any(f in market and f in feedstock_of for f in r["out_fluids"])
            mark = "✗ 倒亏·材料步" if is_feed else "✗ 倒亏·燃料线"
            bad.append((r["_name"], r["_file"], d, is_feed))
        elif d < TARGET_MARGIN:
            # 作者注释明确允许「不亏/小亏」：Δ ∈ [0, +4k) 是合法标定，只有 Δ<0 违反原则。
            mark = "○ 不亏"
        print(f"{r['_name'][:45]:<46}{hin:>10,.0f}{hout:>10,.0f}{e:>8,.0f}{d:>10,.0f}  {mark}")

    fuel_bad = [x for x in bad if not x[3]]
    mat_bad = [x for x in bad if x[3]]
    print()
    if fuel_bad:
        print(f"⚠ {len(fuel_bad)} 条燃料线倒亏（需处理）：")
        for nm, fn, d, _ in fuel_bad:
            print(f"   {d:>11,.0f}  {fn} :: {nm}")
    if mat_bad:
        print(f"· {len(mat_bad)} 条材料步倒亏（把燃料转成化工原料的代价，正常）：")
        for nm, fn, d, _ in mat_bad:
            print(f"   {d:>11,.0f}  {fn} :: {nm}")
    if not fuel_bad:
        print("✓ 没有燃料产线倒亏。")
    return 1 if fuel_bad else 0


if __name__ == "__main__":
    sys.exit(main())
