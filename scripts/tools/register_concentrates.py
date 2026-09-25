"""把基础矿物处理的浓缩物系列注册进 config/jsonreg_entries.json 的 items 数组。

采用**文本插入**而不是 json.load + json.dump —— 后者会把整个文件重排，
产生几千行无意义 diff。这里只在 items 数组末尾追加。

命名沿用 Oritech 的中文风格：
    iron_clump = 铁碎块 / iron_gem = 铁石
故本包统一为：X碎块 / X石 / X浓缩物。
"""
import json
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
TARGET = ROOT / "config/jsonreg_entries.json"

# 矿物内部名 → 中文名
#   前 12 种原本没有 clump/gem，需要三种形态全注册；
#   后 5 种（Cu/Au/Fe/Ni/Pt）已有 OR 的 clump/gem，只补 concentrate。
FULL = [
    ("lead", "铅"), ("silver", "银"), ("tin", "锡"), ("tungsten", "钨"),
    ("iridium", "铱"), ("aluminum", "铝"), ("uranium", "铀"),
    ("galena", "方铅"), ("sphalerite", "闪锌"), ("cinnabar", "朱砂"),
    ("pyrite", "黄铁"),
]
# 方钠石本身就叫「方钠石」，其 gem 用「方钠晶石」避免与矿物名撞车
SODALITE = [("sodalite_clump", "方钠石碎块"),
            ("sodalite_gem", "方钠晶石"),
            ("sodalite_concentrate", "方钠石浓缩物")]
FULL.append(("sodalite", "方钠石"))
ONLY_CONCENTRATE = [
    ("copper", "铜"), ("gold", "金"), ("iron", "铁"),
    ("nickel", "镍"), ("platinum", "铂"),
]

entries = []
for key, cn in FULL:
    if key == "sodalite":
        entries += SODALITE
    else:
        entries += [(f"{key}_clump", f"{cn}碎块"),
                    (f"{key}_gem", f"{cn}石"),
                    (f"{key}_concentrate", f"{cn}浓缩物")]
for key, cn in ONLY_CONCENTRATE:
    entries.append((f"{key}_concentrate", f"{cn}浓缩物"))

text = TARGET.read_text(encoding="utf-8")
data = json.loads(text)
existing = {i["id"] for i in data["items"]}
todo = [(i, n) for i, n in entries if i not in existing]
skipped = [i for i, _ in entries if i in existing]
if skipped:
    print("已存在、跳过:", skipped)

block = "".join(
    '    {\n      "id": "%s",\n      "name": "%s",\n      "max_count": 1024\n    },\n' % (i, n)
    for i, n in todo
)

# items 数组的结束位置 = 第一个 "\n  ],\n" （items 是第一个键）
m = re.search(r"\n  \],\n", text)
if not m:
    raise SystemExit("找不到 items 数组的结束位置")
text = text[:m.start()] + ",\n" + block.rstrip(",\n") + text[m.start():]
# 上面手工补的逗号会让 "    }" 与 "  ]," 之间格式正确；但原结尾已有结构，改为直接拼接
TARGET.write_text(text, encoding="utf-8")

data2 = json.loads(TARGET.read_text(encoding="utf-8"))
print(f"插入 {len(todo)} 条；items 总数 {len(data['items'])} → {len(data2['items'])}")
print("JSON 重新解析：通过")
