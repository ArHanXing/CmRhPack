#!/usr/bin/env python3
"""生成 Botania 中文补全覆盖层。

背景：Botania 自带 zh_cn.json 有 563 个键没翻（新版加了染色魔力池/发射器、
变质岩建材、末影精华线等，中文没跟上）。本脚本从 jar 里读出 en_us/zh_cn，
补齐缺失键后写入 openloader 的 languageadd 资源包。

两类键分开处理：
  · systematic —— 颜色×池/发射器、木石建材、石英变体，按模板批量生成
  · MANUAL     —— 需要真正翻译的条目（物品名、成就、Patchouli 书页等）

另有一批「孤儿键」：旧版把 Ender Essence 叫「末地空气」，模组改名后中文成了
失效键。这些译文正好描述同一个机制，直接搬运给新键，避免重翻。

用法：
    python3 scripts/tools/gen_botania_lang.py            # 生成覆盖层
    python3 scripts/tools/gen_botania_lang.py --check    # 只报告覆盖率
"""
from __future__ import annotations

import json
import sys
import zipfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
OUT = ROOT / "config/openloader/packs/languageadd/assets/botania/lang/zh_cn.json"

# ---------------------------------------------------------------- 术语表

COLORS = {
    "white": "白色", "orange": "橙色", "magenta": "品红色", "light_blue": "淡蓝色",
    "yellow": "黄色", "lime": "黄绿色", "pink": "粉色", "gray": "灰色",
    "light_gray": "淡灰色", "cyan": "青色", "purple": "紫色", "blue": "蓝色",
    "brown": "棕色", "green": "绿色", "red": "红色", "black": "黑色",
}

# 魔力池：取 zh_cn 里既有的基名
POOLS = {
    "mana_pool": "魔力池",
    "fabulous_mana_pool": "神话魔力池",
    "diluted_mana_pool": "稀释魔力池",
    "creative_mana_pool": "永恒魔力池",
}

# 发射器：同上
SPREADERS = {
    "mana_spreader": "魔力发射器",
    "elven_mana_spreader": "精灵魔力发射器",
    "gaia_mana_spreader": "盖亚魔力发射器",
    "pulse_mana_spreader": "红石魔力发射器",
}

# 石英七个花色（从既有键反查）
QUARTZ = {
    "blaze": "烈焰", "elven": "精灵", "lavender": "熏香",
    "mana": "魔力", "red": "红色", "smokey": "烟熏", "sunny": "金黄",
}

# 建材基名 + 后缀
WOOD = {
    "livingwood": "活木", "dreamwood": "梦之木", "livingrock": "活石",
    "shimmerwood": "微光木", "shimmerrock": "微光石",
    "cataclasite": "变质沼泽石", "corporea": "多媒体", "fuchsite": "变质森林石",
    "gneiss": "变质高山石", "lunite": "变质雪原石", "mycelite": "变质菌丝石",
    "rosy_talc": "变质高原石", "solite": "变质沙漠石", "talc": "变质平原石",
}
SUFFIX = {
    "button": "按钮", "pressure_plate": "压力板", "door": "门",
    "trapdoor": "活板门", "fence": "栅栏", "fence_gate": "栅栏门",
    "sign": "告示牌", "wall_sign": "墙告示牌",
    "hanging_sign": "悬挂式告示牌", "wall_hanging_sign": "墙悬挂式告示牌",
    "wall": "墙",
}

# ---------------------------------------------------------------- 手工翻译

