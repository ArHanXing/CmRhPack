#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""gen_greenhouse.py —— 批量生成温室（techreborn:greenhouse）配方。

数据源
------
scripts/!blockdump.log   —— 全包方块快照（判断方块是否存在）
mods/*.jar 的 models/item —— 判断物品是否存在（原版物品不在 jar 内，另表补充）

输出
----
scripts/greenhouse.zs

规则（对齐 TR 原生 18 条温室配方的形制：power 32 / time 200）
------
1. 树苗 `*_sapling` / `*_propagule` → 对应原木 ×2 + 树苗 ×1
   （vanilla oak_sapling 就是这个模式）
2. 自繁殖植物（花/蘑菇/浆果/水生/藤/草丛等）→ 自身 ×3
   （vanilla brown_mushroom 就是这个模式）
3. 野生作物 `wild_*` → 对应产物 ×2
4. 作物方块（farmersdelight rice）→ 收获物 ×3

排除
----
· TR 原生已有 18 条配方覆盖的物品（不重复添加）
· Botania 全部 —— 用户决定：后续要先做「原版神秘花 → 种神秘花」的中转，
  才能用温室批量培养；本次不动 Botania
· 机器 / 食物成品 / 装饰方块（正则无法区分，靠显式排除表）
"""
from __future__ import annotations

import io
import json
import re
import zipfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
OUT = ROOT / "scripts" / "greenhouse.zs"
POWER, TIME = 32, 200

# ── TR 原生温室已覆盖的物品：不得重复 ────────────────────────────────────────
NATIVE = {
    "minecraft:bamboo", "minecraft:beetroot_seeds", "minecraft:birch_sapling",
    "minecraft:brown_mushroom", "minecraft:cactus", "minecraft:carrot",
    "minecraft:cocoa_beans", "minecraft:glow_berries", "minecraft:kelp",
    "minecraft:melon_seeds", "minecraft:oak_sapling", "minecraft:potato",
    "minecraft:pumpkin_seeds", "minecraft:red_mushroom", "minecraft:sugar_cane",
    "minecraft:sweet_berries", "minecraft:vine", "minecraft:wheat_seeds",
}

# ── 1) 树苗 → 原木 ───────────────────────────────────────────────────────────
SAPLING = {
    # vanilla（oak/birch 原生已有，跳过）
    "minecraft:acacia_sapling": "minecraft:acacia_log",
    "minecraft:cherry_sapling": "minecraft:cherry_log",
    "minecraft:dark_oak_sapling": "minecraft:dark_oak_log",
    "minecraft:jungle_sapling": "minecraft:jungle_log",
    "minecraft:spruce_sapling": "minecraft:spruce_log",
    "minecraft:mangrove_propagule": "minecraft:mangrove_log",
    # 永恒星光
    "eternal_starlight:banyin_sapling": "eternal_starlight:banyin_log",
    "eternal_starlight:cradlewood_sapling": "eternal_starlight:cradlewood_log",
    "eternal_starlight:jinglestem_sapling": "eternal_starlight:jinglestem_log",
    "eternal_starlight:lunar_sapling": "eternal_starlight:lunar_log",
    "eternal_starlight:northland_sapling": "eternal_starlight:northland_log",
    "eternal_starlight:scarlet_sapling": "eternal_starlight:scarlet_log",
    "eternal_starlight:torreya_sapling": "eternal_starlight:torreya_log",
    # 神秘生物群系（依据 lang 名称对应：橙/黄枫 → maple_log，粉/白樱花 → black_cherry_log）
    "mysticsbiomes:lavender_blossom_sapling": "mysticsbiomes:lavender_log",
    "mysticsbiomes:maple_sapling": "mysticsbiomes:maple_log",
    "mysticsbiomes:orange_maple_sapling": "mysticsbiomes:maple_log",
    "mysticsbiomes:yellow_maple_sapling": "mysticsbiomes:maple_log",
    "mysticsbiomes:peach_sapling": "mysticsbiomes:peach_log",
    "mysticsbiomes:pink_cherry_blossom_sapling": "mysticsbiomes:black_cherry_log",
    "mysticsbiomes:white_cherry_blossom_sapling": "mysticsbiomes:black_cherry_log",
    "mysticsbiomes:strawberry_blossom_sapling": "mysticsbiomes:strawberry_log",
    "mysticsbiomes:tropical_sapling": "mysticsbiomes:tropical_log",
    "mysticsbiomes:vanilla_sapling": "mysticsbiomes:vanilla_log",
    # TechReborn 橡胶
    "techreborn:rubber_sapling": "techreborn:rubber_log",
}

# ── 2) 自繁殖植物 → 自身 ×3 ──────────────────────────────────────────────────
SELF = [
    # vanilla 花 / 菌 / 水生 / 藤 / 草丛
    "minecraft:allium", "minecraft:azure_bluet", "minecraft:blue_orchid",
    "minecraft:cornflower", "minecraft:dandelion", "minecraft:lily_of_the_valley",
    "minecraft:orange_tulip", "minecraft:oxeye_daisy", "minecraft:peony",
    "minecraft:pink_tulip", "minecraft:poppy", "minecraft:red_tulip",
    "minecraft:rose_bush", "minecraft:sunflower", "minecraft:white_tulip",
    "minecraft:wither_rose", "minecraft:torchflower", "minecraft:lily_pad",
    "minecraft:spore_blossom", "minecraft:crimson_fungus", "minecraft:warped_fungus",
    "minecraft:seagrass", "minecraft:twisting_vines",
    "minecraft:weeping_vines", "minecraft:big_dripleaf", "minecraft:small_dripleaf",
    "minecraft:nether_sprouts", "minecraft:nether_wart", "minecraft:moss_block",
    "minecraft:azalea", "minecraft:flowering_azalea", "minecraft:fern",
    "minecraft:large_fern", "minecraft:short_grass", "minecraft:tall_grass",
    "minecraft:chorus_flower", "minecraft:pitcher_plant",
    # 余烬生物群系（荆棘莓丛的方块无物品形态，输入用 bramble_berries）
    "cinderscapes:bramble_berries", "cinderscapes:photofern",
    "cinderscapes:tall_photofern", "cinderscapes:umbral_fungus",
    "cinderscapes:scorched_sprouts",
    # 末地乐事
    "ends_delight:chorus_succulent",
]

# 永恒星光：除下列排除项与树苗外的全部候选，按自身 ×3 处理
ES_EXCLUDE = {
    "bamboo_starfire_bird_aviary", "jinglestem_starfire_bird_aviary",   # 建筑
    "glowing_mushroom_block", "shining_mushroom_block",                 # 方块
    "lunaris_cactus_gel_block",
    "glowing_mossy_dusted_gravel", "mossy_dusted_gravel",               # 砂砾
    "blooming_blue_starlight_crystal_cluster",
    "blooming_red_starlight_crystal_cluster",                           # 晶簇
    "carved_lunaris_cactus_fruit", "lunaris_cactus_fruit_lantern",      # 果实变体
}
MS_EXCLUDE = {
    "strawberry_cake", "vanilla_cake",                                  # 食物
    "spring_bamboo_block", "stripped_spring_bamboo_block",              # 方块
}

# ── 3) 野生作物 → 产物 ×2 ───────────────────────────────────────────────────
WILD = {
    "farmersdelight:wild_cabbages": "farmersdelight:cabbage",
    "farmersdelight:wild_onions": "farmersdelight:onion",
    "farmersdelight:wild_tomatoes": "farmersdelight:tomato",
    "farmersdelight:wild_rice": "farmersdelight:rice_panicle",
    "farmersdelight:wild_carrots": "minecraft:carrot",
    "farmersdelight:wild_potatoes": "minecraft:potato",
    "farmersdelight:wild_beetroots": "minecraft:beetroot",
    # 菌落 → 蘑菇
    "farmersdelight:brown_mushroom_colony": "minecraft:brown_mushroom",
    "farmersdelight:red_mushroom_colony": "minecraft:red_mushroom",
}

# ── 4) 作物方块 → 收获物 ×3 ─────────────────────────────────────────────────
CROP_BLOCK = {
    "farmersdelight:rice": "farmersdelight:rice_panicle",
}

# 原版非方块物品（blockdump 里查不到，需单独放行）
VANILLA_ITEMS = {
    # 作物产物
    "carrot", "potato", "beetroot", "cocoa_beans", "glow_berries",
    "sweet_berries", "melon_slice", "wheat", "wheat_seeds", "beetroot_seeds",
    "melon_seeds", "pumpkin_seeds",
    # 树苗与对应原木
    "acacia_sapling", "cherry_sapling", "dark_oak_sapling", "jungle_sapling",
    "spruce_sapling", "mangrove_propagule",
    "acacia_log", "cherry_log", "dark_oak_log", "jungle_log", "spruce_log",
    "mangrove_log",
    # 花
    "allium", "azure_bluet", "blue_orchid", "cornflower", "dandelion",
    "lily_of_the_valley", "orange_tulip", "oxeye_daisy", "peony", "pink_tulip",
    "poppy", "red_tulip", "rose_bush", "sunflower", "white_tulip",
    "wither_rose", "torchflower", "lily_pad", "spore_blossom",
    # 菌
    "crimson_fungus", "warped_fungus", "brown_mushroom", "red_mushroom",
    # 水生 / 藤 / 草丛 / 其他
    "seagrass", "twisting_vines", "weeping_vines", "big_dripleaf",
    "small_dripleaf", "nether_sprouts", "nether_wart", "moss_block",
    "azalea", "flowering_azalea", "fern", "large_fern", "short_grass",
    "tall_grass", "chorus_flower", "pitcher_plant",
}


def load_blocks() -> set[str]:
    """从 scripts/!blockdump.log 解析全包方块（`- <block:ns:name>`）。"""
    txt = (ROOT / "scripts" / "!blockdump.log").read_text(encoding="utf-8", errors="ignore")
    out: set[str] = set()
    for line in txt.splitlines():
        m = re.search(r"<block:([a-z0-9_]+):([a-z0-9_/]+)>", line)
        if m:
            out.add(f"{m.group(1)}:{m.group(2)}")
    return out


def load_items() -> dict[str, set[str]]:
    """物品索引。

    ⚠ 只扫 mods/*.jar 的顶层 models/item 是不够的：
      · 部分 mod 用 JiJ 分模块（cinderscapes 的物品图在 META-INF/jars/*client*.jar 里）
      · 原版命名空间在 mods 里只有残缺表
    所以额外解嵌套 jar，原版另用 VANILLA_ITEMS 显式白名单。
    """
    pat = re.compile(r"assets/([a-z0-9_]+)/models/item/(.+)\.json$")
    items: dict[str, set[str]] = {}
    for j in sorted((ROOT / "mods").glob("*.jar")):
        try:
            z = zipfile.ZipFile(j)
            names = z.namelist()
        except Exception:
            continue
        blobs: list[bytes] = []
        for p in names:
            m = pat.match(p)
            if m:
                items.setdefault(m.group(1), set()).add(m.group(2))
            elif p.startswith("META-INF/jars/") and p.endswith(".jar"):
                blobs.append(z.read(p))
        for b in blobs:
            try:
                inner = zipfile.ZipFile(io.BytesIO(b))
            except Exception:
                continue
            for p in inner.namelist():
                m = pat.match(p)
                if m:
                    items.setdefault(m.group(1), set()).add(m.group(2))
    items.setdefault("minecraft", set()).update(VANILLA_ITEMS)
    return items


def exists(rid: str, items: dict[str, set[str]]) -> bool:
    """配方里的 item 引用必须真实存在 —— 只认物品表，不认方块表。

    反例：minecraft:cave_vines 是方块但没有物品（物品是 glow_berries），
    若按方块放行，CrT 加载时会直接报错并整份脚本失效。
    """
    ns, nm = rid.split(":", 1)
    return nm in items.get(ns, set())


def rec(name: str, inp: str, outs: list[tuple[int, str]]) -> str:
    body = ",\n".join(f'        {{count: {c}, id: "{i}"}}' for c, i in outs)
    return (
        f'<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.{name}", {{type: "techreborn:greenhouse",\n'
        f"    power: {POWER},\n"
        f"    time: {TIME},\n"
        f'    ingredients: [{{item: "{inp}"}}],\n'
        f"    outputs: [\n{body}\n    ]\n"
        f"}});"
    )


PLANT_KW = re.compile(
    r"(sapling|seedling|propagule|flower|blossom|bloom|bud|mushroom|fungus|"
    r"berry|bush|bramble|kelp|seagrass|coral|algae|seaweed|reed|vine|fern|moss|"
    r"grass|orchid|tulip|poppy|dandelion|allium|bluet|daisy|peony|sunflower|"
    r"azalea|lily|lotus|sprout|herb|thorn|cactus|succulent|wort|stalk|shade|"
    r"velvetumoss|thornbloom|whisperbloom|vividstalk|lanternvine|lumenstem)"
)


# 建材 / 变体后缀：命中植物关键词但**不是可繁殖植物**（如 strawberry_door、*_grass_block）
NON_PLANT_SUFFIX = re.compile(
    r"(_block|_carpet|_stem|_log|_wood|_planks|_stairs|_slab|_fence|_fence_gate|"
    r"_door|_trapdoor|_sign|_hanging_sign|_button|_pressure_plate|_leaves|_wall|"
    r"_bars|_grate|_tile|_pillar|_cluster|_sand|_gravel|_dirt|_bricks?|_crate|"
    r"_basket|_cabinet|_cake|_pie|_coral|_aviary|_station|_addon|_augment)$"
)
NON_PLANT_PREFIX = re.compile(r"^(dead_|stripped_|potted_|carved_|chiseled_|budding_)")


def derive(ns: str, blocks: set[str], items: dict[str, set[str]], exclude: set[str]) -> list[str]:
    """按关键词 + 物品存在性 + 排除建材变体，从方块表推导植物候选。"""
    out = []
    for b in sorted(blocks):
        if not b.startswith(ns + ":"):
            continue
        nm = b.split(":", 1)[1]
        if nm in exclude or not PLANT_KW.search(nm):
            continue
        if NON_PLANT_PREFIX.search(nm):
            continue                      # 死亡/去皮/盆栽/雕纹/晶芽 一律不是可繁殖植物
        if NON_PLANT_SUFFIX.search(nm) and not nm.endswith("_coral_fan"):
            continue                      # 例外：活体珊瑚扇可水培繁殖
        if exists(f"{ns}:{nm}", items):
            out.append(nm)
    return out


def main() -> int:
    blocks = load_blocks()
    items = load_items()

    entries: list[tuple[str, str, str]] = []   # (name, input, kind)
    for inp, log in SAPLING.items():
        if inp in NATIVE:
            continue
        entries.append((inp.replace(":", "_"), inp, f"sapling:{log}"))
    for inp in SELF:
        if inp in NATIVE:
            continue
        entries.append((inp.replace(":", "_"), inp, "self"))
    for inp, prod in WILD.items():
        entries.append((inp.replace(":", "_"), inp, f"wild:{prod}"))
    for inp, prod in CROP_BLOCK.items():
        entries.append((inp.replace(":", "_"), inp, f"crop:{prod}"))

    # 永恒星光 / 神秘生物群系：自动纳入全部候选植物（排除表 + 树苗已单列）
    handled = {inp for _, inp, k in entries if k != "self"} | set(SELF)
    for ns, exc in (("eternal_starlight", ES_EXCLUDE), ("mysticsbiomes", MS_EXCLUDE)):
        cand = derive(ns, blocks, items, exc)
        for nm in cand:
            rid = f"{ns}:{nm}"
            if nm in exc or rid in handled:
                continue
            entries.append((rid.replace(":", "_"), rid, "self"))

    # ── 校验 ────────────────────────────────────────────────────────────────
    bad: list[str] = []
    seen: dict[str, str] = {}
    for name, inp, kind in entries:
        if name in seen:
            bad.append(f"配方名重复: {name}")
        seen[name] = inp
        if not exists(inp, items):
            bad.append(f"输入不存在: {inp}")
        if kind.startswith("sapling:"):
            log = kind.split(":", 1)[1]
            if not exists(log, items):
                bad.append(f"原木不存在: {log} (来自 {inp})")
        elif kind.split(":", 1)[0] in ("wild", "crop"):
            prod = kind.split(":", 1)[1]
            if not exists(prod, items):
                bad.append(f"产物不存在: {prod} (来自 {inp})")

    if bad:
        print("❌ 校验失败：")
        for b in bad:
            print("   ", b)
        return 1

    lines = [rec(n, i, [(2, k.split(":", 1)[1]), (1, i)] if k.startswith("sapling:")
                  else ([(2, k.split(":", 1)[1])] if k.split(":", 1)[0] == "wild"
                        else ([(3, k.split(":", 1)[1])] if k.split(":", 1)[0] == "crop"
                              else [(3, i)])))
             for n, i, k in entries]

    head = (
        "import crafttweaker.api.recipe.type.Recipe;\n\n"
        "// =====================================================================\n"
        "// 温室配方批量生成（scripts/tools/gen_greenhouse.py 产出，请勿手改）\n"
        "// =====================================================================\n"
        f"// 共 {len(entries)} 条，power {POWER} / time {TIME}，对齐 TR 原生 18 条形制。\n"
        "// 规则：树苗→原木×2+树苗×1；自繁殖植物→自身×3；野生作物→产物×2；作物方块→收获物×3。\n"
        "// 已排除：TR 原生 18 条覆盖项、Botania（后续走「种神秘花」中转）、机器/食物/装饰方块。\n"
        "// =====================================================================\n\n"
    )
    OUT.write_text(head + "\n\n".join(lines) + "\n", encoding="utf-8")
    print(f"✅ 已写入 {OUT}（{len(entries)} 条）")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
