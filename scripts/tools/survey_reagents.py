#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""调查 general_ore_process.zs 中指定步骤的试剂（流体输入）使用情况。"""
import re
import pathlib
import sys

HERE = pathlib.Path(__file__).resolve().parent
ZS = HERE.parent / "general_ore_process.zs"

TAGS = sys.argv[1:] or ["t15a.leach", "t15c.recrystallize", "t2a.concentrate"]


def main() -> None:
    txt = ZS.read_text(encoding="utf-8")
    blocks = re.split(r"(?=<recipetype:)", txt)
    for tag in TAGS:
        print("=" * 70)
        print(tag)
        print("=" * 70)
        rows = []
        for b in blocks:
            head = b[:300]
            if tag not in head:
                continue
            m = re.search(r'addJsonRecipe\("([^"]+)"', b)
            name = m.group(1) if m else "?"
            # fluidInput 可以是 {fluid: "x", amount: N}
            fi = re.findall(
                r'fluidInput:\s*\{\s*fluid:\s*(?:\{fluid:\s*)?"([^"]+)"',
                b,
            )
            amt = re.findall(r'fluidInput:.*?amount:?\s*\{?value:?\s*\}?:?\s*(\d+)', b, re.S)
            # 桶装 cell 形式的输入
            cells = re.findall(
                r'components:\s*\{"techreborn:fluid":\s*"([^"]+)"\}', b
            )
            reagents = fi + [c + " (cell)" for c in cells]
            rows.append((name, reagents))
        for name, reagents in sorted(rows):
            print(f"  {name:46s} <- {reagents}")
        # 统计
        from collections import Counter
        cnt = Counter(r for _, rs in rows for r in rs)
        print(f"  -- 共 {len(rows)} 条；试剂分布: {dict(cnt)}")


if __name__ == "__main__":
    main()
