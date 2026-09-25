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

# 与 general_ore_process.zs 的 T1 冲突的条目：矿石入口已由 T1 统一接管，
# OR 粉碎机的矿石处理属于 T1.5，故这些镜像配方不再生成。
# （油砂 / 金红石属特殊线，保留其镜像，不在此列。）
SKIP_GENERATED = {
    "grind.parity.pulverizer_ore_platinum",          # T1 general.t1.raw_platinum 接管
    "grind.parity.pulverizer_uraniumore",            # T1 general.t1.raw_uranium 接管
    "grind.parity.grinder_emerald",                  # T1 general.t1.emerald 接管
    "grind.parity.grinder_sulfur_dust",              # T1 general.t1.sulfur 接管
    "grind.parity.oil_other_tr_normalgrind_salt",    # T1 general.t1.salt 接管
    "grind.parity.oil_other_tr_normalgrind_rocksalt",# T1 general.t1.rock_salt 接管
    # 末影珍珠：双向移植会让**同一台机器同时出** enderic_compound 与 ender_pearl_dust，
    # 在 EMI 里两条配方并排、玩家不知道该用哪条。改为各机各管一物：
    #   OR 粉碎机 → oritech:enderic_compound（本体配方 oritech:pulverizer/pearl_enderic）
    #   TR 磨粉机 → techreborn:ender_pearl_dust（本体配方 techreborn:grinder/ender_pearl）
    "grind.parity.pulverizer_pearl_enderic",
    "grind.parity.grinder_ender_pearl_dust",
}


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
skipped = set()

# ── 机器输出槽限制 ────────────────────────────────────────────────────────────
# TR 磨粉机只有 1 个输出槽：输出数 > 1 的配方在执行时都会 NPE。
# 但这 5 条多输出配方（oritech:pulverizer/raw/*）**已由 general_ore_process.zs 清退** ——
# 它按字母序先加载，且其清退正则会匹配 c:raw_materials/* 输入。
# 若这里再 removeByName 一次，CrT 会刷 5 条
#   [WARN]: No recipe with type: 'oritech:pulverizer' and name: '...'
# 故此处**不再重复删除**，仅记录。
# 注意：这条规则是"执行期炸弹"，编译期/RECIPE DUMP 都看不出来。
skipped_removals = [r["name"] for r in ignored if r["machine"] in (OR_M, TR_M)]

for r in all_recs:
    other = TR_M if r["machine"] == OR_M else OR_M
    mine = {o[0] for o in r["outs"]}
    for k in r["ins"]:
        if mine <= coverage[other].get(k, set()):
            continue
        cond = ", ".join(('{item: "%s"}' if kk == "item" else '{tag: "%s"}') % v for kk, v in r["ins"])
        out_txt = r["outs"][0][2]
        short = re.sub(r"[^a-z0-9_]+", "_", r["name"].split(":", 1)[-1])
        if f"grind.parity.{short}" in SKIP_GENERATED:
            coverage[other].setdefault(k, set()).update(mine)
            skipped.add(short)
            break
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
//     （CrTNOTE §1.1 第 6 条），所以本文件只生成单输出配方。
//     原有那 5 条多输出的 oritech:pulverizer/raw/* 已由 **general_ore_process.zs 清退**，
//     本文件不再重复 removeByName（重复删会让 CrT 刷 "No recipe" 警告）。
//   · 只补"另一侧完全做不出来的产物"；仅产出**数量**不同不算缺口
//     （uni.zs 已定 OR 为下位、TR 为上位，数量差是分层设计）。
//   · **末影珍珠例外**：双向移植会让同一台机器同时出 enderic_compound 与 ender_pearl_dust，
//     EMI 里两条并排、玩家不知选哪条。改为各机各管一物：
//       OR 粉碎机 → enderic_compound ／ TR 磨粉机 → ender_pearl_dust。
//   · 等能耗移植：移到 TR 用 power 32（对齐 OR 粉碎机），移到 OR 用 P×T/32 折算 time。
//
// ⚠ 本文件基于 !recipedump.txt 生成，而 dump 是**易变快照**（每次 /reload 后可重新导出，
//   内容会随脚本改动而变）。重跑生成器前先确认 dump 是最新的，否则会按旧状态生成。
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
if skipped:
    print(f"  因与 general_ore_process.zs 的 T1 冲突而跳过 {len(skipped)} 条：")
    for s in sorted(skipped):
        print(f"    {s}")
print()
print(f"=== 已移除的多输出配方（{len(skipped_removals)} 条；由 general_ore_process.zs 负责清退，此处不重复删）===")
for r in ignored:
    if r["machine"] in (OR_M, TR_M):
        ins = ", ".join(v for _, v in r["ins"])
        outs = ", ".join(f"{i}x{c}" for i, c, _ in r["outs"])
        print(f"  {r['machine']:<22} {ins:<26} -> {outs}")

assert all(len(r["outs"]) == 1 for r in all_recs), "存在多输出源配方，会生成 NPE 配方"
print()
print("  ⚠ 提示：这 5 条原是 OR 粉碎机唯一的原矿处理配方。移除后 OR 粉碎机不再能处理")
print("     c:raw_materials/* —— 若 T1 阶段需要该能力，得另立 1 输出的原矿配方。")
