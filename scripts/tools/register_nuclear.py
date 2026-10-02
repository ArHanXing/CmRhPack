"""核燃料产线的 jsonreg 注册（7 个流体 + 5 个物品）。

文本插入而非 json.dump 重写：原文件是手工维护的混合排版，整份重写会产生大量无关 diff。
幂等：已存在的 id 会被跳过。
"""
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
JSON = ROOT / "config/jsonreg_entries.json"

ITEMS = [
    {"id": "enriched_uranium_dust", "name": "浓缩铀粉", "max_count": 1024},
    {"id": "uranium_dioxide_dust", "name": "二氧化铀粉", "max_count": 1024},
    {"id": "mox_blend_dust", "name": "MOX 混合粉", "max_count": 1024},
    {"id": "mox_green_pellet", "name": "MOX 生坯", "max_count": 1024},
    {"id": "mox_ceramic_pellet", "name": "MOX 陶瓷芯块", "max_count": 1024},
]

FLUIDS = [
    {"id": "uranyl_sulfate_solution", "name": "铀酰硫酸溶液",
     "has_bucket_item": False, "has_block": True},
    {"id": "natural_uf6", "name": "天然六氟化铀",
     "has_bucket_item": False, "has_block": True},
    {"id": "cascade_feed_uf6", "name": "级联进料",
     "has_bucket_item": False, "has_block": True},
    {"id": "low_uf6", "name": "低浓六氟化铀",
     "has_bucket_item": False, "has_block": True},
    {"id": "mid_uf6", "name": "中浓六氟化铀",
     "has_bucket_item": False, "has_block": True},
    {"id": "high_uf6", "name": "反应堆级六氟化铀",
     "has_bucket_item": False, "has_block": True},
    {"id": "tails_uf6", "name": "贫化六氟化铀",
     "has_bucket_item": False, "has_block": True},
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


def render(entries, indent="    "):
    chunks = []
    for e in entries:
        body = ",\n".join(f'{indent}  "{k}": {json.dumps(v, ensure_ascii=False)}'
                          for k, v in e.items())
        chunks.append(f"{indent}{{\n{body}\n{indent}}}")
    return ",\n".join(chunks)


def main() -> int:
    text = JSON.read_text(encoding="utf-8")
    before = json.loads(text)

    plan = []
    for key, entries in (("fluids", FLUIDS), ("items", ITEMS)):
        have = {e["id"] for e in before[key]}
        todo = [e for e in entries if e["id"] not in have]
        skipped = [e["id"] for e in entries if e["id"] in have]
        plan.append((key, todo))
        if skipped:
            print(f"  {key}: 已存在，跳过 {skipped}")

    if not any(todo for _, todo in plan):
        print("全部已注册，无事可做")
        return 0

    # 从后往前插，避免前面的插入影响后面数组的偏移
    for key, todo in reversed(plan):
        if not todo:
            continue
        lb, rb = array_span(text, key)
        head = text[:rb].rstrip()
        tail = text[rb:]
        if head and head[-1] not in "[,":
            head += ","
        text = head + "\n" + render(todo) + "\n  " + tail

    after = json.loads(text)
    ok = True
    for key, todo in plan:
        got = {e["id"] for e in after[key]}
        for e in todo:
            if e["id"] not in got:
                print(f"!! {key} 缺少 {e['id']}")
                ok = False
    for key in before:
        orig = [e["id"] for e in before[key]]
        if [e["id"] for e in after[key]][: len(orig)] != orig:
            print(f"!! {key} 原有条目顺序被破坏")
            ok = False
    if not ok:
        print("未写入")
        return 1

    JSON.write_text(text, encoding="utf-8")
    for key, todo in plan:
        print(f"  {key:<7} {len(before[key])} -> {len(after[key])}  (+{len(todo)})")
    print("已写入", JSON)
    return 0


if __name__ == "__main__":
    sys.exit(main())
