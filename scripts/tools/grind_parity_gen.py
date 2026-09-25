"""磨粉机配方互通生成器

范围（v2）：**只做小磨粉对** —— OR 粉碎机 pulverizer (32 FE/t) ↔ TR 磨粉机 grinder。
工业研磨（TR industrial_grinder / OR grinder-Fragmenting）不参与互通。

规则：
  · 只考虑**恰好 1 个输出**的配方。带副产的多输出配方不参与互通 ——
    副产物是工业磨粉机的职责，小磨粉保持干净的 1 进 1 出。
  · 缺口判定：同一输入下，若一侧某条配方的【产出物品】在另一侧不存在，则补齐该条。
    仅"产出数量不同"不算缺口 —— uni.zs 已定 OR 为下位、TR 为上位，数量差是分层设计。
  · 等能耗换算：移到 TR 磨粉机 → power = 32（对齐 OR 粉碎机），time 不变；
                移到 OR 粉碎机 → time = P×T / 32。

被忽略的多输出配方会在末尾列出（仅供人工判断，本生成器不删它们）。
"""
import re
import sys
from collections import defaultdict
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import fuel_ledger as L

RATE = 32                     # OR 粉碎机 FE/t
OR_M, TR_M = "oritech:pulverizer", "techreborn:grinder"
SKIP = re.compile(r"^(oritech:recyclable/)|(_material|_template)$")


def objs(seg):
    out, i = [], 1
    while i < len(seg) - 1:
        if seg[i] == "{":
            e = L.match_pair(seg, i)
            out.append(seg[i:e + 1])
            i = e + 1
        else:
            i += 1
    return out


def parse(name, body, machine):
    ins = []
    sp = L.array_span(body, "ingredients")
    if sp:
        for o in objs(body[sp[0]:sp[1] + 1]):
            mi = re.search(r'\bitem:\s*"([^"]+)"', o)
            mt = re.search(r'\btag:\s*"([^"]+)"', o)
            if mi and not SKIP.search(mi.group(1)):
                ins.append(("item", mi.group(1)))
            elif mt:
                ins.append(("tag", mt.group(1)))
    osp = L.array_span(body, "outputs") or L.array_span(body, "results")
    outs = []
    if osp:
        for o in objs(body[osp[0]:osp[1] + 1]):
            m = re.search(r'id:\s*"([^"]+)"\s*,\s*count:\s*(\d+)', o)
            if m:
                outs.append((m.group(1), int(m.group(2)), o))
    tm = re.search(r"\btime:\s*(\d+)", body)
    pw = re.search(r"\bpower:\s*(\d+)", body)
    return dict(name=name, machine=machine, ins=ins, outs=outs,
                time=int(tm.group(1)) if tm else None,
                power=int(pw.group(1)) if pw else None)


dump = L.strip_comments(Path("scripts/!recipedump.txt").read_text(encoding="utf-8"))
all_recs, ignored = [], []
for name, body in L.iter_recipes(dump):
    ty = re.search(r'type:\s*"([^"]+)"', body)
    if not ty or ty.group(1) not in (OR_M, TR_M):
        continue
    r = parse(name, body, ty.group(1))
    if len(r["outs"]) == 1:
        all_recs.append(r)
    elif len(r["outs"]) > 1:
        ignored.append(r)

coverage = defaultdict(lambda: defaultdict(set))   # machine -> 输入key -> 可产出物品集合（只统计 1 输出配方）
for r in all_recs:
    for k in r["ins"]:
        coverage[r["machine"]][k].update(o[0] for o in r["outs"])

lines, added = [], {"to_TR": 0, "to_OR": 0}

# ── 机器输出槽限制 ────────────────────────────────────────────────────────────
# TR 磨粉机只有 1 个输出槽：任何输出数 > 1 的配方在执行时都会 NPE
# （CrTNOTE §1.1 第 6 条：超出槽位不会有编译错误，但配方执行就 NPE）。
# 因此两台小磨粉上一律不允许存在多输出配方 —— 先全部移除，再按 1 输出规则互通。
# 注意：这条规则是"执行期炸弹"，编译期/RECIPE DUMP 都看不出来。
removals = [r["name"] for r in ignored if r["machine"] in (OR_M, TR_M)]
for r in ignored:
    if r["machine"] in (OR_M, TR_M):
        lines.append(
            f'// 多输出配方，TR 磨粉机只有 1 个输出槽 → 执行必 NPE，移除。'
            f'（输入 {" ".join(v for _, v in r["ins"])}）\n'
            f'<recipetype:{r["machine"]}>.removeByName("{r["name"]}");'
        )

