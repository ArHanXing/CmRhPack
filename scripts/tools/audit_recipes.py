"""配方审计：把"执行期炸弹"类问题在写脚本阶段就查出来。

三类已知炸弹（全部编译期不报错、只有玩家真跑配方或连服务器时才炸）：
  1. **配方名全局唯一** —— CrT 的配方名是全局 key，重名会让
     SynchronizeRecipesS2C 抛 "Multiple entries with same key"，客户端直接连不上。
  2. **机器输出槽位** —— 超出槽位数执行必 NPE（TR 磨粉机只有 1 个输出槽等）。
  3. **OR 离心机只支持大小为 1 的输入** —— count > 1 的进料配方无法正常执行。

另有若干一致性检查：清退是否命中、清退与冻结清单是否一致。

用法：python scripts/tools/audit_recipes.py
"""
import json
import re
import sys
from collections import Counter
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import fuel_ledger as L

ROOT = Path(__file__).resolve().parents[2]
SCRIPTS = ROOT / "scripts"

# 输出槽位上限（只列已考证过的机器；未列出的不检查）
OUT_SLOTS = {
    "techreborn:grinder": 1,
    "oritech:pulverizer": 1,
    "techreborn:extractor": 1,
    "oritech:centrifuge": 1,
    "oritech:centrifuge_fluid": 1,
    "techreborn:chemical_reactor": 2,
    "techreborn:industrial_grinder": 4,
    "techreborn:large_chemical_reactor": 4,
    "techreborn:distillation_tower": 6,
}
FLUID_SLOTS = {"oritech:refinery": 3}
CENTRIFUGE = ("oritech:centrifuge", "oritech:centrifuge_fluid")


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


def main() -> int:
    problems = []
    names = []
    typed = 0
    for f in sorted(SCRIPTS.glob("*.zs")):
        text = L.strip_comments(f.read_text(encoding="utf-8"))
        for n, b in L.iter_recipes(text):
            names.append((n, f.name))
            ty_m = re.search(r'type:\s*"([^"]+)"', b)
            if not ty_m:
                continue          # Lychee 等非 addJsonRecipe 结构，跳过
            typed += 1
            ty = ty_m.group(1)
            osp = L.array_span(b, "outputs") or L.array_span(b, "results")
            n_out = len(objs(b[osp[0]:osp[1] + 1])) if osp else 0
            fsp = L.array_span(b, "fluidOutputs")
            n_fluid = len(objs(b[fsp[0]:fsp[1] + 1])) if fsp else 0

            if ty in OUT_SLOTS and n_out > OUT_SLOTS[ty]:
                problems.append(f"[槽位] {f.name}::{n} 输出 {n_out} > {ty} 上限 {OUT_SLOTS[ty]}")
            if ty in FLUID_SLOTS and (n_fluid > FLUID_SLOTS[ty] or n_out > 1):
                problems.append(f"[槽位] {f.name}::{n} 流体 {n_fluid}/{ty} 上限 {FLUID_SLOTS[ty]}")
            if ty in CENTRIFUGE:
                sp = L.array_span(b, "ingredients")
                if sp:
                    for o in objs(b[sp[0]:sp[1] + 1]):
                        c = re.search(r'count:\s*(\d+)', o)
                        if c and int(c.group(1)) > 1:
                            problems.append(f"[离心机输入] {f.name}::{n} count={c.group(1)} > 1")

    # 1) 全局重名
    for n, c in Counter(x[0] for x in names).items():
        if c > 1:
            src = sorted({f for nn, f in names if nn == n})
            problems.append(f"[重名] {n} 出现 {c} 次 -> {src}")

    # 2) 清退一致性
    gen = SCRIPTS / "general_ore_process.zs"
    if gen.is_file():
        gtext = L.strip_comments(gen.read_text(encoding="utf-8"))
        g_rem = re.findall(r'removeByName\("([^"]+)"\)', gtext)
        frozen = json.loads((Path(__file__).resolve().parent /
                             "frozen_removals.json").read_text(encoding="utf-8"))
        if len(g_rem) != len(frozen):
            problems.append(f"[清退] general_ore_process.zs 有 {len(g_rem)} 条，"
                            f"冻结清单 {len(frozen)} 条 —— 不一致")
        # 跨文件重复删除会让 CrT 刷 "No recipe" 警告
        for f in sorted(SCRIPTS.glob("*.zs")):
            if f.name == gen.name:
                continue
            other = re.findall(r'removeByName\("([^"]+)"\)',
                               L.strip_comments(f.read_text(encoding="utf-8")))
            overlap = sorted(set(other) & set(g_rem))
            if overlap:
                problems.append(f"[重复清退] {f.name} 与 general_ore_process.zs 重叠 "
                                f"{len(overlap)} 条（会刷 No recipe 警告）: {overlap[:3]}")

    print(f"扫描 {len(names)} 条 addJsonRecipe（其中 {typed} 条带 type 字段）")
    if problems:
        print(f"\n发现 {len(problems)} 个问题：")
        for p in problems:
            print("  " + p)
        return 1
    print("✓ 未发现重名 / 槽位越界 / 离心机输入超限 / 清退不一致")
    return 0


if __name__ == "__main__":
    sys.exit(main())
