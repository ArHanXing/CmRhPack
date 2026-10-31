#!/usr/bin/env python3
"""生成新矿石方块的贴图与钒系物品贴图（CmRhPack）。

矿石方块贴图约定（反推自现有 nether_fluorite_ore / rock_salt_ore / voidstone_rutile_ore）：

    方块贴图 = base.png  <--(dull/ore.png 为掩码，按材质色上色，alpha 覆盖)

三个现有矿石方块的「与基底不同像素」全部恰好是 63 px，且
material_set/dull/ore.png 的 alpha>0 掩码与之逐像素完全一致 ——
所以 ore 子材质就是 dull/ore.png，只有基底（netherrack / stone / voidstone）
和上色颜色随材质变化。

基底与材质色的对应：
    netherrack.png  -> 下界形态（下界岩）
    stone.png       -> 主世界形态
    end_stone.png   -> 末地形态（末地石）

用法：
    python3 scripts/tools/gen_ore_assets_v2.py           # 生成
    python3 scripts/tools/gen_ore_assets_v2.py --check   # 只校验
"""
from __future__ import annotations

import shutil
import sys
from pathlib import Path

import numpy as np
from PIL import Image

ROOT = Path(__file__).resolve().parents[2]
JR = ROOT / "config/openloader/packs/languageadd/assets/jsonreg"
WS = JR / "textures/__workspace/material_set"
TEX_BLOCK = JR / "textures/block"
TEX_ITEM = JR / "textures/item"

# 矿石方块：(方块 id, 基底 png, 材质色)
ORES = [
    ("nether_vanadium_magnetite_ore", "netherrack.png", "4a3f52"),
    ("nether_pyrolusite_ore", "netherrack.png", "2e2a33"),
    ("nether_chromite_ore", "netherrack.png", "3d4a3a"),
    ("nether_hausmannite_ore", "netherrack.png", "43333d"),
    ("nether_rock_salt_ore", "netherrack.png", "e8d9d2"),
    ("end_rutile_ore", "end_stone.png", "8a4b3c"),
]

# 物品：(物品 id, material_set 子目录, 图层名, 颜色)
# 钒：metallic 分类的 dust / ingot / plate
ITEMS = [
    ("vanadium_dust", "metallic", "dust", "6b7f8c"),
    ("vanadium_ingot", "metallic", "ingot", "6b7f8c"),
    ("vanadium_plate", "metallic", "plate", "6b7f8c"),
    # 中间体形状（掩码与现有 sphalerite_* 逐像素一致）：
    #   碎块 = dull/crushed，石 = dull/gem_flawed，浓缩物 = certus/gem
    ("vanadium_magnetite_clump", "dull", "crushed", "4a3f52"),
    ("vanadium_magnetite_gem", "dull", "gem_flawed", "4a3f52"),
    ("vanadium_magnetite_concentrate", "certus", "gem", "4a3f52"),
    ("pyrolusite_clump", "dull", "crushed", "2e2a33"),
    ("pyrolusite_gem", "dull", "gem_flawed", "2e2a33"),
    ("pyrolusite_concentrate", "certus", "gem", "2e2a33"),
    ("chromite_clump", "dull", "crushed", "3d4a3a"),
    ("chromite_gem", "dull", "gem_flawed", "3d4a3a"),
    ("chromite_concentrate", "certus", "gem", "3d4a3a"),
    ("hausmannite_clump", "dull", "crushed", "43333d"),
    ("hausmannite_gem", "dull", "gem_flawed", "43333d"),
    ("hausmannite_concentrate", "certus", "gem", "43333d"),
    # ---- 太空电梯：强化硅岩合金（蓝色系，对齐 TR 太空电梯结构方块配色）----
    # TR 太空电梯色板：#00679b(机械外壳) / #003a61(off) / #0e588a(on)
    ("reinforced_naquadah_alloy_dust", "metallic", "dust", "2a5f8f"),
    ("hot_reinforced_naquadah_alloy_ingot", "metallic", "ingot_hot", "2a5f8f"),
    ("reinforced_naquadah_alloy_ingot", "metallic", "ingot", "2a5f8f"),
    ("reinforced_naquadah_alloy_plate", "metallic", "plate", "2a5f8f"),
    ("reinforced_naquadah_alloy_rod", "metallic", "rod", "2a5f8f"),
    # ---- 太空电梯：UHPC 建材链 ----
    ("cement_clinker", "dull", "crushed_refined", "4a4440"),
    ("cement", "dull", "dust", "9a9490"),
    ("steel_fiber", "metallic", "rod", "8a9099"),
    ("uhpc", "dull", "crushed_purified", "8c867f"),
    # ---- 钒单质与钒磁铁矿粉 ----
    ("vanadium_rod", "metallic", "rod", "6b7f8c"),
    ("vanadium_magnetite_dust", "metallic", "dust", "4a3f52"),
]

