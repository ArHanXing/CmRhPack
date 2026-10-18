// ============================================================
// 磨粉机配方互通（小磨粉：OR 粉碎机 ↔ TR 磨粉机）
// ============================================================
// 目的：同一个输入不该因为"用哪台机器"而拿不到某个产物。
//   典型：末影珍珠 —— OR 粉碎机出 oritech:enderic_compound（Oritech 的 machine_core_4、
//   喷气背包都要它），而 TR 磨粉机原本只出 ender_pearl_dust，只造 TR 机器的玩家会卡进度。
//
// 规则：
//   · 只做小磨粉对。工业研磨（TR 工业磨粉机 / OR 碎裂机）不参与互通。
//   · **机器输出槽限制**：TR 磨粉机只有 1 个输出槽，输出数 > 1 的配方执行必 NPE
//     （CrTNOTE §1.1 第 6 条），所以本文件只生成单输出配方。
//     原有那 5 条多输出的 oritech:pulverizer/raw/* 已由 **general_ore_process.zs 清退**，
//     本文件不再重复 removeByName（重复删会让 CrT 刷 "No recipe" 警告）。
//   · 只补"另一侧完全做不出来的产物"；仅产出**数量**不同不算缺口
//     （uni.zs 已定 OR 为下位、TR 为上位，数量差是分层设计）。
//   · **末影珍珠例外**：双向移植会让同一台机器同时出 enderic_compound 与 ender_pearl_dust，
//     EMI 里两条并排、玩家不知选哪条。改为各机各管一物：
//       OR 粉碎机 → enderic_compound ／ TR 磨粉机 → ender_pearl_dust。
//   · 等能耗移植：移到 TR 用 power 32（对齐 OR 粉碎机），移到 OR 用 P×T/32 折算 time。
//
// ⚠ 本文件基于 !recipedump.txt 生成，而 dump 是**易变快照**（每次 /reload 后可重新导出，
//   内容会随脚本改动而变）。重跑生成器前先确认 dump 是最新的，否则会按旧状态生成。
//
// 由 scripts/tools/grind_parity_gen.py 生成，改完原配方重跑即可。
// ============================================================

