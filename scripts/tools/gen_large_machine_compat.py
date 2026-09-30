"""把 OR 的「流体离心 / 精炼厂」配方复制一份给 TR 的 large_mixer / large_refinery。

背景
----
TechReborn 5.12.13（cmrh-preview）新增了两台多方块机器：
  · techreborn:large_mixer    —— 4 进 6 出
  · techreborn:large_refinery —— 4 进 6 出
两者都继承 FourInSixOutMachineBlockEntity，配方类型是 RebornRecipe
（只有 ingredients / outputs / power / time 四个字段，**没有原生流体字段**），
所以流体必须用带 techreborn:fluid 组件的单元表示。

转换规则（来自需求）
--------------------
1. 逐条复制 OR `oritech:centrifuge_fluid` → `techreborn:large_mixer`，
   OR `oritech:refinery` → `techreborn:large_refinery`。
2. OR 的流体量不保证是 1000mB 的整数倍（81000 OR 单位 = 1000mB）。
   于是把整条配方**翻倍 m 次**（时间、物品进出、流体进出一起翻），
   直到所有流体量都是 1000mB 的整数倍：
       m = LCM over 每个量 a of ( 81000 / gcd(a, 81000) )
3. 翻倍后每个 81000 折成 **1 个单元**，并补齐空单元保证 cell 守恒。
   注意 OR 配方里存在三种「单元」形态，必须分别对待：
       a) fluidInput / fluidOutputs          —— 流体，折成单元
       b) 带 techreborn:fluid 组件的 ingredients —— **装满液体的单元当作物品输入**
          （例：oil.process.or.nitric_acid 的「水单元」），必须保留流体组件
       c) 纯 techreborn:cell                  —— 空单元
4. 奖励：耗时 ×0.8，耗能 ×0.5。
   能耗基准按本包 precision_assembly.zs 的既有换算 FE→EU 取 1:1，
   OR 侧 centrifuge 64 FE/t、refinery 128 FE/t  ⇒  TR 侧 power 32 / 64。
"""
import re
import sys
from collections import Counter
from math import gcd
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
SCRIPTS = ROOT / "scripts"
OUT = SCRIPTS / "large_machine_compat.zs"

sys.path.insert(0, str(HERE))
import fuel_ledger as L  # noqa: E402

BUCKET = 81000            # OR 流体单位：81000 = 1000 mB
TIME_BONUS = 0.8
POWER_BONUS = 0.5
OR_POWER = {"oritech:centrifuge_fluid": 64, "oritech:refinery": 128}
MACHINE = {"oritech:centrifuge_fluid": ("techreborn:large_mixer", "large.mixer"),
           "oritech:refinery": ("techreborn:large_refinery", "large.refinery")}
MAX_IN, MAX_OUT = 4, 6

# 已知坏数据：40005 不是 81 的整数倍（=493.89 mB），按作者原意当作 40500（500mB）。
# 只修 TR 副本，不动 OR 源配方。
BAD_AMOUNT = {("oil.other.or.centrifuge_oilsand_low", "techreborn:oil"): 40500}


# ── 解析 ──────────────────────────────────────────────────────────────────────
def objs(seg):
    """取数组片段里的顶层 {...} 对象（与 audit_recipes.py 的同名函数一致）。"""
    out, i = [], 1
    while i < len(seg) - 1:
        if seg[i] == "{":
            e = L.match_pair(seg, i)
            out.append(seg[i:e + 1])
            i = e + 1
        else:
            i += 1
    return out


def entries(body, key):
    """把某个数组解析成 [{...}]，保留 item/tag/id/fluid/count/amount 与单元流体组件。"""
    sp = L.array_span(body, key)
    if not sp:
        return []
    out = []
    for o in objs(body[sp[0]:sp[1] + 1]):
        d = {}
        for f in ("item", "tag", "id", "fluid"):
            m = re.search(r'\b' + f + r':\s*"([^"]+)"', o)
            if m:
                d[f] = m.group(1)
        cf = re.search(r'components:\s*\{\s*"techreborn:fluid"\s*:\s*"([^"]+)"\s*\}', o)
        if cf:
            d["cellfluid"] = cf.group(1)
        n = re.search(r'\bcount:\s*(\d+)', o)
        a = re.search(r'\bamount:\s*(\d+)', o)
        d["count"] = int(n.group(1)) if n else 1
        if a:
            d["amount"] = int(a.group(1))
        out.append(d)
    return out


