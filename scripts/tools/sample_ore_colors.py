"""从现有粉/矿产物贴图采样主色，用于给新注册的浓缩物上色。

取色源优先级：jsonreg 自定义贴图 → TR jar → Oritech jar。
采样规则：只取不透明像素，按 8 级量化后取最高频色（避免描边/高光干扰）。
"""
import io
import json
import zipfile
from collections import Counter
from pathlib import Path

from PIL import Image

ROOT = Path(__file__).resolve().parents[2]
JARS = {
    "techreborn": ROOT / "mods/TechReborn-5.12.12-cmrh-preview.jar",
    "oritech": ROOT / "mods/oritech-fabric-1.21.1-1.2.12.jar",
}
JSONREG_TEX = ROOT / "config/openloader/packs/languageadd/assets/jsonreg/textures/item"

# 矿物 → 取色源（jar, 贴图路径）；jsonreg 目录用 ("jsonreg", 文件名) 表示
SOURCES = {
    "lead":       ("techreborn", "assets/techreborn/textures/item/dust/lead_dust.png"),
    "silver":     ("techreborn", "assets/techreborn/textures/item/dust/silver_dust.png"),
    "tin":        ("techreborn", "assets/techreborn/textures/item/dust/tin_dust.png"),
    "tungsten":   ("techreborn", "assets/techreborn/textures/item/dust/tungsten_dust.png"),
    "iridium":    ("techreborn", "assets/techreborn/textures/item/ingot/iridium_ingot.png"),
    "aluminum":   ("techreborn", "assets/techreborn/textures/item/dust/aluminum_dust.png"),
    "uranium":    ("oritech",    "assets/oritech/textures/item/uranium_dust.png"),
    "galena":     ("techreborn", "assets/techreborn/textures/item/dust/galena_dust.png"),
    "sphalerite": ("techreborn", "assets/techreborn/textures/item/dust/sphalerite_dust.png"),
    "cinnabar":   ("techreborn", "assets/techreborn/textures/item/dust/cinnabar_dust.png"),
    "pyrite":     ("techreborn", "assets/techreborn/textures/item/dust/pyrite_dust.png"),
    "sodalite":   ("techreborn", "assets/techreborn/textures/item/dust/sodalite_dust.png"),
    "salt":       ("jsonreg",    "salt_dust.png"),
    "rock_salt":  ("jsonreg",    "rock_salt_dust.png"),
    # Cu/Au/Fe/Ni/Pt 已有 OR 的 clump/gem，只缺 concentrate —— 从 OR 的 gem 贴图取色
    "copper":     ("oritech",    "assets/oritech/textures/item/copper_gem.png"),
    "gold":       ("oritech",    "assets/oritech/textures/item/gold_gem.png"),
    "iron":       ("oritech",    "assets/oritech/textures/item/iron_gem.png"),
    "nickel":     ("oritech",    "assets/oritech/textures/item/nickel_gem.png"),
    "platinum":   ("oritech",    "assets/oritech/textures/item/platinum_gem.png"),
}

# 人工微调：采样值偏亮/偏暗时按倍数压一下（1.0 = 不动）
#   tungsten / lead 采样后过亮，压暗；silver 略提亮。
TUNE = {
    "tungsten": 0.72,
    "lead":     0.76,
    "silver":   1.08,
}


def load(jar_key: str, path: str):
    if jar_key == "jsonreg":
        p = JSONREG_TEX / path
        return Image.open(p).convert("RGBA") if p.is_file() else None
    jar = JARS[jar_key]
    with zipfile.ZipFile(jar) as z:
        if path in z.namelist():
            return Image.open(io.BytesIO(z.read(path))).convert("RGBA")
    return None


def dominant(img):
    """取不透明像素的平均色相，再提亮到包内惯例亮度。

    不能用「最高频色」—— 粉/矿贴图里最高频的通常是描边与暗部（实测铅会取到 3c3444、
    方钠石 14243c），拿它去乘灰度模板会得到几乎看不见的暗块。
    包内既有色号（铁 d5d5d5、铜 e47b55、铝 E4E7E7）都是亮色，故统一提亮。
    """
    px = [p for p in img.getdata() if p[3] > 128]
    if not px:
        return None
    r = sum(p[0] for p in px) / len(px)
    g = sum(p[1] for p in px) / len(px)
    b = sum(p[2] for p in px) / len(px)
    # 饱和度补偿：粉贴图多为灰色底 + 淡色调，直接提亮会洗成近白，
    # 这里把各通道相对亮度的偏移放大，让色相读得出来（铅/方铅会从淡紫变成蓝灰）。
    lum = 0.299 * r + 0.587 * g + 0.114 * b
    k_sat = 1.5
    r = lum + (r - lum) * k_sat
    g = lum + (g - lum) * k_sat
    b = lum + (b - lum) * k_sat
    r, g, b = (max(0.0, v) for v in (r, g, b))
    m = max(r, g, b) or 1.0
    k = 0xE0 / m                      # 提亮到最亮通道 ≈ 224
    k *= TUNE.get(_CURRENT[0], 1.0)   # 人工微调
    r, g, b = (min(int(v * k), 255) for v in (r, g, b))
    return "%02x%02x%02x" % (r, g, b)


_CURRENT = [""]


result = {}
for key, (jar_key, path) in SOURCES.items():
    _CURRENT[0] = key
    img = load(jar_key, path)
    if img is None:
        result[key] = None
        print("  %-12s 贴图缺失: %s" % (key, path))
        continue
    hexv = dominant(img)
    result[key] = hexv
    print("  %-12s %s  (源: %s)" % (key, hexv, path.split("/")[-1]))

Path("__ore_colors.json").write_text(json.dumps(result, indent=2), encoding="utf-8")
print("\n已写出 __ore_colors.json")