MANUAL: dict[str, str] = {
    # ===== 新物品：末影精华线（用户点名的那批）=====
    "item.botania.diluted_ender_essence": "稀释的末影精华",
    "item.botania.pure_ender_essence": "纯净的末影精华",
    "item.botania.petal_pouch": "花瓣袋",
    "entity.botania.diluted_ender_essence_cloud": "稀释末影精华云",
    "entity.botania.pure_ender_essence_cloud": "纯净末影精华云",
    "entity.botania.ender_essence_flask": "末影精华烧瓶",
    "botania.entry.enderEssence": "末影精华",
    "botania.entry.petalPouch": "花瓣袋",
    "botania.tagline.enderEssence": "可投掷的末地石制造瓶",
    "botania.tagline.petalPouch": "装饰完了之后的去处",
    "botania.subtitle.enderEssenceFill": "烧瓶已装满",
    "botania.subtitle.enderEssenceThrow": "末影精华烧瓶：扔出",
    "botania.subtitle.petalPouchConfigure": "花瓣袋：设置",

    # ===== 旗帜图案 =====
    "item.botania.botania_banner_pattern": "旗帜图案",
    "item.botania.botania_banner_pattern.desc": "Botania",
    "item.botania.materials_banner_pattern": "旗帜图案",
    "item.botania.materials_banner_pattern.desc": "材料",
    "item.botania.tools_banner_pattern": "旗帜图案",
    "item.botania.tools_banner_pattern.desc": "工具",
    "item.botania.spark_augments_banner_pattern": "旗帜图案",
    "item.botania.spark_augments_banner_pattern.desc": "魔力火花强化",

    # ===== 唱片曲名（保留原文，与既有 gaia 唱片一致）=====
    "item.botania.scathed_music_disc_1.desc": "Kain Vinosec - Endure Emptiness",
    "item.botania.scathed_music_disc_2.desc": "Kain Vinosec - Fight For Quiescence",

    # ===== 花瓣药剂台变体 =====
    "block.botania.blackstone_petal_apothecary": "黑石花瓣药剂台",
    "block.botania.nether_brick_petal_apothecary": "下界砖花瓣药剂台",
    "block.botania.red_nether_brick_petal_apothecary": "红色下界砖花瓣药剂台",
    "block.botania.dandelifeon.reference": "这就是生活",

    # ===== 成就（多为歌名梗，按字面译）=====
    "advancement.botania:allLooniumMobs": "王",
    "advancement.botania:baubleWear": "内在技艺",
    "advancement.botania:corporeaCraft": "数据包英雄",
    "advancement.botania:craftingHaloCraft": "蓝色片段",
    "advancement.botania:dandelifeonPickup": "甜甜圈洞",
    "advancement.botania:dirtRodCraft": "岩石铃",
    "advancement.botania:elfPortalOpen": "世界的呼唤",
    "advancement.botania:enderEssenceMake": "仿制空气",
    "advancement.botania:enderEssenceMake.desc": "收集一瓶末影精华",
    "advancement.botania:flowerPickup": "初始之空",
    "advancement.botania:flugelEye": "死亡天使",
    "advancement.botania:gaiaGuardianKill": "死亡捉迷藏",
    "advancement.botania:generatingFlower": "电气魔法",
    "advancement.botania:infiniteFruit": "纯真",
    "advancement.botania:kingKey": "虚假的、虚假的迷幻",
    "advancement.botania:lokiRing": "算术",
    "advancement.botania:lokiRingMany": "手牵手",
    "advancement.botania:manaBombIgnite": "碎片之下",
    "advancement.botania:manaPoolPickup": "鲜艳的波浪",
    "advancement.botania:runePickup": "滴落流行糖果",
    "advancement.botania:sparkCraft": "现场驱动",
    "advancement.botania:superCorporeaRequest": "入侵者女孩",
    "advancement.botania:terrasteelPickup": "黑暗中的舞者",
    "advancement.botania:the_pinkinator": "装饰者",
    "advancement.botania:thorRing": "一步分层",
    "advancement.botania:tiaraWings": "心灵射手",
    "advancement.botania:tinyPotatoBirthday": "祝福",
    "advancement.botania:tinyPotatoPet": "只是朋友",

    # ===== 死亡消息 =====
    "death.attack.botania.portal_bread_explosion": "%1$s 发现精灵不喜欢面包",
    "death.attack.botania.portal_bread_explosion.link": "精灵不喜欢面包",
    "death.attack.botania.portal_bread_explosion.message": "%1$s 发现了 %2$s",

    # ===== 统计 =====
    "stat.botania.mana_lenses_cleaned": "清洗魔力透镜次数",
    "stat.botania.mana_pools_cleaned": "清洗魔力池次数",
    "stat.botania.phantom_ink_cleaned": "洗除幻影墨水次数",
    "key.categories.botania": "Botania",

    # ===== 原版结构名（Botania 补的）=====
    "structure.minecraft.igloo": "雪屋",
    "structure.minecraft.nether_fossil": "下界化石",
    "structure.minecraft.swamp_hut": "沼泽小屋",
    "structure.minecraft.trial_chambers": "试炼密室",

    # ===== 界面/模板字符串 =====
    "botaniamisc.astrolabe.size": "%1$s×%1$s",
    "botaniamisc.catalyst_not_consumed": "（不消耗）",
    "botaniamisc.count.stacks_no_remainder": "%1$s×%2$s",
    "botaniamisc.count.stacks_with_remainder": "%1$s×%2$s+%3$s",
    "botaniamisc.dev_build_warning": "§4[警告]§r <Botania>：请注意你正在使用本模组的开发版。此版本可能包含会损坏存档的严重漏洞，用此版本创建/升级的世界也可能无法与未来的正式版兼容。（希望你已备份，否则无法降级世界。）",
    "botaniamisc.enderPickpocketing": "%s 的末影箱",
    "botaniamisc.eye_of_the_ancients.adult_animals": "统计成年生物",
    "botaniamisc.eye_of_the_ancients.all_animals": "统计所有生物",
    "botaniamisc.eye_of_the_ancients.baby_animals": "统计幼年生物",
    "botaniamisc.monocle.comparator.compare": "≥",
    "botaniamisc.monocle.comparator.subtract": "-",
    "botaniamisc.monocle.daylight_detector.day": "☀ %s",
    "botaniamisc.monocle.daylight_detector.night": "☽ %s",
    "botaniamisc.monocle.repeater.delay": "%s秒",
    "botaniamisc.monocle.repeater.locked": "%s 🔒",
    "botaniamisc.monocle.sculk_sensor.active": "%s",
    "botaniamisc.monocle.sculk_sensor.cooldown": "🛌",
    "botaniamisc.monocle.sculk_sensor.inactive": "%s",
    "botaniamisc.sextantMode.circle_x": "垂直圆周 东/西",
    "botaniamisc.sextantMode.circle_z": "垂直圆周 南/北",
    "botaniamisc.speedrun_category.blessing": "祝福%%",
    "botaniamisc.speedrun_category.gaia_i": "击败盖亚守护者 I",
    "botaniamisc.speedrun_category.gaia_ii": "击败盖亚守护者 II",
    "botaniamisc.speedrun_category.obtain_dreamwood": "获得梦之木",
    "botaniamisc.template.n_of_m": "%1$s/%2$s",
    "botaniamisc.template.num_and_name": "%1$s %2$s",
    "botaniamisc.template.parenthesis_suffix": "%1$s（%2$s）",
    "botaniamisc.template.tooltip_list": " - %s",
    "botaniamisc.wandMode.binding": "绑定：%s",

    # ===== 播放/台词类 =====
    "botania.subtitle.doit": "去做吧！！",
    "botania.subtitle.way": "O-oooooooooo AAAAE-A-A-I-A-U-JO-oooooooooooo AAE-O-A-A-U-U-A-E-eee-ee-eee AAAAE-A-E-I-E-A-JO-ooo-oo-oo-oo EEEEO-A-AAA-AAAA",
    "botania.tater_birthday.4": "呜呼！！！",
    "botania.tater_birthday.speedrun.0": "哇，这是给我的吗？",
    "botania.tater_birthday.speedrun.1": "不过今天不是我生日。",
    "botania.tater_birthday.speedrun.2": "还是谢谢你！希望你对你的速通成绩满意。",
    "botania.tater_birthday.speedrun.3": "永远记住：我相信你，你一定做得到！❤",
    "botania.tater_birthday.speedrun.4": "呜呼！！！",
    "botania.page.blazeBlock1": "0x1a4",
    "botania.page.cosmeticBaubles11": "伞倾得太厉害了",
    "botania.page.cosmeticBaubles16": "裸体主义万岁",
    "botania.page.cosmeticBaubles18": "潜得更深",
    "botania.page.elfMessage0": "",
    "botania.page.enderEyeBlock1": "我的牌子",
    "botania.page.manaVoid1": "连会计部的查德也算？",
    "botania.page.spectranthemum3": "$(o)(n)诡异(n+2)如我$()。",

    # ===== 末影精华书页（新机制说明）=====
    "botania.page.enderEssenceExtraction": "$(thing)末地$(0)虚空中存在某些具有变异特性的物质，但通常过于稀薄，无法直接采集。$(p)需要合适的工具才能从特定生物、甚至那里的岩石中提取出这种$(item)末影精华$(0)。",
    "botania.page.enderDaggerExtractingEssence": "用这件武器给$(thing)末影人$(0)最后一击，似乎会产生一个有趣的副作用：垂死的末影人会向周围的空气中释放某种$(l:ender/ender_essence)$(item)精华$(0)$(/l)。",
    "botania.page.enderEssenceCapture": "无论以何种方式提取，精华都会形成一朵迅速消散的小云。用魔力强化材料制成、开口足够大的可密封容器，应该能捕获这种云中的大部分精华。$(p)用朝向云朵的$(item)发射器$(0)也许还能实现自动化。",
    "botania.page.enderEssenceFromEndermen": "提取末影精华的方法之一，是用$(l:ender/soulscribe)灵魂匕首$(/l)直接从$(thing)末影人$(0)身上剜出来。这种方法相当粗暴，而且在末地之外使用时只能得到稀释形态的精华。$(p)不过即便是这种$(item)稀释的末影精华$(0)，对某些用途来说也足够了。",
    "botania.page.enderEssenceFromEndstone": "作为$(l:basics/pure_daisy)净化$(/l)$(item)末地石$(0)的副产物提取时，即使身处$(thing)主世界$(0)空气中，也能得到纯度惊人的末影精华。",
    "botania.page.enderEssenceGhastIrritation": "经「实验」证明，$(item)末影精华$(0)云与普通$(thing)主世界$(0)空气混合后，对某些$(thing)下界$(0)生物（比如$(thing)恶魂$(0)）有剧毒。$(p)虽然一般容器里的量太少，造成不了实质伤害，但用来激怒它们绝对有效。$(p)尤其是纯精华弄进眼睛里的时候。",
    "botania.page.enderEssenceStoneConversion": "足够$(item)纯净的末影精华$(0)能把$(item)石头$(0)变成$(item)末地石$(0)。最好的做法是直接在石头上摔碎容器——扔出去或使用$(item)发射器$(0)都行。$(p)从这种「人造」末地石中提取精华，效率和天然岩石一样高。",
    "botania.page.flasksEnderEssence": "$(item)精灵玻璃烧瓶$(0)较宽的瓶口也适合捕获$(l:ender/ender_essence)$(item)末影精华$(0)$(/l)。当$(item)末地石$(0)被$(l:basics/pure_daisy)净化$(/l)，或$(l:functional_flowers/vinculotus)$(item)束缚莲$(0)$(/l)剥夺了$(thing)末影人$(0)的传送能力时，形成的精华云可以用手或$(item)发射器$(0)收集。",

    # ===== 花瓣袋书页 =====
    "botania.page.petalPouch0": "事实证明，把一些$(l:mana/pool#mana_dust)$(item)魔力之尘$(0)$(/l)揉进$(l:basics/flower_pouch)$(item)采花袋$(0)$(/l)的布料里，袋中的$(l:basics/flowers)$(item)神秘花$(0)$(/l)就会被分解，只留下花瓣。$(p)潜行右击可切换$(item)花瓣袋$(0)的花朵自动拾取。除此之外，它拾取花瓣和$(l:misc/mushrooms)$(item)微光蘑菇$(0)$(/l)的方式与采花袋相同。",
    "botania.page.petalPouch_crafting": "自动合成的一丝线索",

    # ===== 幻影墨水书页 =====
    "botania.page.phantomInk2": "$(item)幻影墨水$(0)也能用在较小的饰品上，比如项链或护符，佩戴时把它们隐藏起来。不过对工具或武器无效。$(p)如果哪天又想让物品重新显形，也可以在水炼药锅里把墨水洗掉。",
    "botania.page.phantomInk3": "$(item)幻影墨水$(0)甚至能直接用在已经放置在世界里的某些东西上，比如$(l:mana/sparks)$(item)魔力火花$(0)$(/l)、$(l:devices/platform)$(item)玄奥平台$(0)$(/l)或$(item)物品展示框$(0)，以降低它们的可见度。$(p)不过这样施加的效果没那么持久——破坏物件也会终止其上的幻影墨水效果。",

    # ===== 流明线书页 =====
    "botania.page.luminizerTransport12": "相连的$(item)流明线$(0)之间的光轨会发出明亮的闪烁粒子，指示连接方向。$(p)在连接起点处施加$(l:misc/phantom_ink)$(item)幻影墨水$(0)$(/l)，就能在不影响功能的前提下隐藏这些可见的光轨。",

    # ===== 炼金术书页 =====
    "botania.page.manaAlchemyBlockConversions": "其他各种有用的方块转化",
    "botania.page.manaAlchemyBlockConversions.title": "杂项方块转化",
    "botania.page.manaAlchemyItemConversions": "其他各种有用的物品转化",
    "botania.page.manaAlchemyItemConversions.title": "杂项物品转化",
    "botania.page.manaAlchemyLosslessDeconstruction": "分解你自己也能分解的方块……",
    "botania.page.manaAlchemyLosslessDeconstruction.title": "无损分解",
    "botania.page.manaAlchemyLossyDeconstruction": "……以及你分解不了的。",
    "botania.page.manaAlchemyLossyDeconstruction.title": "有损分解",
    "botania.page.manaAlchemyStems": "转化$(item)菌柄$(0)",
    "botania.page.manaAlchemyStems.title": "下界菌柄",
    "botania.page.manaAlchemyFungi": "转化$(item)菌类$(0)",
    "botania.page.manaAlchemyFungi.title": "下界菌类",
    "botania.page.manaAlchemyNetherRocks": "转化下界岩石",
    "botania.page.manaAlchemyNetherRocks.title": "下界岩石",
    "botania.page.manaAlchemyGunpowderAndFlint.title": "火药与燧石",

    # ===== 纯雏菊书页 =====
    "botania.page.pureDaisyCalcite": "把$(item)滴水石$(0)净化为$(item)方钙石$(0)",
    "botania.page.pureDaisyCompactingIce": "做点更凉快的东西",
    "botania.page.pureDaisyCompactingIce.title": "压缩冰",
    "botania.page.pureDaisyLivingWood": "连加工过的$(item)活木$(0)变体也能还原成$(item)活木原木$(0)",
    "botania.page.pureDaisyNetherResources": "净化$(thing)下界$(0)资源",
    "botania.page.pureDaisyObsidian": "用$(l:misc/blaze_mesh)$(item)烈焰网$(0)$(/l)制造$(item)黑曜石$(0)",
    "botania.page.pool3_crafting": "$(item)魔钢$(0)块与粒",

    # ===== 标签（JEI 可见）=====
    "tag.entity_type.botania.cocoon.common": "常见茧生物",
    "tag.entity_type.botania.cocoon.common_aquatic": "常见水生茧生物",
    "tag.entity_type.botania.cocoon.rare": "稀有茧生物",
    "tag.entity_type.botania.cocoon.rare_aquatic": "稀有水生茧生物",
    "tag.entity_type.botania.drum.milkable": "可被聚集之鼓挤奶",
    "tag.entity_type.botania.drum.no_shearing": "不被聚集之鼓剪毛",
    "tag.entity_type.botania.ender_essence_clouds": "末影精华云",
    "tag.entity_type.botania.key_immune": "免疫王之宝钥",
    "tag.entity_type.botania.not_charmable": "免疫歌姬魅惑",
    "tag.entity_type.botania.portal_bread_immune": "免疫传送面包",
    "tag.entity_type.botania.shaded_mesa_no_pickup": "不被荫蔽台地之杖拾起",
    "tag.fluid.botania.hydroangeas_consumable": "可被水绣球消耗",
    "tag.fluid.botania.thermalily_consumable": "可被炽玫瑰消耗",
    "tag.item.botania.all_mana_pools": "所有魔力池",
    "tag.item.botania.ancient_wills": "远古意志",
    "tag.item.botania.contributor_headflowers": "Botania 贡献者头颅花",
    "tag.item.botania.creative_mana_pools": "创造魔力池",
    "tag.item.botania.diluted_mana_pools": "稀释魔力池",
    "tag.item.botania.dims_floating_flowers": "变暗的浮空花",
    "tag.item.botania.disposable": "一次性掉落物",
    "tag.item.botania.dominant_spark_pull_source": "火花抽取主源",
    "tag.item.botania.dyed_creative_mana_pools": "染色创造魔力池",
    "tag.item.botania.dyed_diluted_mana_pools": "染色稀释魔力池",
    "tag.item.botania.dyed_fabulous_mana_pools": "染色神话魔力池",
    "tag.item.botania.dyed_mana_pools": "染色魔力池",
    "tag.item.botania.ender_essences": "末影精华",
    "tag.item.botania.fabulous_mana_pools": "神话魔力池",
    "tag.item.botania.functional_floating_flowers": "功能浮空花",
    "tag.item.botania.generating_floating_flowers": "产能浮空花",
    "tag.item.botania.glimmering_flowers": "微光花",
    "tag.item.botania.ignored_by_endoflame": "不被火红莲识别",
    "tag.item.botania.loonium_excluded": "不参与狂喜花",
    "tag.item.botania.mana_gems": "魔力宝石",
    "tag.item.botania.mana_pool_dye_remover": "去除魔力池染色",
    "tag.item.botania.mana_pools": "魔力池",
    "tag.item.botania.mana_powder_source_dusts": "可制魔力之尘的粉末",
    "tag.item.botania.mana_spark_augments": "魔力火花强化",
    "tag.item.botania.misc_floating_flowers": "杂项浮空花",
    "tag.item.botania.petal_apothecaries": "花瓣药剂台",
    "tag.item.botania.pickable_block_providers": "可拾取方块提供者",
    "tag.item.botania.quartz_blocks": "石英块",
    "tag.item.botania.recessive_spark_push_target": "火花推送从属目标",
    "tag.item.botania.ring_of_magnetization_ignored": "不被磁化之戒识别",
    "tag.item.botania.semi_disposable": "半一次性掉落物",
    "tag.item.botania.tool_placeable.axe": "可被魔力斧放置",
    "tag.item.botania.tool_placeable.pickaxe": "可被魔力镐放置",
    "tag.item.botania.undims_floating_flowers": "增亮的浮空花",
    "tag.item.botania.wooden_walls": "木质墙",
    "tag.item.c.buckets.extrapolating": "外推桶",
    "tag.item.c.dusts.pixie": "精灵之尘",
    "tag.item.c.gems.blaze_quartz": "烈焰石英",
    "tag.item.c.gems.elven_quartz": "精灵石英",
    "tag.item.c.gems.lavender_quartz": "熏香石英",
    "tag.item.c.gems.mana_pearl": "魔力珍珠",
    "tag.item.c.gems.mana_quartz": "魔力石英",
    "tag.item.c.gems.red_quartz": "红色石英",
    "tag.item.c.gems.smokey_quartz": "烟熏石英",
    "tag.item.c.gems.sunny_quartz": "金黄石英",
    "tag.item.c.glass_blocks.mana": "魔力玻璃方块",
    "tag.item.c.glass_panes.mana": "魔力玻璃板",
    "tag.item.c.ingots.gaia": "盖亚锭",
    "tag.item.c.rods.dreamwood": "梦之木杆",
    "tag.item.c.rods.livingwood": "活木杆",
    "tag.item.c.storage_blocks.blaze": "烈焰存储方块",
    "tag.item.c.storage_blocks.dragonstone": "龙石存储方块",
    "tag.item.c.storage_blocks.mana_diamond": "魔力钻石存储方块",
    "tag.item.c.storage_blocks.petal": "花瓣存储方块",
    "tag.block.botania.agricarnation.apply_bonemeal": "农业之星可施加骨粉",
    "tag.block.botania.agricarnation.growth_candidate": "农业之星催熟对象",
    "tag.block.botania.agricarnation.growth_excluded": "不受农业之星催熟",
    "tag.block.botania.all_covered_mana_spreaders": "所有覆膜魔力发射器",
    "tag.block.botania.all_mana_pools": "所有魔力池",
    "tag.block.botania.corporea_spark_override": "可放置多媒体火花",
    "tag.block.botania.covered_elven_mana_spreaders": "覆膜精灵魔力发射器",
    "tag.block.botania.covered_gaia_mana_spreaders": "覆膜盖亚魔力发射器",
    "tag.block.botania.covered_mana_spreaders": "覆膜魔力发射器",
    "tag.block.botania.covered_pulse_mana_spreaders": "覆膜红石魔力发射器",
    "tag.block.botania.creative_mana_pools": "创造魔力池",
    "tag.block.botania.diluted_mana_pools": "稀释魔力池",
    "tag.block.botania.dyed_creative_mana_pools": "染色创造魔力池",
    "tag.block.botania.dyed_diluted_mana_pools": "染色稀释魔力池",
    "tag.block.botania.dyed_fabulous_mana_pools": "染色神话魔力池",
    "tag.block.c.glass_blocks.mana": "魔力玻璃方块",
    "tag.block.c.glass_panes.mana": "魔力玻璃板",
    "tag.block.c.storage_blocks.blaze": "烈焰存储方块",
    "tag.block.c.storage_blocks.dragonstone": "龙石存储方块",
    "tag.block.c.storage_blocks.mana_diamond": "魔力钻石存储方块",
    "tag.block.c.storage_blocks.petal": "花瓣存储方块",

    # ===== tag.block.botania.*（JEI 里可见的方块标签）=====
    "tag.block.botania.agricarnation.apply_bonemeal": "农业之星可作骨粉施加",
    "tag.block.botania.agricarnation.growth_candidate": "农业之星催熟对象",
    "tag.block.botania.agricarnation.growth_excluded": "不受农业之星催熟",
    "tag.block.botania.all_covered_mana_spreaders": "所有覆膜魔力发射器",
    "tag.block.botania.all_mana_pools": "所有魔力池",
    "tag.block.botania.corporea_spark_override": "可承载多媒体火花",
    "tag.block.botania.covered_elven_mana_spreaders": "覆膜精灵魔力发射器",
    "tag.block.botania.covered_gaia_mana_spreaders": "覆膜盖亚魔力发射器",
    "tag.block.botania.covered_mana_spreaders": "覆膜魔力发射器",
    "tag.block.botania.covered_pulse_mana_spreaders": "覆膜红石魔力发射器",
    "tag.block.botania.creative_mana_pools": "创造魔力池",
    "tag.block.botania.diluted_mana_pools": "稀释魔力池",
    "tag.block.botania.dyed_creative_mana_pools": "染色创造魔力池",
    "tag.block.botania.dyed_diluted_mana_pools": "染色稀释魔力池",
    "tag.block.botania.dyed_fabulous_mana_pools": "染色神话魔力池",
    "tag.block.botania.dyed_mana_pools": "染色魔力池",
    "tag.block.botania.enchanter_flowers": "可用于魔力附魔台的花",
    "tag.block.botania.ender_essence_convertable": "可被末影精华转化",
    "tag.block.botania.fabulous_mana_pools": "神话魔力池",
    "tag.block.botania.fel_blaze_base": "邪焰底座方块",
    "tag.block.botania.functional_floating_flowers": "功能浮空花",
    "tag.block.botania.gaia_guardian_immune": "免疫盖亚守护者",
    "tag.block.botania.generating_floating_flowers": "产能浮空花",
    "tag.block.botania.glimmering_flowers": "微光花",
    "tag.block.botania.horn_of_the_canopy_breakable": "可被林冠之角破坏",
    "tag.block.botania.horn_of_the_covering_breakable": "可被覆盖之角破坏",
    "tag.block.botania.horn_of_the_wild_breakable": "可被荒野之角破坏",
    "tag.block.botania.horn_of_the_wild_immune": "免疫荒野之角",
    "tag.block.botania.laputa_immobile": "拉普达碎片无法移动",
    "tag.block.botania.laputa_no_double_block": "拉普达碎片不视作双格方块",
    "tag.block.botania.mana_pools": "魔力池",
    "tag.block.botania.marimorphosis_convertable": "可被巨量拟态转化",
    "tag.block.botania.mineable.vitreous_pickaxe": "可被琉璃镐开采",
    "tag.block.botania.misc_floating_flowers": "杂项浮空花",
    "tag.block.botania.munchdew_consumable": "可被贪食花消耗",
    "tag.block.botania.pasture_seed_replaceable": "可被牧草种子替换",
    "tag.block.botania.potted_glimmering_flowers": "微光花盆栽",
    "tag.block.botania.potted_mystical_flowers": "神秘花盆栽",
    "tag.block.botania.quartz_blocks": "石英块",
    "tag.block.botania.ring_of_the_mantle.affected": "受地幔之戒影响",
    "tag.block.botania.ring_of_the_mantle.harder": "地幔之戒的坚硬方块",
    "tag.block.botania.rod_of_the_plentiful_mantle_highlighted": "被丰饶地幔之杖高亮",
    "tag.block.botania.sheep_edible_grasses": "绵羊可食草类",
    "tag.block.botania.shields_from_ring_of_magnetization": "磁化之戒可防御",
    "tag.block.botania.single_item_insert": "单物品插入",
    "tag.block.botania.spectral_rail_barrier": "幽魂铁轨屏障",
    "tag.block.botania.terra_plate_base": "泰拉凝聚板底座材料",
    "tag.block.botania.terra_truncator.crown_blocks": "泰拉剪枝器的树冠方块",
    "tag.block.botania.terra_truncator.trunk_blocks": "泰拉剪枝器的树干方块",
    "tag.block.botania.terraformable": "可被大地改造",
    "tag.block.botania.unethical_tnt_check": "额外道德 TNT 检查候选",
    "tag.block.botania.unsupported_platform_disguise": "不支持伪装平台",
    "tag.block.botania.unwandable": "森林法杖不可操作",
    "tag.block.botania.vitreous_pickaxe_silktouched": "琉璃镐精准采集",
    "tag.block.botania.weight_lens_affected": "受负重透镜影响",
    "tag.block.botania.wooden_walls": "木质墙",

    # ===== tag.worldgen.botania.*（生物群系标签）=====
    "tag.worldgen.botania.biome.marimorphosis_cataclasite_bonus": "巨量拟态对变质沼泽石的加成",
    "tag.worldgen.botania.biome.marimorphosis_fuchsite_bonus": "巨量拟态对变质森林石的加成",
    "tag.worldgen.botania.biome.marimorphosis_gneiss_bonus": "巨量拟态对变质高山石的加成",
    "tag.worldgen.botania.biome.marimorphosis_lunite_bonus": "巨量拟态对变质雪原石的加成",
    "tag.worldgen.botania.biome.marimorphosis_mycelite_bonus": "巨量拟态对变质菌丝石的加成",
    "tag.worldgen.botania.biome.marimorphosis_rosy_talc_bonus": "巨量拟态对变质高原石的加成",
    "tag.worldgen.botania.biome.marimorphosis_solite_bonus": "巨量拟态对变质沙漠石的加成",
    "tag.worldgen.botania.biome.marimorphosis_talc_bonus": "巨量拟态对变质平原石的加成",
    "tag.worldgen.botania.biome.mystical_flower_blocklist": "禁止生成神秘花簇",
    "tag.worldgen.botania.biome.mystical_flower_spawnlist": "生成神秘花簇",
    "tag.worldgen.botania.biome.orechid_deepslate_copper_bonus": "凝矿兰对深层铜矿石的加成",
    "tag.worldgen.botania.biome.orechid_deepslate_emerald_bonus": "凝矿兰对深层绿宝石矿石的加成",
    "tag.worldgen.botania.biome.orechid_stone_copper_bonus": "凝矿兰对石头铜矿石的加成",
    "tag.worldgen.botania.biome.orechid_stone_emerald_bonus": "凝矿兰对石头绿宝石矿石的加成",
    "tag.worldgen.botania.biome.orechid_stone_gold_bonus": "凝矿兰对石头金矿石的加成",
    "tag.worldgen.botania.biome.shimmering_mushroom_blocklist": "禁止生成微光蘑菇",
    "tag.worldgen.botania.biome.shimmering_mushroom_spawnlist": "生成微光蘑菇",
}


