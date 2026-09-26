#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""方案 A：把 T1.5c 重结晶的试剂从硫酸改为水，把 T2a 浓缩的试剂从硫酸改为氢氧化钠溶液。

只在对应配方块内部替换，避免误伤 T1.5a 酸浸（应保留硫酸）与其他用到硫酸 cell 的步骤。
"""
import re
import pathlib
import sys

HERE = pathlib.Path(__file__).resolve().parent
ZS = HERE.parent / "general_ore_process.zs"

OLD_LEACH = 'fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 40500}'
NEW_LEACH = 'fluidInput: {fluid: "minecraft:water", amount: 40500}'

OLD_CELL = '{"techreborn:fluid": "oritech:still_sulfuric_acid"}'
NEW_CELL = '{"techreborn:fluid": "jsonreg:sodium_hydroxide_solution"}'


def main() -> None:
    txt = ZS.read_text(encoding="utf-8")
    blocks = re.split(r"(?=<recipetype:)", txt)

    n_t15c = 0
    n_t2a = 0
    out = []
    for b in blocks:
        head = b[:300]
        if "t15c.recrystallize" in head:
            if OLD_LEACH not in b:
                print(f"!! t15c 块未找到预期硫酸输入: {head[:80]}")
                sys.exit(1)
            b = b.replace(OLD_LEACH, NEW_LEACH)
            n_t15c += 1
        elif "t2a.concentrate" in head:
            if OLD_CELL not in b:
                print(f"!! t2a 块未找到预期硫酸 cell: {head[:80]}")
                sys.exit(1)
            b = b.replace(OLD_CELL, NEW_CELL)
            n_t2a += 1
        out.append(b)

    new_txt = "".join(out)

    # 残留检查
    stray = [
        (new_txt[: m.start()].count("\n") + 1, new_txt[m.start(): m.start() + 60])
        for m in re.finditer(re.escape(OLD_LEACH), new_txt)
    ]
    print(f"t15c 改写: {n_t15c} 条  (硫酸 -> 水)")
    print(f"t2a  改写: {n_t2a} 条  (硫酸 -> 氢氧化钠溶液)")
    print(f"残留 40500 硫酸: {len(stray)} 处 {stray}")
    print(f"文件 {len(txt)} -> {len(new_txt)} 字节")

    if n_t15c != 17 or n_t2a != 17:
        print("!! 数量不是 17，未写入")
        sys.exit(1)
    if len(stray) != 0:
        print("!! 仍有残留，未写入")
        sys.exit(1)

    # 统计新的试剂使用
    for tag, fl in (("t15a.leach", "oritech:still_sulfuric_acid"),
                    ("t15c.recrystallize", "minecraft:water"),
                    ("t2a.concentrate", "jsonreg:sodium_hydroxide_solution")):
        c = sum(1 for b in new_txt.split("<recipetype:") if tag in b[:300] and fl in b)
        print(f"  校验 {tag:22s} 用 {fl}: {c}")

    ZS.write_text(new_txt, encoding="utf-8")
    print("已写入", ZS)


if __name__ == "__main__":
    main()