for r in all_recs:
    other = TR_M if r["machine"] == OR_M else OR_M
    mine = {o[0] for o in r["outs"]}
    for k in r["ins"]:
        if mine <= coverage[other].get(k, set()):
            continue
        cond = ", ".join(('{item: "%s"}' if kk == "item" else '{tag: "%s"}') % v for kk, v in r["ins"])
        out_txt = r["outs"][0][2]
        short = re.sub(r"[^a-z0-9_]+", "_", r["name"].split(":", 1)[-1])
        if other == TR_M:
            head, extra = "outputs", f"power: 32, time: {r['time'] or 100}, "
            added["to_TR"] += 1
        else:
            head, extra = "results", f"time: {max(1, round(((r['power'] or 2) * (r['time'] or 100)) / RATE))}, "
            added["to_OR"] += 1
        lines.append(
            f'<recipetype:{other}>.addJsonRecipe("grind.parity.{short}", {{type: "{other}",\n'
            f'    {head}: [\n        {out_txt}\n    ],\n'
            f'    {extra}ingredients: [{cond}]\n'
            f'}});'
        )
        coverage[other].setdefault(k, set()).update(mine)
        break

header = """// ============================================================
// 磨粉机配方互通（小磨粉：OR 粉碎机 ↔ TR 磨粉机）
// ============================================================
// 目的：同一个输入不该因为"用哪台机器"而拿不到某个产物。
//   典型：末影珍珠 —— OR 粉碎机出 oritech:enderic_compound（Oritech 的 machine_core_4、
//   喷气背包都要它），而 TR 磨粉机原本只出 ender_pearl_dust，只造 TR 机器的玩家会卡进度。
//
// 规则：
//   · 只做小磨粉对。工业研磨（TR 工业磨粉机 / OR 碎裂机）不参与互通。
//   · **机器输出槽限制**：TR 磨粉机只有 1 个输出槽，输出数 > 1 的配方执行必 NPE
//     （CrTNOTE §1.1 第 6 条），所以两台小磨粉上一律不允许有多输出配方 ——
//     文件开头先把原有的多输出配方全部 removeByName，再按 1 输出规则互通。
//   · 只补"另一侧完全做不出来的产物"；仅产出**数量**不同不算缺口
//     （uni.zs 已定 OR 为下位、TR 为上位，数量差是分层设计）。
//   · 等能耗移植：移到 TR 用 power 32（对齐 OR 粉碎机），移到 OR 用 P×T/32 折算 time。
//
// 由 scripts/tools/grind_parity_gen.py 生成，改完原配方重跑即可。
// ============================================================

"""

Path("scripts/grinder_parity.zs").write_text(header + "\n".join(lines) + "\n", encoding="utf-8")

print("=== 生成结果 ===")
print(f"  参与互通的 1 输出配方：OR 粉碎机 {sum(1 for r in all_recs if r['machine']==OR_M)} 条 / "
      f"TR 磨粉机 {sum(1 for r in all_recs if r['machine']==TR_M)} 条")
print(f"  补齐：→ TR 磨粉机 {added['to_TR']} 条，→ OR 粉碎机 {added['to_OR']} 条，"
      f"合计 {added['to_TR'] + added['to_OR']}")
print(f"  已写出 scripts/grinder_parity.zs（{len(lines)} 条配方）")
print()
print(f"=== 已移除的多输出配方（{len(removals)} 条；TR 磨粉机只有 1 个输出槽，执行必 NPE）===")
for r in ignored:
    if r["machine"] in (OR_M, TR_M):
        ins = ", ".join(v for _, v in r["ins"])
        outs = ", ".join(f"{i}x{c}" for i, c, _ in r["outs"])
        print(f"  {r['machine']:<22} {ins:<26} -> {outs}")

assert all(len(r["outs"]) == 1 for r in all_recs), "存在多输出源配方，会生成 NPE 配方"
print()
print("  ⚠ 提示：这 5 条原是 OR 粉碎机唯一的原矿处理配方。移除后 OR 粉碎机不再能处理")
print("     c:raw_materials/* —— 若 T1 阶段需要该能力，得另立 1 输出的原矿配方。")