# 溶液流体：（流体 id, 目标色）
# 每种流体需要 4 个文件（textures/block/）：<id>_still.png + .mcmeta，
# <id>_flow.png + .mcmeta。尺寸与帧数由模板决定，mcmeta 直接照抄——
# 因为保留模板的图像尺寸，动画帧表天然成立。
FLUIDS = [
    ("vanadium_magnetite_solution", "6d5a8c"),
    ("pyrolusite_solution", "4a3d63"),
    ("chromite_solution", "4e6b4a"),
    ("hausmannite_solution", "7a4a6b"),
    # ---- 火箭燃料线：低温中间体（冷色调，近无色/淡蓝）----
    ("liquid_oxygen",   "b8d4e8"),
    ("liquid_hydrogen", "d8f0ff"),
    ("liquid_methane",  "a8c8e0"),
    # ---- 化工中间体 ----
    ("carbon_monoxide", "9098a0"),
    ("methanol",        "d0d8e0"),
    ("formaldehyde",    "c8d0d8"),
    ("refined_kerosene","d8b870"),
    # ---- 氧化剂 / 肼类（N2O4 真实为红棕色，肼类近无色）----
    ("dinitrogen_tetroxide",             "b86848"),
    ("monomethylhydrazine",              "c0c8d0"),
    ("unsymmetrical_dimethylhydrazine",  "d0c890"),
    # ---- 火箭燃料成品（GT 风格单流体）----
    ("rocket_fuel_rp1",     "c89858"),
    ("rocket_fuel_methane", "a0c0d8"),
    ("rocket_fuel_mmh",     "b0b890"),
    ("rocket_fuel_udmh",    "c0b878"),
    ("rocket_fuel_lh2",     "c8e8f8"),
]

# 模板：任选一个既有溶液即可（它们共享同一套流动图案，只有色相不同）
FLUID_TEMPLATE = "copper_solution"


def build_fluid(name: str, color: str) -> None:
    """把模板溶液按比例映射重上色。

    溶液贴图**不是灰度图**（每种溶液本身就是单色系渐变），所以不能直接
    tint（灰度量 × 颜色会丢失层次）。这里用「按通道均值做比例缩放」：
        out = clamp(pixel * target / avg)
    既保留原有亮度/流动层次，又把整体色相拉到目标色。
    """
    target = np.array([int(color[i:i + 2], 16) for i in (0, 2, 4)], dtype=float)
    for suffix in ("still", "flow"):
        src = TEX_BLOCK / f"{FLUID_TEMPLATE}_{suffix}.png"
        a = np.array(Image.open(src).convert("RGBA"), dtype=float)
        rgb = a[:, :, :3]
        avg = rgb.reshape(-1, 3).mean(axis=0)
        avg[avg == 0] = 1.0
        a[:, :, :3] = np.clip(rgb * (target / avg), 0, 255)
        Image.fromarray(a.astype("uint8"), "RGBA").save(TEX_BLOCK / f"{name}_{suffix}.png")
        shutil.copyfile(TEX_BLOCK / f"{FLUID_TEMPLATE}_{suffix}.png.mcmeta",
                        TEX_BLOCK / f"{name}_{suffix}.png.mcmeta")


def tint(img: Image.Image, color: str) -> Image.Image:
    """按灰度 × 颜色上色，保留原 alpha。与 jsonreg 的 material_set 管线一致。"""
    c = tuple(int(color[i:i + 2], 16) for i in (0, 2, 4))
    out = Image.new("RGBA", img.size)
    px = []
    for r, g, b, a in img.convert("RGBA").getdata():
        gray = (r + g + b) // 3
        px.append((int(gray / 255 * c[0]), int(gray / 255 * c[1]),
                   int(gray / 255 * c[2]), a))
    out.putdata(px)
    return out


