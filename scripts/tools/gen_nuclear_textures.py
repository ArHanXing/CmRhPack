"""核燃料产线的材质生成：7 个流体 + 5 个物品。

产物落在 __workspace（ai_driver.py 的暂存区）：
  · 流体 -> __workspace/textures/fluid/<id>_still.png / _flow.png (+ .mcmeta)
  · 物品 -> __workspace/textures/item/<id>.png

加 `--install` 再复制进资源包（沿用 ai_driver.py 的约定）：
  · 物品 -> assets/jsonreg/textures/item/
  · 流体 -> assets/jsonreg/textures/block/（jsonreg 的流体方块贴图放这）

着色算法**分开用**，与包内既有工具保持一致：
  · 流体 —— 用 genfluid.py 的**乘法着色**（new = gray/255 × 目标色），
    保色度好、暗部不糊。注意 recolor.py 的 HSV 混合会把饱和度压掉，
    实测把 #3E4A44 渲染成了 #9EA9A4，所以流体绝不能用它。
  · 物品 —— 用 recolor.py（包内换色生成器），与转子等物品一致。

流体色号不手填，而是**指定目标渲染色 + 由脚本反解**：
    先量出基底贴图的平均灰度 G，则 tint = 目标色 / (G/255)
这样"玩家实际看到的颜色"才是设计值，级联各档的明度坡不会被基底稀释。

基底选择依据包内既有惯例：
  · 金属盐溶液一律 thick（17 个 *_solution 都是）→ 铀酰硫酸溶液用 thick
  · 氟化物/气体一律 thin（fluorine / HF / TiCl4 / 四氟乙烯）→ 6 个 UF6 用 thin
"""
import io
import shutil
import sys
import zipfile
from pathlib import Path

from PIL import Image

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
WS = ROOT / "config/openloader/packs/languageadd/assets/jsonreg/textures/__workspace"
MS = WS / "material_set"
STAGE_TEX = WS / "textures"
STAGE_ITEM = STAGE_TEX / "item"
STAGE_FLUID = STAGE_TEX / "fluid"
PACK = WS.parent                 # .../assets/jsonreg/textures —— ai_driver.py --install 的目标

sys.path.insert(0, str(WS))
import recolor  # noqa: E402

# 流体：id -> (中文名, **目标渲染色**, 基底 thick|thin)
# 六氟化铀做「丰度越高越亮、色相由绿走青」的大跨度坡；贫化料压到极暗，读作废料。
# ⚠ thick 基底的灰度只有 ~160（thin 是 ~212），所以 thick 流体天然更暗 ——
#   与包内既有惯例一致（uranium_solution #028B2C、copper_solution #8B3519 都偏暗）。
FLUIDS = {
    "tails_uf6":               ("贫化六氟化铀",    "4A3B2E", "thin"),   # 暗锈棕 = 废料
    "natural_uf6":             ("天然六氟化铀",    "6E9A5C", "thin"),   # 黄绿
    "cascade_feed_uf6":        ("级联进料",       "9DBFBD", "thin"),   # 浅薄荷青（混合）
    "low_uf6":                 ("低浓六氟化铀",    "3CC49A", "thin"),   # 青绿
    "mid_uf6":                 ("中浓六氟化铀",    "10D0B8", "thin"),   # 青
    "high_uf6":                ("反应堆级六氟化铀", "00C8E0", "thin"),   # 偏蓝青（最纯）
}
# 注：溶解步复用 T1.5 铀线既有的 jsonreg:uranium_solution，
#     原本的 uranyl_sulfate_solution 已删除（语义重复），故此处无对应条目。

# 物品：id -> (基底, 色号)  —— 走 recolor.py
ITEMS = {
    "enriched_uranium_dust": ("dull/dust.png",   "32D2A6"),  # 与反应堆级同色系
    "uranium_dioxide_dust":  ("dull/dust.png",   "3E4A38"),  # UO₂ 深褐黑
    "mox_blend_dust":        ("dull/dust.png",   "6E7A5A"),  # UO₂+PuO₂ 混合
    "mox_green_pellet":      ("dull/nugget.png", "5A5F52"),  # 生坯（未烧结）
    "mox_ceramic_pellet":    ("dull/nugget.png", "8E9678"),  # 烧结陶瓷
}


def base_gray(img: Image.Image) -> float:
    """基底贴图的平均灰度（0-255），用于反解色号。"""
    px = [p for p in img.convert("RGBA").getdata() if p[3] > 128]
    return sum(p[0] for p in px) / len(px)