def fluid_input(body):
    m = re.search(r'fluidInput:\s*\{', body)
    if not m:
        return None
    s = body.index("{", m.start())
    seg = body[s:L.match_pair(body, s) + 1]
    fl = re.search(r'fluid:\s*"([^"]+)"', seg)
    if not fl:
        return None
    am = re.search(r'amount:\s*(\d+)', seg)
    return {"fluid": fl.group(1), "amount": int(am.group(1)) if am else 0}


def multiplier(amounts):
    m = 1
    for a in amounts:
        if not a:
            continue
        need = BUCKET // gcd(a, BUCKET)
        m = m * need // gcd(m, need)
    return m


# ── 渲染 ──────────────────────────────────────────────────────────────────────
def cell_in(fluid, n):
    return ('{count: %d, components: {"techreborn:fluid": "%s"}, '
            'base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}' % (n, fluid))


def cell_out(fluid, n):
    return '{id: "techreborn:cell", count: %d, components: {"techreborn:fluid": "%s"}}' % (n, fluid)


def convert(name, body, rtype):
    tgt, prefix = MACHINE[rtype]
    mt = re.search(r'\btime:\s*(\d+)', body)
    if not mt:
        return None, "无 time 字段"
    time = int(mt.group(1))

    fin = fluid_input(body)
    fouts = [x for x in entries(body, "fluidOutputs") if "fluid" in x]
    ing = entries(body, "ingredients")
    res = [x for x in entries(body, "results") if "id" in x]

    if fin:
        fin["amount"] = BAD_AMOUNT.get((name, fin["fluid"]), fin["amount"])
    for f in fouts:
        f["amount"] = BAD_AMOUNT.get((name, f["fluid"]), f["amount"])

    amts = ([fin["amount"]] if fin else []) + [f["amount"] for f in fouts]
    m = multiplier(amts)
    if m > 64:
        return None, f"翻倍倍数 {m} 过大，疑似数据错误"

    # ---- 输入侧 ----
    ins, plain_ins = [], []
    cells_in = 0                                  # 满单元数（流体输入 + 满单元物品输入）
    empties_in = 0                                # 显式空单元输入
    if fin and fin["amount"]:
        cells_in += fin["amount"] * m // BUCKET
        ins.append(cell_in(fin["fluid"], fin["amount"] * m // BUCKET))
    for x in ing:
        c = x["count"] * m
        cf = x.get("cellfluid")
        if cf and cf != "minecraft:empty":        # (b) 满单元当物品输入 —— 保留流体组件
            cells_in += c
            ins.append(cell_in(cf, c))
        elif cf == "minecraft:empty":             # (c) 显式空单元
            empties_in += c
            ins.append(cell_in("minecraft:empty", c))
        elif "tag" in x:
            plain_ins.append('{tag: "%s", count: %d}' % (x["tag"], c))
        elif "item" in x:
            plain_ins.append('{item: "%s", count: %d}' % (x["item"], c))

    # ---- 输出侧 ----
    outs, plain_outs = [], []
    cells_out = 0                                 # 满单元数
    empties_out = 0                               # 空单元产出
    for x in res:
        c = x["count"] * m
        cf = x.get("cellfluid")
        if cf and cf != "minecraft:empty":
            cells_out += c
            outs.append(cell_out(cf, c))
        elif x["id"] == "techreborn:cell":        # 空单元产物
            empties_out += c
            outs.append('{id: "techreborn:cell", count: %d}' % c)
        else:
            plain_outs.append('{id: "%s", count: %d}' % (x["id"], c))
    for f in fouts:
        n = f["amount"] * m // BUCKET
        if n:
            cells_out += n
            outs.append(cell_out(f["fluid"], n))

    # ---- cell 配平守恒（把 OR 自带的空单元也计入两侧）----
    balanced = ins + plain_ins
    balanced_out = outs + plain_outs
    total_in = cells_in + empties_in
    total_out = cells_out + empties_out
    if total_in > total_out:                      # 入多出少 → 产出侧补空单元
        balanced_out.append('{id: "techreborn:cell", count: %d}' % (total_in - total_out))
    elif total_out > total_in:                    # 出多入少 → 输入侧补空单元
        balanced.append(cell_in("minecraft:empty", total_out - total_in))

    if len(balanced) > MAX_IN:
        return None, f"输入 {len(balanced)} 项 > {MAX_IN}"
    if len(balanced_out) > MAX_OUT:
        return None, f"输出 {len(balanced_out)} 项 > {MAX_OUT}"

    tf = time * TIME_BONUS * m
    if abs(tf - round(tf)) > 1e-9:
        return None, f"耗时非整数 {tf}"

    rname = f"{prefix}.{name}"
    txt = ('<recipetype:%s>.addJsonRecipe("%s", {type: "%s",\n'
           '    time: %d,\n'
           '    power: %d,\n'
           '    outputs: [\n        %s\n    ],\n'
           '    ingredients: [\n        %s\n    ]\n'
           '});' % (tgt, rname, tgt, int(round(tf)), int(OR_POWER[rtype] * POWER_BONUS),
                    ",\n        ".join(balanced_out), ",\n        ".join(balanced)))
    return (rname, txt, m, len(balanced), len(balanced_out)), None


def main() -> int:
    recipes, seen = [], set()
    for f in sorted(SCRIPTS.glob("*.zs")):
        if f.name == OUT.name:
            continue
        t = L.strip_comments(f.read_text(encoding="utf-8"))
        for n, b in L.iter_recipes(t):
            rt = re.search(r'type:\s*"([^"]+)"', b)
            if rt and rt.group(1) in MACHINE and n not in seen:
                seen.add(n)
                recipes.append((n, b, rt.group(1), f.name))

    blocks, skipped = [], []
    for name, body, rtype, src in recipes:
        got, err = convert(name, body, rtype)
        if err:
            skipped.append((name, err))
            continue
        blocks.append((rtype, got, src))

    head = f'''// ============================================================
// OR → TR 大型机器兼容层（由 scripts/tools/gen_large_machine_compat.py 生成，勿手改）
// ============================================================
// TechReborn 5.12.13 新增两台多方块机器，都是 4 进 6 出，
// 配方类型为 RebornRecipe（无原生流体字段，流体走 techreborn:fluid 组件单元）：
//   oritech:centrifuge_fluid  →  techreborn:large_mixer     (power 32)
//   oritech:refinery          →  techreborn:large_refinery  (power 64)
//
// 转换规则：OR 流体量不是 1000mB 整数倍时，整条配方翻倍 m 次
//   （时间 / 物品进出 / 流体进出一起翻）直到全部凑整，再把每个 1000mB 折成 1 个单元。
//   cell 守恒：入侧满单元多则在产出侧补空单元，反之在输入侧补。
//   ⚠ OR 配方里「装满液体的单元」是以物品形态出现在 ingredients 里的
//     （例：oil.process.or.nitric_acid 的水单元），转换时保留其流体组件。
//   奖励：耗时 ×0.8、耗能 ×0.5（FE→EU 按 1:1，基准见 precision_assembly.zs）。
//
// 共 {len(blocks)} 条；OR 原配方保留不动，本文件只做「复制一份给 TR」。
// ============================================================

'''

    OUT.write_text(head + "\n\n".join(b[1][1] for b in blocks) + "\n", encoding="utf-8")

    ms = Counter(b[1][2] for b in blocks)
    print(f"源配方 {len(recipes)} 条 → 生成 {len(blocks)} 条，跳过 {len(skipped)} 条")
    print("  机器分布:", dict(Counter(b[0] for b in blocks)))
    print("  翻倍倍数:", dict(sorted(ms.items())))
    print("  槽位项数: 输入 max %d / 输出 max %d（上限 %d / %d）"
          % (max(b[1][3] for b in blocks), max(b[1][4] for b in blocks), MAX_IN, MAX_OUT))
    for n, e in skipped:
        print("  跳过:", n, "→", e)
    print(f"\n已写入 {OUT}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
