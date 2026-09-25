// ============================================================
// 磨粉机配方互通（小磨粉：OR 粉碎机 ↔ TR 磨粉机）
// ============================================================
// 目的：同一个输入不该因为"用哪台机器"而拿不到某个产物。
//   典型：末影珍珠 —— OR 粉碎机出 oritech:enderic_compound（Oritech 的 machine_core_4、
//   喷气背包都要它），而 TR 磨粉机原本只出 ender_pearl_dust，只造 TR 机器的玩家会卡进度。
//
// 为新时代的 AI 祝福，恰恰一次生成之后就没解决末影化合物的问题。
//
// 规则：
//   · 只做小磨粉对。工业研磨（TR 工业磨粉机 / OR 碎裂机）不参与互通。
//   · **机器输出槽限制**：TR 磨粉机只有 1 个输出槽，输出数 > 1 的配方执行必 NPE
//     （CrTNOTE §1.1 第 6 条），所以两台小磨粉上一律不允许有多输出配方 ——
//     文件开头先把原有的多输出配方全部 removeByName，再按 1 输出规则互通。
//   · 只补"另一侧完全做不出来的产物"；仅产出**数量**不同不算缺口
//     （uni.zs 已定 OR 为下位、TR 为上位，数量差是分层设计）。
//   · 等能耗移植：移到 TR 用 power 32（对齐 OR 粉碎机），移到 OR 用 P×T/32 折算 time。
//
// 由 scripts/tools/grind_parity_gen.py 生成，改完原配方重跑即可。
// ============================================================