def multiply(img: Image.Image, tint: tuple) -> Image.Image:
    """genfluid.py 的算法：new = gray/255 × 目标色。"""
    out = Image.new("RGBA", img.size)
    out.putdata([(int(d[0] / 255 * tint[0]), int(d[1] / 255 * tint[1]),
                  int(d[2] / 255 * tint[2]), d[3]) for d in img.convert("RGBA").getdata()])
    return out


def solve_tint(target_hex: str, gray: float) -> tuple:
    """目标渲染色 / (gray/255)，并夹到 0-255。"""
    k = 255.0 / max(gray, 1.0)
    return tuple(min(255, round(int(target_hex[i:i + 2], 16) * k)) for i in (0, 2, 4))


def make_item(src: Path, color: str, dst: Path) -> str:
    dst.parent.mkdir(parents=True, exist_ok=True)
    img = Image.open(src)
    gray = recolor.is_grayscale_image(img)
    out = (recolor.recolor_grayscale_image(img, color) if gray
           else recolor.recolor_color_image(img, color))
    out.save(dst, "PNG")
    return "灰度" if gray else "彩色"


def main() -> int:
    made = []

    print("=== 流体（基底 material_set/fluid/{thin,thick}_fluid_*，乘法着色）===")
    for fid, (name, target, tier) in FLUIDS.items():
        pre = "thick" if tier == "thick" else "thin"
        src = MS / "fluid" / f"{pre}_fluid_still.png"
        if not src.is_file():
            print("!! 缺少", src)
            return 1
        G = base_gray(Image.open(src))
        tint = solve_tint(target, G)
        for state in ("still", "flow"):
            s = MS / "fluid" / f"{pre}_fluid_{state}.png"
            dst = STAGE_FLUID / f"{fid}_{state}.png"
            dst.parent.mkdir(parents=True, exist_ok=True)
            multiply(Image.open(s), tint).save(dst, "PNG")
            made.append(dst)
            ref = MS / "fluid" / f"{pre}_fluid_{state}.png.mcmeta"
            if ref.is_file():
                shutil.copyfile(ref, Path(str(dst) + ".mcmeta"))
        got = base_gray(Image.open(STAGE_FLUID / f"{fid}_still.png"))
        print("  %-24s %-14s %-5s 基底灰%5.1f 色号#%02X%02X%02X -> 实际#%02X%02X%02X"
              % (fid, name, tier, G, *tint, *((lambda c: (int(c[0]/255*tint[0]), int(c[1]/255*tint[1]), int(c[2]/255*tint[2])))((G, G, G)))))

    print("\n=== 物品（走 recolor.py 换色生成器）===")
    for iid, (base, color) in ITEMS.items():
        src = MS / base
        if not src.is_file():
            print("!! 缺少", src)
            return 1
        dst = STAGE_ITEM / f"{iid}.png"
        kind = make_item(src, color, dst)
        made.append(dst)
        print("  %-24s %-16s #%s (%s)" % (iid, base, color, kind))

    print()
    bad = 0
    for p in made:
        w, h = Image.open(p).size
        if p.parent == STAGE_ITEM:
            if (w, h) != (16, 16):
                print("  !! 物品尺寸异常", p.name, (w, h))
                bad += 1
        elif p.parent == STAGE_FLUID and p.suffix == ".png":
            want_w = 16 if p.stem.endswith("_still") else 32
            if w != want_w or h % w:
                print("  !! 流体尺寸异常", p.name, (w, h))
                bad += 1
    print(f"共生成 {len(made)} 个材质 -> {STAGE_TEX}")

    if "--install" in sys.argv:
        print("\n=== 安装进资源包 ===")
        n = 0
        for p in made:
            if p.parent == STAGE_ITEM:
                dst = PACK / "item" / p.name
            elif p.parent == STAGE_FLUID:
                dst = PACK / "block" / p.name
            else:
                continue
            dst.parent.mkdir(parents=True, exist_ok=True)
            shutil.copyfile(p, dst)
            n += 1
            mc = Path(str(p) + ".mcmeta")
            if mc.is_file():
                shutil.copyfile(mc, Path(str(dst) + ".mcmeta"))
        print(f"  已安装 {n} 个 -> {PACK}")
    else:
        print("  （加 --install 可复制进资源包）")

    return 0 if not bad else 1


if __name__ == "__main__":
    sys.exit(main())
