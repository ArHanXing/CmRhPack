"""核燃料产线的材质生成：7 个流体 + 5 个物品。

产物只落在 __workspace（ai_driver.py 的暂存区），不写进资源树：
  · 流体 -> __workspace/textures/fluid/<id>_still.png / _flow.png (+ .mcmeta)
  · 物品 -> __workspace/textures/item/<id>.png

复用包内换色生成器 recolor.py 的算法（HSV 保明暗换色）。

配色逻辑：
  · 六氟化铀系列按「丰度越高越青亮」排布，玩家扫一眼就能分辨级联的哪一段
  · 浓缩铀粉与「反应堆级 UF₆」同色，一眼看出是富集产物
  · UO₂ / MOX 系列走深灰绿陶瓷色系，与铀线区分开
"""
import shutil
import sys
from pathlib import Path

from PIL import Image

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
WS = ROOT / "config/openloader/packs/languageadd/assets/jsonreg/textures/__workspace"
MS = WS / "material_set"
STAGE_TEX = WS / "textures"
STAGE_ITEM = STAGE_TEX / "item"
STAGE_FLUID = STAGE_TEX / "fluid"

sys.path.insert(0, str(WS))
import recolor  # noqa: E402

# 流体：id -> (中文名, 色号)
FLUIDS = {
    "uranyl_sulfate_solution": ("铀酰硫酸溶液", "C6D94A"),   # 铀酰：亮黄绿（荧光）
    "natural_uf6":             ("天然六氟化铀", "9FB5AE"),   # 天然
    "cascade_feed_uf6":        ("级联进料",     "8FA8A2"),
    "low_uf6":                 ("低浓六氟化铀", "74C4B4"),
    "mid_uf6":                 ("中浓六氟化铀", "54C2AE"),
    "high_uf6":                ("反应堆级六氟化铀", "32D2A6"),
    "tails_uf6":               ("贫化六氟化铀", "5C6E69"),   # 贫化：暗
}

# 物品：id -> (基底, 色号)
ITEMS = {
    "enriched_uranium_dust": ("dull/dust.png",   "32D2A6"),  # 与反应堆级同色
    "uranium_dioxide_dust":  ("dull/dust.png",   "3E4A38"),  # UO₂ 深褐黑
    "mox_blend_dust":        ("dull/dust.png",   "6E7A5A"),  # UO₂+PuO₂ 混合
    "mox_green_pellet":      ("dull/nugget.png", "5A5F52"),  # 生坯（未烧结）
    "mox_ceramic_pellet":    ("dull/nugget.png", "8E9678"),  # 烧结陶瓷
}


def make(src: Path, color: str, dst: Path) -> str:
    dst.parent.mkdir(parents=True, exist_ok=True)
    img = Image.open(src)
    gray = recolor.is_grayscale_image(img)
    out = (recolor.recolor_grayscale_image(img, color) if gray
           else recolor.recolor_color_image(img, color))
    out.save(dst, "PNG")
    return "灰度" if gray else "彩色"


def main() -> int:
    made = []

    print("=== 流体（基底 material_set/fluid/thin_fluid_*）===")
    ref_meta = next(iter(sorted(MS.glob("fluid/thin_fluid_still.png.mcmeta"))), None)
    for fid, (name, color) in FLUIDS.items():
        for state in ("still", "flow"):
            src = MS / "fluid" / f"thin_fluid_{state}.png"
            if not src.is_file():
                print("!! 缺少", src)
                return 1
            dst = STAGE_FLUID / f"{fid}_{state}.png"
            kind = make(src, color, dst)
            made.append(dst)
            if ref_meta:
                shutil.copyfile(ref_meta, Path(str(dst) + ".mcmeta"))
        print("  %-24s %-12s #%s (%s)" % (fid, name, color, kind))

    print("\n=== 物品 ===")
    for iid, (base, color) in ITEMS.items():
        src = MS / base
        if not src.is_file():
            print("!! 缺少", src)
            return 1
        dst = STAGE_ITEM / f"{iid}.png"
        kind = make(src, color, dst)
        made.append(dst)
        print("  %-24s %-12s #%s (%s)" % (iid, base, color, kind))

    print()
    bad = 0
    for p in made:
        w, h = Image.open(p).size
        if p.parent == STAGE_ITEM and (w, h) != (16, 16):
            print("  !! 物品尺寸异常", p.name, (w, h))
            bad += 1
        # 流体条带：still 宽 16（16×512），flow 宽 32（32×1024），都是 32 帧
        if p.parent == STAGE_FLUID and p.suffix == ".png":
            want_w = 16 if p.stem.endswith("_still") else 32
            if w != want_w or h != want_w * 32:
                print("  !! 流体尺寸异常", p.name, (w, h))
                bad += 1
    print(f"共生成 {len(made)} 个材质（+ 14 个 mcmeta）-> {STAGE_TEX}")
    return 0 if not bad else 1


if __name__ == "__main__":
    sys.exit(main())