// 多输出配方，TR 磨粉机只有 1 个输出槽 → 执行必 NPE，移除。（输入 c:raw_materials/copper）
<recipetype:oritech:pulverizer>.removeByName("oritech:pulverizer/raw/copper");
// 多输出配方，TR 磨粉机只有 1 个输出槽 → 执行必 NPE，移除。（输入 c:raw_materials/gold）
<recipetype:oritech:pulverizer>.removeByName("oritech:pulverizer/raw/gold");
// 多输出配方，TR 磨粉机只有 1 个输出槽 → 执行必 NPE，移除。（输入 c:raw_materials/iron）
<recipetype:oritech:pulverizer>.removeByName("oritech:pulverizer/raw/iron");
// 多输出配方，TR 磨粉机只有 1 个输出槽 → 执行必 NPE，移除。（输入 c:raw_materials/nickel）
<recipetype:oritech:pulverizer>.removeByName("oritech:pulverizer/raw/nickel");
// 多输出配方，TR 磨粉机只有 1 个输出槽 → 执行必 NPE，移除。（输入 c:raw_materials/platinum）
<recipetype:oritech:pulverizer>.removeByName("oritech:pulverizer/raw/platinum");
<recipetype:techreborn:grinder>.addJsonRecipe("grind.parity.pulverizer_biobasic", {type: "techreborn:grinder",
    outputs: [
        {id: "oritech:biomass", count: 1}
    ],
    power: 32, time: 100, ingredients: [{tag: "oritech:biomatter"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("grind.parity.pulverizer_dripstone", {type: "techreborn:grinder",
    outputs: [
        {id: "minecraft:pointed_dripstone", count: 4}
    ],
    power: 32, time: 100, ingredients: [{item: "minecraft:dripstone_block"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("grind.parity.pulverizer_dyes_black", {type: "techreborn:grinder",
    outputs: [
        {id: "minecraft:black_dye", count: 1}
    ],
    power: 32, time: 100, ingredients: [{tag: "c:raw_materials/dyes/black"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("grind.parity.pulverizer_dyes_blue", {type: "techreborn:grinder",
    outputs: [
        {id: "minecraft:blue_dye", count: 1}
    ],
    power: 32, time: 100, ingredients: [{tag: "c:raw_materials/dyes/blue"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("grind.parity.pulverizer_dyes_cyan", {type: "techreborn:grinder",
    outputs: [
        {id: "minecraft:cyan_dye", count: 1}
    ],
    power: 32, time: 100, ingredients: [{tag: "c:raw_materials/dyes/cyan"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("grind.parity.pulverizer_dyes_light_gray", {type: "techreborn:grinder",
    outputs: [
        {id: "minecraft:light_gray_dye", count: 1}
    ],
    power: 32, time: 100, ingredients: [{tag: "c:raw_materials/dyes/light_gray"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("grind.parity.pulverizer_dyes_magenta", {type: "techreborn:grinder",
    outputs: [
        {id: "minecraft:magenta_dye", count: 1}
    ],
    power: 32, time: 100, ingredients: [{tag: "c:raw_materials/dyes/magenta"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("grind.parity.pulverizer_dyes_orange", {type: "techreborn:grinder",
    outputs: [
        {id: "minecraft:orange_dye", count: 1}
    ],
    power: 32, time: 100, ingredients: [{tag: "c:raw_materials/dyes/orange"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("grind.parity.pulverizer_dyes_pink", {type: "techreborn:grinder",
    outputs: [
        {id: "minecraft:pink_dye", count: 1}
    ],
    power: 32, time: 100, ingredients: [{tag: "c:raw_materials/dyes/pink"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("grind.parity.pulverizer_dyes_red", {type: "techreborn:grinder",
    outputs: [
        {id: "minecraft:red_dye", count: 1}
    ],
    power: 32, time: 100, ingredients: [{tag: "c:raw_materials/dyes/red"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("grind.parity.pulverizer_dyes_white", {type: "techreborn:grinder",
    outputs: [
        {id: "minecraft:white_dye", count: 1}
    ],
    power: 32, time: 100, ingredients: [{tag: "c:raw_materials/dyes/white"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("grind.parity.pulverizer_dyes_yellow", {type: "techreborn:grinder",
    outputs: [
        {id: "minecraft:yellow_dye", count: 1}
    ],
    power: 32, time: 100, ingredients: [{tag: "c:raw_materials/dyes/yellow"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("grind.parity.pulverizer_gravel", {type: "techreborn:grinder",
    outputs: [
        {id: "minecraft:gravel", count: 1}
    ],
    power: 32, time: 100, ingredients: [{tag: "c:cobblestones"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("grind.parity.pulverizer_hay_block", {type: "techreborn:grinder",
    outputs: [
        {id: "oritech:biomass", count: 16}
    ],
    power: 32, time: 100, ingredients: [{tag: "c:storage_blocks/wheat"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("grind.parity.pulverizer_ore_platinum", {type: "techreborn:grinder",
    outputs: [
        {id: "oritech:raw_platinum", count: 2}
    ],
    power: 32, time: 150, ingredients: [{tag: "c:ores/platinum"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("grind.parity.pulverizer_packagedwheatbio", {type: "techreborn:grinder",
    outputs: [
        {id: "oritech:biomass", count: 16}
    ],
    power: 32, time: 100, ingredients: [{item: "oritech:packed_wheat"}]
});
/*
<recipetype:techreborn:grinder>.addJsonRecipe("grind.parity.pulverizer_pearl_enderic", {type: "techreborn:grinder",
    outputs: [
        {id: "oritech:enderic_compound", count: 8}
    ],
    power: 32, time: 100, ingredients: [{tag: "c:ender_pearls"}]
});
*/
<recipetype:techreborn:grinder>.addJsonRecipe("grind.parity.pulverizer_prismarine", {type: "techreborn:grinder",
    outputs: [
        {id: "minecraft:prismarine_crystals", count: 2}
    ],
    power: 32, time: 100, ingredients: [{item: "minecraft:prismarine_shard"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("grind.parity.pulverizer_quartz", {type: "techreborn:grinder",
    outputs: [
        {id: "oritech:quartz_dust", count: 1}
    ],
    power: 32, time: 100, ingredients: [{tag: "c:gems/quartz"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("grind.parity.pulverizer_recycle_2_quartz_dust", {type: "techreborn:grinder",
    outputs: [
        {id: "oritech:quartz_dust", count: 2}
    ],
    power: 32, time: 100, ingredients: [{tag: "oritech:recyclable/quartz_dust_2"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("grind.parity.pulverizer_recycle_4_quartz_dust", {type: "techreborn:grinder",
    outputs: [
        {id: "oritech:quartz_dust", count: 4}
    ],
    power: 32, time: 100, ingredients: [{tag: "oritech:recyclable/quartz_dust_4"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("grind.parity.pulverizer_recycle_biomass", {type: "techreborn:grinder",
    outputs: [
        {id: "oritech:biomass", count: 1}
    ],
    power: 32, time: 100, ingredients: [{tag: "oritech:recyclable/biomass"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("grind.parity.pulverizer_recycle_copper_dust", {type: "techreborn:grinder",
    outputs: [
        {id: "oritech:copper_dust", count: 1}
    ],
    power: 32, time: 100, ingredients: [{tag: "oritech:recyclable/copper_dust"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("grind.parity.pulverizer_recycle_diamond", {type: "techreborn:grinder",
    outputs: [
        {id: "minecraft:diamond", count: 1}
    ],
    power: 32, time: 100, ingredients: [{tag: "oritech:recyclable/diamond"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("grind.parity.pulverizer_recycle_gold_dust", {type: "techreborn:grinder",
    outputs: [
        {id: "oritech:gold_dust", count: 1}
    ],
    power: 32, time: 100, ingredients: [{tag: "oritech:recyclable/gold_dust"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("grind.parity.pulverizer_recycle_gravel", {type: "techreborn:grinder",
    outputs: [
        {id: "minecraft:gravel", count: 1}
    ],
    power: 32, time: 100, ingredients: [{tag: "oritech:recyclable/gravel"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("grind.parity.pulverizer_recycle_iron_dust", {type: "techreborn:grinder",
    outputs: [
        {id: "oritech:iron_dust", count: 1}
    ],
    power: 32, time: 100, ingredients: [{tag: "oritech:recyclable/iron_dust"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("grind.parity.pulverizer_recycle_netherite_scrap", {type: "techreborn:grinder",
    outputs: [
        {id: "minecraft:netherite_scrap", count: 1}
    ],
    power: 32, time: 100, ingredients: [{tag: "oritech:recyclable/netherite_scrap"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("grind.parity.pulverizer_recycle_red_sand", {type: "techreborn:grinder",
    outputs: [
        {id: "minecraft:red_sand", count: 1}
    ],
    power: 32, time: 100, ingredients: [{tag: "oritech:recyclable/red_sand"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("grind.parity.pulverizer_recycle_redstone_dust", {type: "techreborn:grinder",
    outputs: [
        {id: "minecraft:redstone", count: 1}
    ],
    power: 32, time: 100, ingredients: [{tag: "oritech:recyclable/redstone_dust"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("grind.parity.pulverizer_recycle_sand", {type: "techreborn:grinder",
    outputs: [
        {id: "minecraft:sand", count: 1}
    ],
    power: 32, time: 100, ingredients: [{tag: "oritech:recyclable/sand"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("grind.parity.pulverizer_recycle_small_copper_dust", {type: "techreborn:grinder",
    outputs: [
        {id: "oritech:small_copper_dust", count: 1}
    ],
    power: 32, time: 100, ingredients: [{tag: "oritech:recyclable/small_copper_dust"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("grind.parity.pulverizer_recycle_small_gold_dust", {type: "techreborn:grinder",
    outputs: [
        {id: "oritech:small_gold_dust", count: 1}
    ],
    power: 32, time: 100, ingredients: [{tag: "oritech:recyclable/small_gold_dust"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("grind.parity.pulverizer_recycle_small_iron_dust", {type: "techreborn:grinder",
    outputs: [
        {id: "oritech:small_iron_dust", count: 1}
    ],
    power: 32, time: 100, ingredients: [{tag: "oritech:recyclable/small_iron_dust"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("grind.parity.pulverizer_recycle_string", {type: "techreborn:grinder",
    outputs: [
        {id: "minecraft:string", count: 2}
    ],
    power: 32, time: 100, ingredients: [{tag: "oritech:recyclable/string"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("grind.parity.pulverizer_red_sand", {type: "techreborn:grinder",
    outputs: [
        {id: "minecraft:red_sand", count: 1}
    ],
    power: 32, time: 100, ingredients: [{tag: "c:sandstone/red_blocks"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("grind.parity.pulverizer_sand_from_sandstone", {type: "techreborn:grinder",
    outputs: [
        {id: "minecraft:sand", count: 1}
    ],
    power: 32, time: 100, ingredients: [{tag: "c:sandstone/blocks"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("grind.parity.pulverizer_smalldust_copper", {type: "techreborn:grinder",
    outputs: [
        {id: "oritech:small_copper_dust", count: 1}
    ],
    power: 32, time: 100, ingredients: [{tag: "c:nuggets/copper"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("grind.parity.pulverizer_smalldust_gold", {type: "techreborn:grinder",
    outputs: [
        {id: "oritech:small_gold_dust", count: 1}
    ],
    power: 32, time: 100, ingredients: [{tag: "c:nuggets/gold"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("grind.parity.pulverizer_smalldust_iron", {type: "techreborn:grinder",
    outputs: [
        {id: "oritech:small_iron_dust", count: 1}
    ],
    power: 32, time: 100, ingredients: [{tag: "c:nuggets/iron"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("grind.parity.pulverizer_smalldust_nickel", {type: "techreborn:grinder",
    outputs: [
        {id: "oritech:small_nickel_dust", count: 1}
    ],
    power: 32, time: 100, ingredients: [{tag: "c:nuggets/nickel"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("grind.parity.pulverizer_smalldust_platinum", {type: "techreborn:grinder",
    outputs: [
        {id: "oritech:small_platinum_dust", count: 1}
    ],
    power: 32, time: 100, ingredients: [{tag: "c:nuggets/platinum"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("grind.parity.pulverizer_uranium", {type: "techreborn:grinder",
    outputs: [
        {id: "oritech:uranium_dust", count: 2}
    ],
    power: 32, time: 100, ingredients: [{tag: "c:raw_materials/uranium"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("grind.parity.pulverizer_uraniumcrystal", {type: "techreborn:grinder",
    outputs: [
        {id: "oritech:raw_uranium", count: 4}
    ],
    power: 32, time: 100, ingredients: [{item: "oritech:uranium_crystal"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("grind.parity.pulverizer_uraniumore", {type: "techreborn:grinder",
    outputs: [
        {id: "oritech:raw_uranium", count: 2}
    ],
    power: 32, time: 100, ingredients: [{tag: "c:ores/uranium"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("grind.parity.uni_oritech_pulverizer_coal", {type: "techreborn:grinder",
    outputs: [
        {id: "techreborn:coal_dust", count: 1}
    ],
    power: 32, time: 100, ingredients: [{tag: "minecraft:coals"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.compat_techreborn_grinder_raw_nickel", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:nickel_dust", count: 1}
    ],
    time: 31, ingredients: [{tag: "c:raw_materials/nickel"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_aluminum_dust_from_block", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:aluminum_dust", count: 9}
    ],
    time: 234, ingredients: [{tag: "c:storage_blocks/aluminum"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_amethyst_dust", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:amethyst_dust", count: 2}
    ],
    time: 34, ingredients: [{item: "minecraft:amethyst_block"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_andesite_dust", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:andesite_dust", count: 2}
    ],
    time: 34, ingredients: [{item: "minecraft:andesite"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_basalt_dust", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:basalt_dust", count: 1}
    ],
    time: 11, ingredients: [{tag: "c:basalt"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_black_concrete_powder_from_concrete", {type: "oritech:pulverizer",
    results: [
        {id: "minecraft:black_concrete_powder", count: 1}
    ],
    time: 25, ingredients: [{item: "minecraft:black_concrete"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_blue_concrete_powder_from_concrete", {type: "oritech:pulverizer",
    results: [
        {id: "minecraft:blue_concrete_powder", count: 1}
    ],
    time: 25, ingredients: [{item: "minecraft:blue_concrete"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_brass_dust_from_block", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:brass_dust", count: 9}
    ],
    time: 234, ingredients: [{tag: "c:storage_blocks/brass"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_bronze_dust_from_block", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:bronze_dust", count: 9}
    ],
    time: 234, ingredients: [{tag: "c:storage_blocks/bronze"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_brown_concrete_powder_from_concrete", {type: "oritech:pulverizer",
    results: [
        {id: "minecraft:brown_concrete_powder", count: 1}
    ],
    time: 25, ingredients: [{item: "minecraft:brown_concrete"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_calcite_dust", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:calcite_dust", count: 1}
    ],
    time: 25, ingredients: [{tag: "techreborn:calcite_dust_material"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_calcite_dust_2", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:calcite_dust", count: 2}
    ],
    time: 31, ingredients: [{item: "minecraft:conduit"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_calcite_small_dust", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:calcite_small_dust", count: 1}
    ],
    time: 6, ingredients: [{tag: "techreborn:calcite_small_dust_material"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_charcoal_dust", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:charcoal_dust", count: 1}
    ],
    time: 29, ingredients: [{item: "minecraft:charcoal"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_chrome_dust_from_block", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:chrome_dust", count: 9}
    ],
    time: 234, ingredients: [{tag: "c:storage_blocks/chromium"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_clay_dust", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:clay_dust", count: 1}
    ],
    time: 11, ingredients: [{item: "minecraft:clay_ball"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_coal_dust", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:coal_dust", count: 1}
    ],
    time: 14, ingredients: [{item: "minecraft:coal"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_coal_dust_2", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:coal_dust", count: 9}
    ],
    time: 25, ingredients: [{item: "minecraft:coal_block"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_cyan_concrete_powder_from_concrete", {type: "oritech:pulverizer",
    results: [
        {id: "minecraft:cyan_concrete_powder", count: 1}
    ],
    time: 25, ingredients: [{item: "minecraft:cyan_concrete"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_diamond_dust", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:diamond_dust", count: 1}
    ],
    time: 34, ingredients: [{tag: "c:gems/diamond"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_diamond_small_dust", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:diamond_small_dust", count: 5}
    ],
    time: 31, ingredients: [{tag: "minecraft:trim_templates"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_diorite_dust", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:diorite_dust", count: 1}
    ],
    time: 90, ingredients: [{item: "minecraft:diorite"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_electrum_dust_from_block", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:electrum_dust", count: 9}
    ],
    time: 234, ingredients: [{tag: "c:storage_blocks/electrum"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_emerald", {type: "oritech:pulverizer",
    results: [
        {id: "minecraft:emerald", count: 1}
    ],
    time: 34, ingredients: [{tag: "minecraft:emerald_ores"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_emerald_dust", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:emerald_dust", count: 1}
    ],
    time: 34, ingredients: [{tag: "c:gems/emerald"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_ender_eye_dust", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:ender_eye_dust", count: 2}
    ],
    time: 25, ingredients: [{item: "minecraft:ender_eye"}]
});
/*
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_ender_pearl_dust", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:ender_pearl_dust", count: 2}
    ],
    time: 25, ingredients: [{item: "minecraft:ender_pearl"}]
});
*/
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_endstone_dust", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:endstone_dust", count: 1}
    ],
    time: 25, ingredients: [{item: "minecraft:end_stone"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_flint_dust", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:flint_dust", count: 1}
    ],
    time: 17, ingredients: [{item: "minecraft:flint"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_glowstone_small_dust", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:glowstone_small_dust", count: 2}
    ],
    time: 19, ingredients: [{item: "minecraft:shroomlight"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_glowstone_small_dust_2", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:glowstone_small_dust", count: 1}
    ],
    time: 9, ingredients: [{item: "minecraft:glow_berries"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_granite_dust", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:granite_dust", count: 2}
    ],
    time: 34, ingredients: [{item: "minecraft:granite"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_gravel", {type: "oritech:pulverizer",
    results: [
        {id: "minecraft:gravel", count: 1}
    ],
    time: 11, ingredients: [{tag: "techreborn:gravel_material"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_gray_concrete_powder_from_concrete", {type: "oritech:pulverizer",
    results: [
        {id: "minecraft:gray_concrete_powder", count: 1}
    ],
    time: 25, ingredients: [{item: "minecraft:gray_concrete"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_green_concrete_powder_from_concrete", {type: "oritech:pulverizer",
    results: [
        {id: "minecraft:green_concrete_powder", count: 1}
    ],
    time: 25, ingredients: [{item: "minecraft:green_concrete"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_heartbreak_pottery_sherd", {type: "oritech:pulverizer",
    results: [
        {id: "minecraft:heartbreak_pottery_sherd", count: 1}
    ],
    time: 6, ingredients: [{item: "minecraft:heart_pottery_sherd"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_invar_dust_from_block", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:invar_dust", count: 9}
    ],
    time: 234, ingredients: [{tag: "c:storage_blocks/invar"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_light_blue_concrete_powder_from_concrete", {type: "oritech:pulverizer",
    results: [
        {id: "minecraft:light_blue_concrete_powder", count: 1}
    ],
    time: 25, ingredients: [{item: "minecraft:light_blue_concrete"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_light_gray_concrete_powder_from_concrete", {type: "oritech:pulverizer",
    results: [
        {id: "minecraft:light_gray_concrete_powder", count: 1}
    ],
    time: 25, ingredients: [{item: "minecraft:light_gray_concrete"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_lime_concrete_powder_from_concrete", {type: "oritech:pulverizer",
    results: [
        {id: "minecraft:lime_concrete_powder", count: 1}
    ],
    time: 25, ingredients: [{item: "minecraft:lime_concrete"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_magenta_concrete_powder_from_concrete", {type: "oritech:pulverizer",
    results: [
        {id: "minecraft:magenta_concrete_powder", count: 1}
    ],
    time: 25, ingredients: [{item: "minecraft:magenta_concrete"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_marble_dust", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:marble_dust", count: 1}
    ],
    time: 11, ingredients: [{tag: "c:limestone"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_marble_dust_2", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:marble_dust", count: 1}
    ],
    time: 11, ingredients: [{tag: "c:marble"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_netherite_scrap", {type: "oritech:pulverizer",
    results: [
        {id: "minecraft:netherite_scrap", count: 2}
    ],
    time: 25, ingredients: [{item: "minecraft:ancient_debris"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_netherrack_dust", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:netherrack_dust", count: 1}
    ],
    time: 25, ingredients: [{item: "minecraft:netherrack"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_netherrack_dust_2", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:netherrack_dust", count: 1}
    ],
    time: 25, ingredients: [{item: "minecraft:crimson_nylium"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_netherrack_dust_3", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:netherrack_dust", count: 1}
    ],
    time: 25, ingredients: [{item: "minecraft:warped_nylium"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_nickel_dust_from_block", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:nickel_dust", count: 9}
    ],
    time: 234, ingredients: [{tag: "c:storage_blocks/nickel"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_obsidian_dust", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:obsidian_dust", count: 4}
    ],
    time: 75, ingredients: [{item: "minecraft:obsidian"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_orange_concrete_powder_from_concrete", {type: "oritech:pulverizer",
    results: [
        {id: "minecraft:orange_concrete_powder", count: 1}
    ],
    time: 25, ingredients: [{item: "minecraft:orange_concrete"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_peridot_dust_from_block", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:peridot_dust", count: 9}
    ],
    time: 94, ingredients: [{tag: "c:storage_blocks/peridot"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_pink_concrete_powder_from_concrete", {type: "oritech:pulverizer",
    results: [
        {id: "minecraft:pink_concrete_powder", count: 1}
    ],
    time: 25, ingredients: [{item: "minecraft:pink_concrete"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_platinum_dust_from_block", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:platinum_dust", count: 9}
    ],
    time: 234, ingredients: [{tag: "c:storage_blocks/platinum"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_prismarine_crystals", {type: "oritech:pulverizer",
    results: [
        {id: "minecraft:prismarine_crystals", count: 2}
    ],
    time: 25, ingredients: [{tag: "c:froglights"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_prismarine_crystals_2", {type: "oritech:pulverizer",
    results: [
        {id: "minecraft:prismarine_crystals", count: 4}
    ],
    time: 25, ingredients: [{item: "minecraft:sea_lantern"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_prismarine_shard", {type: "oritech:pulverizer",
    results: [
        {id: "minecraft:prismarine_shard", count: 7}
    ],
    time: 25, ingredients: [{item: "minecraft:prismarine_bricks"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_prismarine_shard_2", {type: "oritech:pulverizer",
    results: [
        {id: "minecraft:prismarine_shard", count: 3}
    ],
    time: 25, ingredients: [{item: "minecraft:prismarine"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_purple_concrete_powder_from_concrete", {type: "oritech:pulverizer",
    results: [
        {id: "minecraft:purple_concrete_powder", count: 1}
    ],
    time: 25, ingredients: [{item: "minecraft:purple_concrete"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_quartz_dust", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:quartz_dust", count: 1}
    ],
    time: 34, ingredients: [{item: "minecraft:quartz"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_quartz_dust_2", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:quartz_dust", count: 4}
    ],
    time: 135, ingredients: [{item: "minecraft:quartz_block"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_red_concrete_powder_from_concrete", {type: "oritech:pulverizer",
    results: [
        {id: "minecraft:red_concrete_powder", count: 1}
    ],
    time: 25, ingredients: [{item: "minecraft:red_concrete"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_red_garnet_dust_from_block", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:red_garnet_dust", count: 9}
    ],
    time: 94, ingredients: [{tag: "c:storage_blocks/red_garnet"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_red_sand_from_chiseled_red_sandstone", {type: "oritech:pulverizer",
    results: [
        {id: "minecraft:red_sand", count: 4}
    ],
    time: 25, ingredients: [{item: "minecraft:chiseled_red_sandstone"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_red_sand_from_cut_red_sandstone", {type: "oritech:pulverizer",
    results: [
        {id: "minecraft:red_sand", count: 4}
    ],
    time: 25, ingredients: [{item: "minecraft:cut_red_sandstone"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_red_sand_from_cut_red_sandstone_slab", {type: "oritech:pulverizer",
    results: [
        {id: "minecraft:red_sand", count: 2}
    ],
    time: 12, ingredients: [{item: "minecraft:cut_red_sandstone_slab"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_red_sand_from_red_sandstone", {type: "oritech:pulverizer",
    results: [
        {id: "minecraft:red_sand", count: 4}
    ],
    time: 25, ingredients: [{item: "minecraft:red_sandstone"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_red_sand_from_red_sandstone_slab", {type: "oritech:pulverizer",
    results: [
        {id: "minecraft:red_sand", count: 2}
    ],
    time: 12, ingredients: [{item: "minecraft:red_sandstone_slab"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_red_sand_from_red_sandstone_stairs", {type: "oritech:pulverizer",
    results: [
        {id: "minecraft:red_sand", count: 3}
    ],
    time: 19, ingredients: [{item: "minecraft:red_sandstone_stairs"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_red_sand_from_red_sandstone_wall", {type: "oritech:pulverizer",
    results: [
        {id: "minecraft:red_sand", count: 3}
    ],
    time: 19, ingredients: [{item: "minecraft:red_sandstone_wall"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_red_sand_from_smooth_red_sandstone", {type: "oritech:pulverizer",
    results: [
        {id: "minecraft:red_sand", count: 4}
    ],
    time: 25, ingredients: [{item: "minecraft:smooth_red_sandstone"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_red_sand_from_smooth_red_sandstone_slab", {type: "oritech:pulverizer",
    results: [
        {id: "minecraft:red_sand", count: 2}
    ],
    time: 12, ingredients: [{item: "minecraft:smooth_red_sandstone_slab"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_red_sand_from_smooth_red_sandstone_stairs", {type: "oritech:pulverizer",
    results: [
        {id: "minecraft:red_sand", count: 3}
    ],
    time: 19, ingredients: [{item: "minecraft:smooth_red_sandstone_stairs"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_ruby_dust_from_block", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:ruby_dust", count: 9}
    ],
    time: 94, ingredients: [{tag: "c:storage_blocks/ruby"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_sand_from_chiseled_sandstone", {type: "oritech:pulverizer",
    results: [
        {id: "minecraft:sand", count: 4}
    ],
    time: 25, ingredients: [{item: "minecraft:chiseled_sandstone"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_sand_from_cut_sandstone", {type: "oritech:pulverizer",
    results: [
        {id: "minecraft:sand", count: 4}
    ],
    time: 25, ingredients: [{item: "minecraft:cut_sandstone"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_sand_from_cut_sandstone_slab", {type: "oritech:pulverizer",
    results: [
        {id: "minecraft:sand", count: 2}
    ],
    time: 12, ingredients: [{item: "minecraft:cut_sandstone_slab"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_sand_from_sandstone", {type: "oritech:pulverizer",
    results: [
        {id: "minecraft:sand", count: 4}
    ],
    time: 25, ingredients: [{item: "minecraft:sandstone"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_sand_from_sandstone_slab", {type: "oritech:pulverizer",
    results: [
        {id: "minecraft:sand", count: 2}
    ],
    time: 12, ingredients: [{item: "minecraft:sandstone_slab"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_sand_from_sandstone_stairs", {type: "oritech:pulverizer",
    results: [
        {id: "minecraft:sand", count: 3}
    ],
    time: 19, ingredients: [{item: "minecraft:sandstone_stairs"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_sand_from_sandstone_wall", {type: "oritech:pulverizer",
    results: [
        {id: "minecraft:sand", count: 3}
    ],
    time: 19, ingredients: [{item: "minecraft:sandstone_wall"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_sand_from_smooth_sandstone", {type: "oritech:pulverizer",
    results: [
        {id: "minecraft:sand", count: 4}
    ],
    time: 25, ingredients: [{item: "minecraft:smooth_sandstone"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_sand_from_smooth_sandstone_slab", {type: "oritech:pulverizer",
    results: [
        {id: "minecraft:sand", count: 2}
    ],
    time: 12, ingredients: [{item: "minecraft:smooth_sandstone_slab"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_sand_from_smooth_sandstone_stairs", {type: "oritech:pulverizer",
    results: [
        {id: "minecraft:sand", count: 3}
    ],
    time: 19, ingredients: [{item: "minecraft:smooth_sandstone_stairs"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_sapphire_dust_from_block", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:sapphire_dust", count: 9}
    ],
    time: 94, ingredients: [{tag: "c:storage_blocks/sapphire"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_saw_small_dust_from_planks", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:saw_small_dust", count: 8}
    ],
    time: 17, ingredients: [{tag: "minecraft:planks"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_saw_small_dust_from_signs", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:saw_small_dust", count: 1}
    ],
    time: 17, ingredients: [{tag: "minecraft:signs"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_saw_small_dust_from_wooden_axe", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:saw_small_dust", count: 1}
    ],
    time: 17, ingredients: [{item: "minecraft:wooden_axe"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_saw_small_dust_from_wooden_doors", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:saw_small_dust", count: 3}
    ],
    time: 17, ingredients: [{tag: "minecraft:wooden_doors"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_saw_small_dust_from_wooden_fences", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:saw_small_dust", count: 1}
    ],
    time: 17, ingredients: [{tag: "minecraft:wooden_fences"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_saw_small_dust_from_wooden_pickaxe", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:saw_small_dust", count: 1}
    ],
    time: 17, ingredients: [{item: "minecraft:wooden_pickaxe"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_saw_small_dust_from_wooden_pressure_plates", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:saw_small_dust", count: 1}
    ],
    time: 17, ingredients: [{tag: "minecraft:wooden_pressure_plates"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_saw_small_dust_from_wooden_slabs", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:saw_small_dust", count: 4}
    ],
    time: 17, ingredients: [{tag: "minecraft:wooden_slabs"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_saw_small_dust_from_wooden_stairs", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:saw_small_dust", count: 6}
    ],
    time: 17, ingredients: [{tag: "minecraft:wooden_stairs"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_saw_small_dust_from_wooden_trapdoors", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:saw_small_dust", count: 1}
    ],
    time: 17, ingredients: [{tag: "minecraft:wooden_trapdoors"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_sponge_piece", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:sponge_piece", count: 5}
    ],
    time: 25, ingredients: [{tag: "c:sponges"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_steel_dust_from_block", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:steel_dust", count: 9}
    ],
    time: 234, ingredients: [{tag: "c:storage_blocks/steel"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_sulfur_dust", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:sulfur_dust", count: 2}
    ],
    time: 14, ingredients: [{tag: "c:ores/sulfur"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_sulfur_dust_2", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:sulfur_dust", count: 1}
    ],
    time: 12, ingredients: [{tag: "c:sulfurs"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_titanium_dust_from_block", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:titanium_dust", count: 9}
    ],
    time: 234, ingredients: [{tag: "c:storage_blocks/titanium"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_white_concrete_powder_from_concrete", {type: "oritech:pulverizer",
    results: [
        {id: "minecraft:white_concrete_powder", count: 1}
    ],
    time: 25, ingredients: [{item: "minecraft:white_concrete"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_yellow_concrete_powder_from_concrete", {type: "oritech:pulverizer",
    results: [
        {id: "minecraft:yellow_concrete_powder", count: 1}
    ],
    time: 25, ingredients: [{item: "minecraft:yellow_concrete"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_yellow_garnet_dust_from_block", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:yellow_garnet_dust", count: 9}
    ],
    time: 94, ingredients: [{tag: "c:storage_blocks/yellow_garnet"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_zinc_dust", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:zinc_dust", count: 1}
    ],
    time: 31, ingredients: [{tag: "c:ingots/zinc"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grinder_zinc_dust_from_block", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:zinc_dust", count: 9}
    ],
    time: 234, ingredients: [{tag: "c:storage_blocks/zinc"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.oil_other_tr_normalgrind_oilsand", {type: "oritech:pulverizer",
    results: [
        {id: "jsonreg:oil_sand_dust", count: 2}
    ],
    time: 20, ingredients: [{item: "jsonreg:oil_sand_ore"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.oil_other_tr_normalgrind_rocksalt", {type: "oritech:pulverizer",
    results: [
        {id: "jsonreg:rock_salt_dust", count: 4}
    ],
    time: 20, ingredients: [{item: "jsonreg:rock_salt_ore"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.oil_other_tr_normalgrind_salt", {type: "oritech:pulverizer",
    results: [
        {id: "jsonreg:salt_dust", count: 4}
    ],
    time: 20, ingredients: [{item: "jsonreg:salt_ore"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.t2_tr_grinder_rutile_dust_from_ore", {type: "oritech:pulverizer",
    results: [
        {id: "jsonreg:rutile_dust", count: 2}
    ],
    time: 100, ingredients: [{item: "jsonreg:voidstone_rutile_ore"}]
});
