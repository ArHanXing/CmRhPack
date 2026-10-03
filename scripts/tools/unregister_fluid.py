"""从 config/jsonreg_entries.json 里删除若干注册项（顶层数组里的对象）。

默认删除 uranyl_sulfate_solution（已被既有 uranium_solution 取代）。
文本删除而非 json.dump 重写，保持文件原有排版。
"""
import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
JSON = ROOT / "config/jsonreg_entries.json"

TARGETS = {("fluids", "uranyl_sulfate_solution")}


def array_span(text, key):
    i = text.index(f'"{key}"')
    lb = text.index("[", i)
    depth, j = 0, lb
    while j < len(text):
        if text[j] == "[":
            depth += 1
        elif text[j] == "]":
            depth -= 1
            if depth == 0:
                return lb, j
        j += 1
    raise ValueError(f"{key} 数组未闭合")


def main() -> int:
    text = JSON.read_text(encoding="utf-8")
    before = json.loads(text)
    removed = []

    for key, ident in TARGETS:
        lb, rb = array_span(text, key)
        seg = text[lb:rb + 1]
        # 匹配含 "id": "<ident>" 的那个顶层对象
        m = re.search(r'\{[^{}]*"id"\s*:\s*"%s"[^{}]*\}' % re.escape(ident), seg)
        if not m:
            print(f"  {key}: 未找到 {ident}，跳过")
            continue
        s, e = lb + m.start(), lb + m.end()
        # 连同后面的逗号/换行一起吃掉，避免留下空行或多余逗号
        tail = text[e:]
        mt = re.match(r'\s*,\s*\n', tail)
        if mt:
            e += mt.end()
        else:
            # 它是最后一项：吃掉它前面的逗号
            head = text[:s]
            mh = re.search(r',\s*\n\s*$', head)
            if mh:
                s = mh.start()
        text = text[:s] + text[e:]
        removed.append((key, ident))

    after = json.loads(text)
    ok = True
    for key, ident in removed:
        if any(e["id"] == ident for e in after[key]):
            print(f"!! {ident} 仍存在")
            ok = False
    # 其余条目顺序不变
    for key in before:
        orig = [e["id"] for e in before[key] if (key, e["id"]) not in TARGETS]
        if [e["id"] for e in after[key]] != orig:
            print(f"!! {key} 顺序或内容被破坏")
            ok = False
    if not ok:
        print("未写入")
        return 1

    JSON.write_text(text, encoding="utf-8")
    for key, ident in removed:
        print(f"  {key}: 删除 {ident}  ({len(before[key])} -> {len(after[key])})")
    print("已写入", JSON)
    return 0


if __name__ == "__main__":
    sys.exit(main())
