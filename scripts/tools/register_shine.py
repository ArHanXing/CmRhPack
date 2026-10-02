"""把「光辉合金」的锭与板注册进 config/jsonreg_entries.json。

文本插入而非 json.dump 重写：原文件是手工维护的混合排版，整份重写会产生大量无关 diff。
"""
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
JSON = ROOT / "config/jsonreg_entries.json"

ENTRIES = [
    {"id": "shine_ingot", "name": "光辉合金锭", "max_count": 1024},
    {"id": "shine_plate", "name": "光辉合金板", "max_count": 1024},
]


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

    new_ids = {e["id"] for e in ENTRIES}
    if new_ids & {e["id"] for e in before["items"]}:
        print("已存在，跳过：", new_ids & {e["id"] for e in before["items"]})
        return 0

    indent = "    "
    body = ",\n".join(
        f'{indent}{{\n{indent}  "id": {json.dumps(e["id"], ensure_ascii=False)},\n'
        f'{indent}  "name": {json.dumps(e["name"], ensure_ascii=False)},\n'
        f'{indent}  "max_count": {e["max_count"]}\n{indent}}}'
        for e in ENTRIES)

    lb, rb = array_span(text, "items")
    head = text[:rb].rstrip()
    if head and head[-1] not in "[,":
        head += ","
    text = head + "\n" + body + "\n  " + text[rb:]

    after = json.loads(text)
    ok = True
    for e in ENTRIES:
        if not any(x["id"] == e["id"] for x in after["items"]):
            print("!! 缺少", e["id"])
            ok = False
    orig = [x["id"] for x in before["items"]]
    if [x["id"] for x in after["items"]][: len(orig)] != orig:
        print("!! 原有条目顺序被破坏")
        ok = False
    if not ok:
        return 1

    JSON.write_text(text, encoding="utf-8")
    print("items %d -> %d" % (len(before["items"]), len(after["items"])))
    for e in ENTRIES:
        print("  + %-16s %s" % (e["id"], e["name"]))
    print("已写入", JSON)
    return 0


if __name__ == "__main__":
    sys.exit(main())