# ---------------------------------------------------------------- 程序化生成

def systematic(key: str, en: str) -> str | None:
    """颜色/材质变体，按模板拼装。返回 None 表示需要手工翻译。"""
    if key.startswith("block.botania."):
        b = key[len("block.botania."):]

        # 染色魔力池：{color}_{pool}
        for c, cz in COLORS.items():
            for p, pz in POOLS.items():
                if b == f"{c}_{p}":
                    return f"{cz}{pz}"

        # 覆膜发射器：{color}_covered_{spreader}
        for c, cz in COLORS.items():
            for s, sz in SPREADERS.items():
                if b == f"{c}_covered_{s}":
                    return f"{cz}覆膜{sz}"

        # 石英砖
        for q, qz in QUARTZ.items():
            if b == f"{q}_quartz_bricks":
                return f"{qz}石英砖"

        # 平滑石英系列
        if b.startswith("smooth_"):
            rest = b[len("smooth_"):]
            for suf, sufz in (("_quartz_block", "石英块"),
                              ("_quartz_slab", "石英台阶"),
                              ("_quartz_stairs", "石英楼梯")):
                if rest.endswith(suf):
                    q = rest[: -len(suf)]
                    if q in QUARTZ:
                        return f"平滑{QUARTZ[q]}{sufz}"

        # 木石建材：{material}_{suffix}
        for m, mz in WOOD.items():
            if b.startswith(f"{m}_"):
                suf = b[len(m) + 1:]
                if suf in SUFFIX:
                    return f"{mz}{SUFFIX[suf]}"

    # 标签：花瓣存储方块（16 色）
    for ns in ("tag.item", "tag.block"):
        pre = f"{ns}.c.cobblestones.metamorphic."
        if key == f"{ns}.c.cobblestones.metamorphic":
            return "变质圆石"
        if key.startswith(pre):
            m = key[len(pre):]
            if m in WOOD:
                return f"{WOOD[m]}圆石"
        pre2 = f"{ns}.c.storage_blocks.petal."
        if key == f"{ns}.c.storage_blocks.petal":
            return "花瓣存储方块"
        if key.startswith(pre2):
            c = key[len(pre2):]
            if c in COLORS:
                return f"{COLORS[c]}花瓣存储方块"

    # 巨量拟态加成
    pre = "tag.worldgen.botania.biome.marimorphosis_"
    if key.startswith(pre) and key.endswith("_bonus"):
        m = key[len(pre):-len("_bonus")]
        if m in WOOD:
            return f"巨量拟态对{WOOD[m]}的加成"

    # 罗马数字 / 段位：纯符号，直接照搬英文（Botania 用它们做索引编号）
    if key.startswith("botania.roman") or key.startswith("botania.rank"):
        return en

    return None


