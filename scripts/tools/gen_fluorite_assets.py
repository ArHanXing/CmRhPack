"""生成氟石矿 / 氟石物品 / 石膏粉 / 氟石盐溶液的全部材质。

流程与 gen_node_textures.py、assetsgen.py 一致：
  · 表层：从 material_set 取灰度基底（dull/ore、dull/dust、dull/crushed、dull/gem_flawed），
    按目标色号着色（new = gray/255 × 色，保留 alpha）。
  · 合成：矿石方块把着色后的矿点层盖到 material_set/netherrack.png（下界围岩）上。
  · 流体：沿用包内约定，thin 流体基底 + mcmeta，输出到 textures/block/<id>_still|_flow.png。

色号：
  · 氟石 fluorite  #A98BF0（紫色氟石，在下界红橙色调里辨识度高，且不与银/铱/闪锌撞色）
  · 石膏 gypsum    #E8E4DC（灰白）
"""
import shutil
import sys
from pathlib import Path

from PIL import Image

ROOT = Path(__file__).resolve().parents[2]
ASSETS = ROOT / "config/openloader/packs/languageadd/assets/jsonreg/textures"
WS = ASSETS / "__workspace"
MSSET = WS / "material_set"
BLOCK = ASSETS / "block"
ITEM = ASSETS / "item"

FLUORITE = "a98bf0"
GYPSUM = "e8e4dc"

# 物品/base 目录/基底文件/色号
ITEMS = {
    "fluorite_dust":           ("dull", "dust.png",        FLUORITE),
    "fluorite_clump":          ("dull", "crushed.png",     FLUORITE),
    "fluorite_gem":            ("dull", "gem_flawed.png",  FLUORITE),
    "calcium_sulfate_dust":    ("dull", "dust.png",        GYPSUM),
}


def tint(layer: Image.Image, hexcolor: str) -> Image.Image:
    tr, tg, tb = (int(hexcolor[i:i + 2], 16) for i in (0, 2, 4))
    out = Image.new("RGBA", layer.size)
    out.putdata([(int(d[0] / 255 * tr), int(d[1] / 255 * tg), int(d[2] / 255 * tb), d[3])
                 for d in layer.getdata()])
    return out


def check(path: Path) -> None:
    img = Image.open(path)
    if img.size != (16, 16):
        print(f"  !! {path.name} 尺寸异常 {img.size}")


def main() -> int:
    made = []

    # ---------- 1. 下界氟石矿石 ----------
    host = Image.open(MSSET / "netherrack.png").convert("RGBA")
    ore = tint(Image.open(MSSET / "dull/ore.png").convert("RGBA"), FLUORITE)
    out = host.copy()
    out.alpha_composite(ore)
    dst = BLOCK / "nether_fluorite_ore.png"
    out.save(dst)
    made.append(dst)
    print(f"  nether_fluorite_ore   netherrack + dull/ore(tinted #{FLUORITE.upper()})")

    # ---------- 2. 物品 ----------
    for name, (cat, base, color) in ITEMS.items():
        src = MSSET / cat / base
        img = tint(Image.open(src).convert("RGBA"), color)
        dst = ITEM / f"{name}.png"
        img.save(dst)
        made.append(dst)
        print(f"  {name:<22} {cat}/{base} (tinted #{color.upper()})")

    # ---------- 3. 流体（thin 基底 + mcmeta） ----------
    ref = BLOCK / "aluminum_solution_still.png.mcmeta"
    if not ref.is_file():
        cands = sorted(BLOCK.glob("*_solution_still.png.mcmeta"))
        ref = cands[0] if cands else None
    if ref is None:
        print("  !! 找不到可参照的 solution mcmeta")
        return 1
    for state in ("still", "flow"):
        src = MSSET / "fluid" / f"thin_fluid_{state}.png"
        dst = BLOCK / f"fluorite_solution_{state}.png"
        tint(Image.open(src).convert("RGBA"), FLUORITE).save(dst)
        shutil.copyfile(ref, Path(str(dst) + ".mcmeta"))
        made.append(dst)
        print(f"  fluorite_solution_{state:<6} thin_fluid_{state} + {ref.name}")

    print()
    for p in made:
        check(p)
    print(f"共生成 {len(made)} 个文件（+ 2 个 mcmeta）")
    return 0


if __name__ == "__main__":
    sys.exit(main())
