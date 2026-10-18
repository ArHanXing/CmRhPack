"""为「硅岩合金」与「高速钢-G」两套新材料生成物品贴图。

算法与 __workspace/assetsgen.py 完全一致（灰度层 × 目标色，保留 alpha），
只是去掉交互式 input()，改成表驱动。

材质类别定为 `metallic`（反推依据）：
  material_set/metallic/dust.png 用 #192f60 上色后与现有
  textures/item/naquadria_dust.png 逐像素完全一致（diff = 0），
  ingot / plate / rod 的残差只有 3~6（int() 截断误差量级），
  说明 naquadria 系列走的就是 metallic 层。

输出只写主图层：资源包里 naquadria_* / naquadah_* 系列都没有
_overlay / _secondary 变体文件，jsonreg 侧生成的是单 layer 模型。

色号：
  硅岩合金 #5a5568  硅岩 #203744 与钨/镍钢灰的中和，偏紫以保留硅岩家族识别度
  高速钢-G #838a91  高速钢的钢灰

用法:
  python3 scripts/tools/gen_alloy_assets.py            # 生成
  python3 scripts/tools/gen_alloy_assets.py --check    # 只校验，不写文件
"""
import argparse
import sys
from pathlib import Path

from PIL import Image

ROOT = Path(__file__).resolve().parents[2]
MATERIAL_SET = (
    ROOT
    / "config/openloader/packs/languageadd/assets/jsonreg/textures/__workspace/material_set"
)
OUT_DIR = ROOT / "config/openloader/packs/languageadd/assets/jsonreg/textures/item"

CATEGORY = "metallic"

# 热锭的熔融覆盖层色号。所有热锭共用同一个橙色（从现有 hot_*_ingot 反解得
# #ffa36e，与具体材料无关）。
HOT_OVERLAY_TINT = "ffe191"

# 输出贴图名 -> (metallic 层名, 色号)
#   hot_* 条目会自动套用「ingot_hot 底 + ingot_hot_overlay 熔融层」双层合成。
ITEMS = {
    # —— 硅岩合金 (Nq₂W₇Ni) ——
    "naquadah_alloy_dust": ("dust", "5a5568"),
    "hot_naquadah_alloy_ingot": ("ingot_hot", "5a5568"),
    "naquadah_alloy_ingot": ("ingot", "5a5568"),
    "naquadah_alloy_plate": ("plate", "5a5568"),
    "naquadah_alloy_rod": ("rod", "5a5568"),
    # —— 高速钢-G (Fe₂WCrMn) ——
    "hssg_dust": ("dust", "838a91"),
    "hot_hssg_ingot": ("ingot_hot", "838a91"),
    "hssg_ingot": ("ingot", "838a91"),
    "hssg_plate": ("plate", "838a91"),
    "hssg_rod": ("rod", "838a91"),
}


def tint(path: Path, color: str) -> Image.Image:
    """灰度层 × 色号，保留 alpha（与 assetsgen.py 同式，含 int() 截断）。"""
    img = Image.open(path).convert("RGBA")
    r, g, b = (int(color[i : i + 2], 16) for i in (0, 2, 4))
    out = Image.new("RGBA", img.size)
    out.putdata(
        [
            (int(p[0] / 255.0 * r), int(p[1] / 255.0 * g), int(p[2] / 255.0 * b), p[3])
            for p in img.getdata()
        ]
    )
    return out


def over(base: Image.Image, overlay: Image.Image) -> Image.Image:
    """标准 alpha 合成（overlay 盖在 base 上），alpha 取两者较大值。"""
    out = Image.new("RGBA", base.size)
    bp, op = list(base.getdata()), list(overlay.getdata())
    res = []
    for pb, po in zip(bp, op):
        a = po[3] / 255.0
        res.append(
            (
                int(po[0] * a + pb[0] * (1 - a)),
                int(po[1] * a + pb[1] * (1 - a)),
                int(po[2] * a + pb[2] * (1 - a)),
                max(pb[3], po[3]),
            )
        )
    out.putdata(res)
    return out


def build(layer: str, color: str) -> Image.Image:
    """按层名生成贴图。

    热锭（ingot_hot）在资源包里是扁平化后的双层图：
    材料色底 + 固定橙色的熔融覆盖层，所以这里要合成而不是单纯上色。
    """
    base = tint(MATERIAL_SET / CATEGORY / f"{layer}.png", color)
    if layer != "ingot_hot":
        return base
    overlay = tint(MATERIAL_SET / CATEGORY / "ingot_hot_overlay.png", HOT_OVERLAY_TINT)
    return over(base, overlay)


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--check", action="store_true", help="只校验贴图是否齐备")
    args = ap.parse_args()

    if not MATERIAL_SET.is_dir():
        print(f"找不到材质目录: {MATERIAL_SET}", file=sys.stderr)
        return 2

    missing_layer = []
    written, present = 0, 0

    for name, (layer, color) in sorted(ITEMS.items()):
        src = MATERIAL_SET / CATEGORY / f"{layer}.png"
        dst = OUT_DIR / f"{name}.png"

        if not src.is_file():
            missing_layer.append(f"{CATEGORY}/{layer}.png")
            continue

        if args.check:
            if dst.is_file():
                present += 1
                print(f"  ✅ {name}.png")
            else:
                print(f"  ❌ {name}.png 缺失 (源 {CATEGORY}/{layer} #{color})")
            continue

        OUT_DIR.mkdir(parents=True, exist_ok=True)
        build(layer, color).save(dst)
        written += 1
        tag = f" + overlay #{HOT_OVERLAY_TINT}" if layer == "ingot_hot" else ""
        print(f"  {name}.png  <- {CATEGORY}/{layer}.png  #{color}{tag}")

    if missing_layer:
        print(f"\n材质层缺失: {sorted(set(missing_layer))}", file=sys.stderr)
        return 2

    if args.check:
        print(f"\n{present}/{len(ITEMS)} 张贴图已就绪")
        return 0 if present == len(ITEMS) else 1

    print(f"\n已生成 {written} 张贴图 -> {OUT_DIR.relative_to(ROOT)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