def main() -> int:
    check_only = "--check" in sys.argv
    jars = sorted((ROOT / "mods").glob("botania*.jar"))
    if not jars:
        print("!! 找不到 botania jar")
        return 1
    with zipfile.ZipFile(jars[0]) as z:
        en = json.loads(z.read("assets/botania/lang/en_us.json"))
        zh = json.loads(z.read("assets/botania/lang/zh_cn.json"))

    existing = json.loads(OUT.read_text(encoding="utf-8")) if OUT.exists() else {}
    out = dict(existing)

    added_sys = added_man = 0
    unresolved: list[str] = []
    for k, v in en.items():
        if k in zh or k in out:
            continue
        z = systematic(k, v)
        if z is not None:
            out[k] = z
            added_sys += 1
            continue
        if k in MANUAL:
            out[k] = MANUAL[k]
            added_man += 1
            continue
        unresolved.append(k)

    total_missing = len(set(en) - set(zh))
    print(f"jar zh_cn 已有 {len(zh)} 键，缺失 {total_missing} 键")
    print(f"本次新增：模板生成 {added_sys} + 手工翻译 {added_man} = {added_sys + added_man}")
    print(f"仍未覆盖：{len(unresolved)}")
    for k in unresolved[:40]:
        print(f"  · {k} = {en[k][:70]}")

    covered = len(set(en) & (set(zh) | set(out)))
    print(f"\n覆盖率：{covered}/{len(en)} = {covered / len(en) * 100:.1f}%")

    if check_only:
        return 0 if not unresolved else 2

    merged = dict(sorted(out.items()))
    OUT.parent.mkdir(parents=True, exist_ok=True)
    OUT.write_text(json.dumps(merged, ensure_ascii=False, indent=4) + "\n", encoding="utf-8")
    print(f"\n已写入 {OUT.relative_to(ROOT)}（{len(merged)} 键）")
    return 0


if __name__ == "__main__":
    sys.exit(main())
