"""注册 T1.5 浸出工序的 17 个金属盐溶液流体（方案 A：每种金属一个溶液）。

采用文本插入而非 json.load/json.dump 重写，避免整份 JSON 被重排。

同时复用 sample_ore_colors 的取色逻辑：溶液颜色直接取对应矿物的色号，
保证「粗矿 → 盐溶液 → 碎块」三步在视觉上属于同一材质族。
"""
import io
import json
import re
import sys
import zipfile
from pathlib import Path

from PIL import Image

ROOT = Path(__file__).resolve().parents[2]
TARGET = ROOT / "config/jsonreg_entries.json"

sys.path.insert(0, str(Path(__file__).resolve().parent))
from sample_ore_colors import SOURCES, TUNE, load, dominant  # noqa: E402

MINERALS = [
    ("copper", "铜"), ("gold", "金"), ("iron", "铁"), ("nickel", "镍"),
    ("platinum", "铂"), ("lead", "铅"), ("silver", "银"), ("tin", "锡"),
    ("tungsten", "钨"), ("iridium", "铱"), ("aluminum", "铝"), ("uranium", "铀"),
    ("galena", "方铅"), ("sphalerite", "闪锌"), ("cinnabar", "朱砂"),
    ("pyrite", "黄铁"), ("sodalite", "方钠"),
]

# 取色
colors = {}
for key, _ in MINERALS:
    src = SOURCES.get(key)
    if not src:
        print("  !! 无取色源:", key)
        continue
    img = load(*src)
    if img is None:
        print("  !! 贴图缺失:", key)
        continue
    import sample_ore_colors as S
    S._CURRENT[0] = key
    colors[key] = S.dominant(img)
Path(ROOT / "__solution_colors.json").write_text(
    json.dumps(colors, indent=2), encoding="utf-8")
print("取色完成:", len(colors), "种")
for k, v in colors.items():
    print(f"  {k:<12} {v}")

# 注册流体
text = TARGET.read_text(encoding="utf-8")
data = json.loads(text)
existing = {f["id"] for f in data["fluids"]}
todo = [(f"{k}_solution", f"{cn}盐溶液") for k, cn in MINERALS
        if f"{k}_solution" not in existing]
if not todo:
    print("\n流体已全部注册，无需插入")
    raise SystemExit

block = "".join(
    '    {\n      "id": "%s",\n      "name": "%s",\n'
    '      "has_bucket_item": false,\n      "has_block": true\n    },\n' % (i, n)
    for i, n in todo
)

# fluids 数组是文件的最后一个键，其结束位置 = 最后一个 "\n  ]\n}"
matches = list(re.finditer(r"\n  \]\n\}", text))
if not matches:
    raise SystemExit("找不到 fluids 数组的结束位置")
m = matches[-1]
text = text[:m.start()] + ",\n" + block.rstrip(",\n") + text[m.start():]
TARGET.write_text(text, encoding="utf-8")

data2 = json.loads(TARGET.read_text(encoding="utf-8"))
print(f"\n插入 {len(todo)} 个流体；fluids {len(data['fluids'])} → {len(data2['fluids'])}")
print("JSON 重新解析：通过")