def over(base: Image.Image, ov: Image.Image) -> Image.Image:
    """标准 alpha over 合成（保留输出 alpha，不能一律写 255）。

    方块矿石贴图的底色（netherrack 等）本来就是不透明，结果仍是 255；
    但物品热锭的底色带透明区，若强行写 255 会让整张图变成实心方块。
    """
    out = Image.new("RGBA", base.size)
    px = []
    for (br, bg, bb, ba), (or_, og, ob, oa) in zip(base.getdata(), ov.getdata()):
        a = oa / 255.0
        na = oa + ba * (1.0 - a)
        if na <= 0:
            px.append((0, 0, 0, 0))
            continue
        px.append((
            int((or_ * oa + br * ba * (1.0 - a)) / na),
            int((og * oa + bg * ba * (1.0 - a)) / na),
            int((ob * oa + bb * ba * (1.0 - a)) / na),
            int(round(na))))
    out.putdata(px)
    return out


def build_block(base_name: str, color: str) -> Image.Image:
    base = Image.open(WS / base_name).convert("RGBA")
    overlay = tint(Image.open(WS / "dull/ore.png").convert("RGBA"), color)
    return over(base, overlay)


HOT_OVERLAY_TINT = "ffe191"   # 熔融层固定奶油橙（与 gen_alloy_assets.py 一致）


def build_item(category: str, layer: str, color: str) -> Image.Image:
    """热锭是扁平化双层图：材料色底 + 固定橙色熔融覆盖层，必须合成。"""
    base = tint(Image.open(WS / category / f"{layer}.png").convert("RGBA"), color)
    if layer != "ingot_hot":
        return base
    overlay = tint(Image.open(WS / category / "ingot_hot_overlay.png").convert("RGBA"),
                   HOT_OVERLAY_TINT)
    return over(base, overlay)


def build_internal_concrete() -> None:
    """太空电梯内部结构混凝土（原缺失）。

    以既有 support_concrete 为底纹，整体提亮并偏冷 ——
    对应「轻量化 + 铝质骨料」的内部构件，同时与承压件明显区分。
    """
    src = TEX_BLOCK / "space_elevator_support_concrete.png"
    a = np.array(Image.open(src).convert("RGBA"), dtype=float)
    cur = a[:, :, :3].reshape(-1, 3).mean(axis=0)
    target = np.array([0x5a, 0x64, 0x72], dtype=float)      # 冷灰蓝
    a[:, :, :3] = np.clip(a[:, :, :3] * (target / np.maximum(cur, 1)), 0, 255)
    a[:, :, 3] = 255
    Image.fromarray(a.astype("uint8"), "RGBA").save(TEX_BLOCK / "space_elevator_internal_concrete.png")


def main() -> int:
    check = "--check" in sys.argv
    made = missing = 0

    for bid, base_name, color in ORES:
        out = TEX_BLOCK / f"{bid}.png"
        if check:
            if out.is_file():
                made += 1
            else:
                print(f"  缺 {out.name}")
                missing += 1
            continue
        build_block(base_name, color).save(out)
        made += 1

    for iid, cat, layer, color in ITEMS:
        out = TEX_ITEM / f"{iid}.png"
        if check:
            if out.is_file():
                made += 1
            else:
                print(f"  缺 {out.name}")
                missing += 1
            continue
        build_item(cat, layer, color).save(out)
        made += 1

    # 内部结构混凝土（由 support_concrete 派生，单独处理）
    ic = TEX_BLOCK / "space_elevator_internal_concrete.png"
    if check:
        if ic.is_file():
            made += 1
        else:
            print(f"  缺 {ic.name}")
            missing += 1
    else:
        build_internal_concrete()
        made += 1

    for fid, color in FLUIDS:
        parts = [TEX_BLOCK / f"{fid}_{sfx}{ext}"
                 for sfx in ("still", "flow") for ext in (".png", ".png.mcmeta")]
        if check:
            for p in parts:
                if p.is_file():
                    made += 1
                else:
                    print(f"  缺 {p.name}")
                    missing += 1
            continue
        build_fluid(fid, color)
        made += len(parts)

    if check:
        print(f"  {made}/{made + missing} 张贴图已就绪")
        return 1 if missing else 0
    print(f"  生成 {made} 张贴图")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
