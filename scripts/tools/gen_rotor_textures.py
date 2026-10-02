"""生成 5 个转子材质 + 光辉合金锭/板材质。

产物只落在 __workspace/textures/item/（即 ai_driver.py 的 STAGE_TEX 暂存区），
**不**写进资源树 —— 转子是 TR 侧物品，由 TR 源码构建时带走；
jsonreg 侧需要上架时用 `python ai_driver.py ... --install` 或手动复制。

直接复用包内换色生成器 `__workspace/recolor.py` 的算法（HSV 保明暗换色），
只改输出文件名（原生成器会加 _<颜色> 后缀，这里不需要）。

基底：
  · 转子        material_set/dull/turbine.png     （无 overlay/secondary 变体）
  · 锭 / 板     material_set/shiny/ingot.png、shiny/plate.png

配色：
  · 钢 / 钛 / 钨钢   -> 采样 TechReborn 对应锭贴图的平均色，保证与锭一致
  · 盖亚合金         -> 手工指定绿 #5FFF0C
  · 光辉合金         -> 手工指定「白偏绿」
"""
import io
import sys
import zipfile
from pathlib import Path

from PIL import Image

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
WS = ROOT / "config/openloader/packs/languageadd/assets/jsonreg/textures/__workspace"
MS = WS / "material_set"
STAGE = WS / "textures/item"          # ai_driver.py 的 STAGE_TEX
TR_JAR = ROOT / "mods/TechReborn-5.12.13-cmrh-preview.jar"

# 复用包内换色生成器
sys.path.insert(0, str(WS))
import recolor  # noqa: E402

GAIA = "5FFF0C"           # 盖亚合金：绿（作者指定）
SHINE = "C4EFD2"          # 光辉合金：白偏绿

# 转子名 -> 颜色来源（字符串表示手工指定）
ROTORS = {
    "steel":         (TR_JAR, "assets/techreborn/textures/item/ingot/steel_ingot.png"),
    "titanium":      (TR_JAR, "assets/techreborn/textures/item/ingot/titanium_ingot.png"),
    "tungstensteel": (TR_JAR, "assets/techreborn/textures/item/ingot/tungstensteel_ingot.png"),
    "gaia":          GAIA,
    "shine":         SHINE,
}


def avg_hex(jar: Path, path: str) -> str:
    z = zipfile.ZipFile(jar)
    img = Image.open(io.BytesIO(z.read(path))).convert("RGBA")
    px = [p for p in img.getdata() if p[3] > 128]
    n = len(px)
    return "%02X%02X%02X" % tuple(sum(p[i] for p in px) // n for i in range(3))


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
    print("=== 转子（基底 dull/turbine）===")
    base = MS / "dull/turbine.png"
    if not base.is_file():
        print("!! 缺少", base)
        return 1
    for name, src in ROTORS.items():
        color = src if isinstance(src, str) else avg_hex(*src)
        dst = STAGE / f"{name}_rotor.png"
        kind = make(base, color, dst)
        made.append(dst)
        print("  %-14s #%s  (%s)  -> %s" % (name, color, kind, dst.name))

    print("\n=== 光辉合金 锭 / 板（基底 shiny）===")
    for item, fname in (("ingot", "shiny/ingot.png"), ("plate", "shiny/plate.png")):
        src = MS / fname
        if not src.is_file():
            print("!! 缺少", src)
            return 1
        dst = STAGE / f"shine_{item}.png"
        kind = make(src, SHINE, dst)
        made.append(dst)
        print("  shine_%-8s #%s  (%s)  -> %s" % (item, SHINE, kind, dst.name))

    print()
    ok = True
    for p in made:
        if Image.open(p).size != (16, 16):
            print("  !! 尺寸异常", p.name)
            ok = False
    print(f"共生成 {len(made)} 个材质 -> {STAGE}")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