<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.general_t1_bauxite", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:bauxite_dust", count: 2}
    ],
    time: 20, ingredients: [{tag: "c:ores/bauxite"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.general_t1_cinnabar", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:cinnabar_dust", count: 2}
    ],
    time: 20, ingredients: [{tag: "c:ores/cinnabar"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.general_t1_coal", {type: "oritech:pulverizer",
    results: [
        {id: "minecraft:coal", count: 2}
    ],
    time: 20, ingredients: [{tag: "minecraft:coal_ores"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.general_t1_diamond", {type: "oritech:pulverizer",
    results: [
        {id: "minecraft:diamond", count: 1}
    ],
    time: 20, ingredients: [{tag: "minecraft:diamond_ores"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.general_t1_emerald", {type: "oritech:pulverizer",
    results: [
        {id: "minecraft:emerald", count: 1}
    ],
    time: 20, ingredients: [{tag: "minecraft:emerald_ores"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.general_t1_galena", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:galena_dust", count: 2}
    ],
    time: 20, ingredients: [{tag: "c:ores/galena"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.general_t1_lapis", {type: "oritech:pulverizer",
    results: [
        {id: "minecraft:lapis_lazuli", count: 8}
    ],
    time: 20, ingredients: [{tag: "minecraft:lapis_ores"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.general_t1_peridot", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:peridot_gem", count: 1}
    ],
    time: 20, ingredients: [{tag: "c:ores/peridot"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.general_t1_pyrite", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:pyrite_dust", count: 2}
    ],
    time: 20, ingredients: [{tag: "c:ores/pyrite"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.general_t1_raw_copper", {type: "oritech:pulverizer",
    results: [
        {id: "minecraft:raw_copper", count: 2}
    ],
    time: 20, ingredients: [{tag: "minecraft:copper_ores"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.general_t1_raw_gold", {type: "oritech:pulverizer",
    results: [
        {id: "minecraft:raw_gold", count: 2}
    ],
    time: 20, ingredients: [{tag: "minecraft:gold_ores"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.general_t1_raw_iridium", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:raw_iridium", count: 1}
    ],
    time: 20, ingredients: [{tag: "c:ores/iridium"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.general_t1_raw_iron", {type: "oritech:pulverizer",
    results: [
        {id: "minecraft:raw_iron", count: 2}
    ],
    time: 20, ingredients: [{tag: "minecraft:iron_ores"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.general_t1_raw_lead", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:raw_lead", count: 2}
    ],
    time: 20, ingredients: [{tag: "c:ores/lead"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.general_t1_raw_nickel", {type: "oritech:pulverizer",
    results: [
        {id: "oritech:raw_nickel", count: 2}
    ],
    time: 20, ingredients: [{tag: "c:ores/nickel"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.general_t1_raw_platinum", {type: "oritech:pulverizer",
    results: [
        {id: "oritech:raw_platinum", count: 2}
    ],
    time: 20, ingredients: [{tag: "c:ores/platinum"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.general_t1_raw_silver", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:raw_silver", count: 2}
    ],
    time: 20, ingredients: [{tag: "c:ores/silver"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.general_t1_raw_tin", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:raw_tin", count: 2}
    ],
    time: 20, ingredients: [{tag: "c:ores/tin"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.general_t1_raw_tungsten", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:raw_tungsten", count: 2}
    ],
    time: 20, ingredients: [{tag: "c:ores/tungsten"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.general_t1_raw_uranium", {type: "oritech:pulverizer",
    results: [
        {id: "oritech:raw_uranium", count: 2}
    ],
    time: 20, ingredients: [{tag: "c:ores/uranium"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.general_t1_redstone", {type: "oritech:pulverizer",
    results: [
        {id: "minecraft:redstone", count: 8}
    ],
    time: 20, ingredients: [{tag: "minecraft:redstone_ores"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.general_t1_rock_salt", {type: "oritech:pulverizer",
    results: [
        {id: "jsonreg:rock_salt_dust", count: 4}
    ],
    time: 20, ingredients: [{item: "jsonreg:rock_salt_ore"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.general_t1_ruby", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:ruby_gem", count: 1}
    ],
    time: 20, ingredients: [{tag: "c:ores/ruby"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.general_t1_salt", {type: "oritech:pulverizer",
    results: [
        {id: "jsonreg:salt_dust", count: 4}
    ],
    time: 20, ingredients: [{item: "jsonreg:salt_ore"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.general_t1_sapphire", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:sapphire_gem", count: 1}
    ],
    time: 20, ingredients: [{tag: "c:ores/sapphire"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.general_t1_sheldonite", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:platinum_dust", count: 2}
    ],
    time: 20, ingredients: [{tag: "c:ores/sheldonite"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.general_t1_sodalite", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:sodalite_dust", count: 2}
    ],
    time: 20, ingredients: [{tag: "c:ores/sodalite"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.general_t1_sphalerite", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:sphalerite_dust", count: 2}
    ],
    time: 20, ingredients: [{tag: "c:ores/sphalerite"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.general_t1_sulfur", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:sulfur_dust", count: 2}
    ],
    time: 20, ingredients: [{tag: "c:ores/sulfur"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.general_t15d_grind_gem_aluminum", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:aluminum_dust", count: 3}
    ],
    time: 200, ingredients: [{item: "jsonreg:aluminum_gem"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.general_t15d_grind_gem_cinnabar", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:cinnabar_dust", count: 3}
    ],
    time: 200, ingredients: [{item: "jsonreg:cinnabar_gem"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.general_t15d_grind_gem_copper", {type: "oritech:pulverizer",
    results: [
        {id: "oritech:copper_dust", count: 3}
    ],
    time: 200, ingredients: [{item: "oritech:copper_gem"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.general_t15d_grind_gem_galena", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:galena_dust", count: 3}
    ],
    time: 200, ingredients: [{item: "jsonreg:galena_gem"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.general_t15d_grind_gem_gold", {type: "oritech:pulverizer",
    results: [
        {id: "oritech:gold_dust", count: 3}
    ],
    time: 200, ingredients: [{item: "oritech:gold_gem"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.general_t15d_grind_gem_iridium", {type: "oritech:pulverizer",
    results: [
        {id: "jsonreg:iridium_dust", count: 3}
    ],
    time: 200, ingredients: [{item: "jsonreg:iridium_gem"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.general_t15d_grind_gem_iron", {type: "oritech:pulverizer",
    results: [
        {id: "oritech:iron_dust", count: 3}
    ],
    time: 200, ingredients: [{item: "oritech:iron_gem"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.general_t15d_grind_gem_lead", {type: "oritech:pulverizer",
    results: [
        {id: "jsonreg:lead_dust", count: 3}
    ],
    time: 200, ingredients: [{item: "jsonreg:lead_gem"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.general_t15d_grind_gem_nickel", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:nickel_dust", count: 3}
    ],
    time: 200, ingredients: [{item: "oritech:nickel_gem"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.general_t15d_grind_gem_platinum", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:platinum_dust", count: 3}
    ],
    time: 200, ingredients: [{item: "oritech:platinum_gem"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.general_t15d_grind_gem_pyrite", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:pyrite_dust", count: 3}
    ],
    time: 200, ingredients: [{item: "jsonreg:pyrite_gem"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.general_t15d_grind_gem_silver", {type: "oritech:pulverizer",
    results: [
        {id: "jsonreg:silver_dust", count: 3}
    ],
    time: 200, ingredients: [{item: "jsonreg:silver_gem"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.general_t15d_grind_gem_sodalite", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:sodalite_dust", count: 3}
    ],
    time: 200, ingredients: [{item: "jsonreg:sodalite_gem"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.general_t15d_grind_gem_sphalerite", {type: "oritech:pulverizer",
    results: [
        {id: "techreborn:sphalerite_dust", count: 3}
    ],
    time: 200, ingredients: [{item: "jsonreg:sphalerite_gem"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.general_t15d_grind_gem_tin", {type: "oritech:pulverizer",
    results: [
        {id: "jsonreg:tin_dust", count: 3}
    ],
    time: 200, ingredients: [{item: "jsonreg:tin_gem"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.general_t15d_grind_gem_tungsten", {type: "oritech:pulverizer",
    results: [
        {id: "jsonreg:tungsten_dust", count: 3}
    ],
    time: 200, ingredients: [{item: "jsonreg:tungsten_gem"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.general_t15d_grind_gem_uranium", {type: "oritech:pulverizer",
    results: [
        {id: "oritech:uranium_dust", count: 3}
    ],
    time: 200, ingredients: [{item: "jsonreg:uranium_gem"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.grind_parity_pulverizer_uranium", {type: "oritech:pulverizer",
    results: [
        {id: "oritech:uranium_dust", count: 2}
    ],
    time: 100, ingredients: [{tag: "c:raw_materials/uranium"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.uni_grinder_iridium_dust", {type: "oritech:pulverizer",
    results: [
        {id: "jsonreg:iridium_dust", count: 1}
    ],
    time: 20, ingredients: [{item: "techreborn:iridium_ingot"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.uni_grinder_lead_dust", {type: "oritech:pulverizer",
    results: [
        {id: "jsonreg:lead_dust", count: 1}
    ],
    time: 20, ingredients: [{item: "techreborn:lead_ingot"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.uni_grinder_silver_dust", {type: "oritech:pulverizer",
    results: [
        {id: "jsonreg:silver_dust", count: 1}
    ],
    time: 20, ingredients: [{item: "techreborn:silver_ingot"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.uni_grinder_tin_dust", {type: "oritech:pulverizer",
    results: [
        {id: "jsonreg:tin_dust", count: 1}
    ],
    time: 20, ingredients: [{item: "techreborn:tin_ingot"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("grind.parity.uni_grinder_tungsten_dust", {type: "oritech:pulverizer",
    results: [
        {id: "jsonreg:tungsten_dust", count: 1}
    ],
    time: 20, ingredients: [{item: "techreborn:tungsten_ingot"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("grind.parity.grind_parity_compat_techreborn_grinder_raw_nickel", {type: "techreborn:grinder",
    outputs: [
        {id: "techreborn:nickel_dust", count: 1}
    ],
    power: 32, time: 31, ingredients: [{tag: "c:raw_materials/nickel"}]
});
