"""生成自定义资源节点的方块贴图。

流程（两步，与工作流一致）：
  1. **表层**：从 material_set 取矿点层 —— 金属用 `dull/ore`，宝石用 `lapis/ore`，
     按该节点的色号上色（算法与 assetsgen.py 相同：new = gray/255 × 目标色，保留 alpha）。
  2. **叠加**：把上色后的矿点层盖到 `material_set/bedrock.png`（基岩）上，
     输出为 `assets/jsonreg/textures/block/resource_node_<name>.png`，覆盖原贴图。

色号来源：
  · 多数节点直接复用基础矿处已标定的矿物色号（见 sample_ore_colors.py）。
  · fossil / neutron / gem / naquadah 四个没有现成色号，从对应物品贴图现采。
"""
import io
import json
import sys
import zipfile
from pathlib import Path

from PIL import Image

ROOT = Path(__file__).resolve().parents[2]
WS = ROOT / "config/openloader/packs/languageadd/assets/jsonreg/textures/__workspace"
MSSET = WS / "material_set"
OUT = ROOT / "config/openloader/packs/languageadd/assets/jsonreg/textures/block"
JARS = {
    "minecraft": Path(r"D:\Games\Minecraft\PrismLauncher 9.4\libraries\com\mojang\minecraft\1.21.1\minecraft-1.21.1-client.jar"),
    "techreborn": ROOT / "mods/TechReborn-5.12.12-cmrh-preview.jar",
    "avaritia": next(ROOT.glob("mods/*avaritia*.jar"), None),
}

# 节点名 → (色号 or 取色源, 表层材质)
#   表层：dull/ore = 金属矿，lapis/ore = 宝石矿
NODES = {
    # —— 金属：复用基础矿处色号 ——
    "tungsten":   ("#8f99a1", "dull"),
    "iridium":    ("#c1e0d6", "dull"),
    "lead":       ("#9890aa", "dull"),
    "tin":        ("#dfdfdf", "dull"),
    "silver":     ("#c1eff1", "dull"),
    "sphalerite": ("#c8e06c", "dull"),
    "bauxite":    ("#d4e0e0", "dull"),          # 铝土，取铝的色号
    # —— 需现采的四个 ——
    "fossil":     (("minecraft", "assets/minecraft/textures/item/netherite_scrap.png"), "dull"),
    "neutron":    (("avaritia", "assets/avaritia/textures/block/neutronium_block.png"), "dull"),
    "naquadah":   (("jsonreg", "naquadah_dust.png"), "dull"),
    # —— 宝石 ——
    "gem":        (("techreborn", "assets/techreborn/textures/item/gem/ruby_gem.png"), "lapis"),
}


def load_source(src):
    """src 为 (jar, path) 或 ("jsonreg", 文件名)。"""
    if src[0] == "jsonreg":
        return Image.open(ROOT / "config/openloader/packs/languageadd/assets/jsonreg/textures/item" / src[1]).convert("RGBA")
    jar = JARS.get(src[0])
    if jar is None or not Path(jar).is_file():
        raise FileNotFoundError(f"jar 不可用: {src[0]}")
    with zipfile.ZipFile(jar) as z:
        return Image.open(io.BytesIO(z.read(src[1]))).convert("RGBA")


def sample(img):
    """平均色相 + 饱和度补偿 + 提亮到包内惯例亮度（与 sample_ore_colors.py 一致）。"""
    px = [p for p in img.getdata() if p[3] > 128]
    if not px:
        return None
    r = sum(p[0] for p in px) / len(px)
    g = sum(p[1] for p in px) / len(px)
    b = sum(p[2] for p in px) / len(px)
    lum = 0.299 * r + 0.587 * g + 0.114 * b
    r, g, b = (max(0.0, lum + (v - lum) * 1.5) for v in (r, g, b))
    m = max(r, g, b) or 1.0
    k = 0xE0 / m
    return "%02x%02x%02x" % tuple(min(int(v * k), 255) for v in (r, g, b))


def tint(layer: Image.Image, hexcolor: str) -> Image.Image:
    """灰度层 × 目标色（与 assetsgen.py 同算法），保留 alpha。"""
    tr = int(hexcolor[0:2], 16)
    tg = int(hexcolor[2:4], 16)
    tb = int(hexcolor[4:6], 16)
    out = Image.new("RGBA", layer.size)
    out.putdata([(int(d[0] / 255 * tr), int(d[1] / 255 * tg), int(d[2] / 255 * tb), d[3])
                 for d in layer.getdata()])
    return out


def main() -> int:
    bedrock = Image.open(MSSET / "bedrock.png").convert("RGBA")
    if bedrock.size != (16, 16):
        print(f"!! 基岩贴图尺寸异常: {bedrock.size}")

    resolved = {}
    for name, (color, layer_cat) in NODES.items():
        if isinstance(color, str):
            hexc = color.lstrip("#")
        else:
            hexc = sample(load_source(color))
            print(f"  采样 {name:<12} -> {hexc}")
        resolved[name] = (hexc, layer_cat)

    print()
    for name, (hexc, layer_cat) in sorted(resolved.items()):
        layer = Image.open(MSSET / layer_cat / "ore.png").convert("RGBA")
        colored = tint(layer, hexc)
        base = bedrock.copy()
        base.alpha_composite(colored)
        dst = OUT / f"resource_node_{name}.png"
        base.convert("RGBA").save(dst)
        px = [p for p in base.getdata() if p[3] > 128]
        top = max(px, key=lambda q: q[0] + q[1] + q[2]) if px else None
        print(f"  {name:<12} 表层={layer_cat}/ore  色号=#{hexc.upper()}  最亮={top[:3]}  -> {dst.name}")

    Path(ROOT / "__node_colors.json").write_text(
        json.dumps({k: v[0] for k, v in resolved.items()}, indent=2), encoding="utf-8")
    print(f"\n共生成 {len(resolved)} 个节点贴图；色号表见 __node_colors.json")
    return 0


if __name__ == "__main__":
    sys.exit(main())
