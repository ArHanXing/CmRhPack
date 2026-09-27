"""把氟石矿相关的注册项插入 config/jsonreg_entries.json。

采用文本插入而非 json.dump，避免整份文件被重新格式化（原文件是手工维护的混合排版）。
三个数组各自的收尾括号前插入，并自动补逗号。
"""
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
JSON = ROOT / "config/jsonreg_entries.json"

ITEMS = [
    {"id": "fluorite_dust", "name": "氟石粉", "max_count": 1024},
    {"id": "fluorite_clump", "name": "氟石碎块", "max_count": 1024},
    {"id": "fluorite_gem", "name": "氟石晶体", "max_count": 1024},
    {"id": "calcium_sulfate_dust", "name": "石膏粉", "max_count": 1024},
]
BLOCKS = [
    {"id": "nether_fluorite_ore", "name": "下界氟石矿石", "hardness": 1.0,
     "resistance": 3.0, "requires_tool": False, "has_item": True},
]
FLUIDS = [
    {"id": "fluorite_solution", "name": "氟石盐溶液",
     "has_bucket_item": False, "has_block": True},
]


def array_span(text: str, key: str):
    """返回 key 对应数组的 [开括号, 闭括号] 位置。"""
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


def render(entries, indent="    "):
    """按文件主风格渲染：条目之间用逗号，条目内 2 空格缩进。"""
    chunks = []
    for e in entries:
        body = ",\n".join(f'{indent}  "{k}": {json.dumps(v, ensure_ascii=False)}'
                          for k, v in e.items())
        chunks.append(f"{indent}{{\n{body}\n{indent}}}")
    return ",\n".join(chunks)


def main() -> int:
    text = JSON.read_text(encoding="utf-8")
    before = json.loads(text)
    counts_before = {k: len(v) for k, v in before.items()}

    # 从后往前插，避免前面的插入影响后面数组的偏移
    for key, entries in (("fluids", FLUIDS), ("blocks", BLOCKS), ("items", ITEMS)):
        lb, rb = array_span(text, key)
        head = text[:rb].rstrip()
        # 若已有内容且最后一个非空字符不是 '['，补一个逗号
        tail = text[rb:]
        if head and head[-1] not in "[,":
            head += ","
        text = head + "\n" + render(entries) + "\n  " + tail

    after = json.loads(text)          # 语法自检
    counts_after = {k: len(v) for k, v in after.items()}

    ok = True
    for key, entries in (("items", ITEMS), ("blocks", BLOCKS), ("fluids", FLUIDS)):
        got = {e["id"] for e in after[key]}
        for e in entries:
            if e["id"] not in got:
                print(f"!! {key} 缺少 {e['id']}")
                ok = False
        print(f"  {key:<7} {counts_before[key]} -> {counts_after[key]}  (+{len(entries)})")

    # 保持原有条目不变
    for key in before:
        orig_ids = [e["id"] for e in before[key]]
        new_ids = [e["id"] for e in after[key]]
        if new_ids[: len(orig_ids)] != orig_ids:
            print(f"!! {key} 原有条目顺序被破坏")
            ok = False

    if not ok:
        print("未写入")
        return 1
    JSON.write_text(text, encoding="utf-8")
    print(f"已写入 {JSON}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
