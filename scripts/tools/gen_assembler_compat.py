#!/usr/bin/env python3
"""精密组装机 ← Oritech 装配机 配方兼容生成器。

背景
----
本包维护的 TechReborn（`TechReborn-5.12.13-cmrh-preview`）让
`techreborn:precise_assembler` 能读 `oritech:assembler` 配方类型。
但为了让 EMI 里两种机器都能直接列出配方、并统一「0.8× 耗时」的手感，
这里把 OR 装配配方逐条复制成 precise_assembler 原生配方。

> 这段以前是**手工粘贴**出来的（precision_assembly.zs 里的
> `converted.oritech.assembler/*` 那 24 条），本脚本取代它。

转换规则
--------
（逐条反推自既有手工集，24/24 吻合）

  · `results` → `outputs`
  · `type`    → `techreborn:precise_assembler`
  · `time`    → **round(OR time × 0.8)**；缺 time 按 OR 默认 60 ⇒ 48
  · `power`   → 128

来源
----
**Oritech jar 的 `data/oritech/recipe/assembler/*.json`**（现行权威，28 条）。
不用 `scripts/!recipedump.txt` —— 那是过期快照。

跳过规则
--------
包内若已 `removeByName("oritech:assembler/<name>")`，则该条**不转换**。
现状命中 4 条：
  · magnet / motor        —— 本包在 t1.zs 另建了替代配方
  · processingunit        —— 本包直接移除
  · reactorplatingalt     —— 本包直接移除
⇒ 28 − 4 = 24 条，正好等于手工集。

槽位约束（已确认）
------------------
precise_assembler：**16 进 / 4 出**。OR 装配配方最多 4 进 1 出，全部放得下；
超出时脚本会报错而不是静默产出坏配方。

用法
----
    python3 scripts/tools/gen_assembler_compat.py           # 生成
    python3 scripts/tools/gen_assembler_compat.py --check   # 只报告
"""
from __future__ import annotations

import json
import re
import sys
import zipfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
SCRIPTS = ROOT / "scripts"
OUT = SCRIPTS / "generated" / "assembler_compat.zs"

POWER = 128
TIME_MULT = 0.8
DEFAULT_OR_TIME = 60          # Oritech 配方缺 time 时的默认值
MAX_IN, MAX_OUT = 16, 4       # precise_assembler 槽位上限


def round_half_up(x: float) -> int:
    """四舍五入。24 条样本里没有 .5 边界，所以 round/floor(x+.5) 等价。"""
    return int(x + 0.5)


def load_or_recipes() -> dict[str, dict]:
    """从 Oritech jar 读装配机配方（权威来源）。"""
    jars = sorted((ROOT / "mods").glob("oritech*.jar"))
    if not jars:
        raise SystemExit("!! 找不到 oritech jar")
    out: dict[str, dict] = {}
    with zipfile.ZipFile(jars[0]) as z:
        for n in z.namelist():
            if "/recipe/assembler/" not in n or not n.endswith(".json"):
                continue
            d = json.loads(z.read(n))
            if d.get("type") != "oritech:assembler":
                continue
            out[Path(n).stem] = d
    return out


def removed_by_pack() -> set[str]:
    """包内被 removeByName 掉的 oritech:assembler/<name>。"""
    gone: set[str] = set()
    for f in sorted(SCRIPTS.rglob("*.zs")):
        t = f.read_text(encoding="utf-8", errors="ignore")
        gone |= set(re.findall(r'removeByName\(\s*"oritech:assembler/([^"]+)"\s*\)', t))
    return gone


def zs_ingredient(o: dict) -> str | None:
    if "item" in o:
        c = o.get("count", 1)
        return f'{{item: "{o["item"]}"{f", count: {c}" if c != 1 else ""}}}'
    if "tag" in o:
        c = o.get("count", 1)
        return f'{{tag: "{o["tag"]}"{f", count: {c}" if c != 1 else ""}}}'
    return None


def convert(name: str, rec: dict) -> tuple[str, list[str]] | None:
    """返回 (zenscript 块, 警告列表)；无法转换返回 None。"""
    warn: list[str] = []
    ings = [zs_ingredient(i) for i in rec.get("ingredients", [])]
    if any(i is None for i in ings):
        return None
    outs = []
    for r in rec.get("results", []):
        if "id" not in r:
            return None
        outs.append(f'        {{id: "{r["id"]}", count: {r.get("count", 1)}}}')

    if len(ings) > MAX_IN:
        warn.append(f"{name}: 输入 {len(ings)} > 上限 {MAX_IN}")
    if len(outs) > MAX_OUT:
        warn.append(f"{name}: 输出 {len(outs)} > 上限 {MAX_OUT}")

    t = round_half_up(rec.get("time", DEFAULT_OR_TIME) * TIME_MULT)
    ing_body = "\n".join(f"        {i}," for i in ings)
    out_body = "\n".join(f"{o}," for o in outs)
    block = (
        f'<recipetype:techreborn:precise_assembler>.addJsonRecipe('
        f'"converted.oritech.assembler/{name}", {{type: "techreborn:precise_assembler",\n'
        f"    outputs: [\n{out_body}\n    ],\n"
        f"    time: {t}, power: {POWER},\n"
        f"    ingredients: [\n{ing_body}\n    ]\n"
        f"}});"
    )
    return block, warn


def main() -> int:
    check = "--check" in sys.argv
    ors = load_or_recipes()
    gone = removed_by_pack()

    skipped = sorted(set(ors) & gone)
    todo = sorted(set(ors) - gone)

    blocks, warns = [], []
    for n in todo:
        r = convert(n, ors[n])
        if r is None:
            warns.append(f"{n}: 结构无法识别，已跳过")
            continue
        blocks.append(r[0])
        warns += r[1]

    print(f"Oritech 装配机配方（jar）: {len(ors)}")
    print(f"被包 removeByName 跳过: {len(skipped)}  {skipped}")
    print(f"转换: {len(blocks)}")
    if warns:
        print("\n⚠ 警告：")
        for w in warns:
            print(f"  · {w}")

    header = (
        "// ============================================================\n"
        "// 【自动生成 · 请勿手改】\n"
        "// 由 scripts/tools/gen_assembler_compat.py 生成。\n"
        "//\n"
        "// 把 Oritech 装配机（oritech:assembler）配方逐条复制为 TR 精密组装机配方，\n"
        "// 使 EMI 里两台机器都能直接看到配方，并统一 0.8× 耗时。\n"
        "//\n"
        "// 转换规则：results→outputs、type→techreborn:precise_assembler、\n"
        "//           time = round(OR time × 0.8)（缺省按 OR 默认 60 ⇒ 48）、power = 128\n"
        "// 来源：Oritech jar 的 data/oritech/recipe/assembler/*.json（不是过期 recipedump）\n"
        "// 跳过：包内已 removeByName(\"oritech:assembler/<name>\") 的条目\n"
        "// ============================================================\n\n"
    )
    text = header + "\n\n".join(blocks) + "\n"

    if check:
        print(f"\n（--check：未写文件，将输出 {len(blocks)} 条到 {OUT.relative_to(ROOT)}）")
        return 1 if warns else 0

    OUT.parent.mkdir(parents=True, exist_ok=True)
    OUT.write_text(text, encoding="utf-8")
    print(f"\n已写入 {OUT.relative_to(ROOT)}（{len(blocks)} 条）")
    return 1 if warns else 0


if __name__ == "__main__":
    sys.exit(main())
