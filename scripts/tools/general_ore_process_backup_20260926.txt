// ============================================================
// 基础矿物处理链路（general_ore_process.zs）
// ============================================================
// 本文件按 scripts/basic_ore_processing_plan.md 重写基础矿物处理，
// 取代旧的「OR 五级倍增链 + TR 基础/工业链」并行体系。
//
// 排除范围（不在此文件内处理）：
//   · 金红石 → 钛线（t2.zs）
//   · 普通/富集/超能硅岩线（process_naquadah.zs）
//   · 油砂 → 原油线（oil_chemistry.zs）
//   · PBI / 聚乙烯 / 环氧树脂等下游材料线
//
// 阶段结构：
//   T1   干法粗处理   ：矿石 → 粗矿 / 初级矿料     TR 磨粉机（1 输出，零副产）
//   T1.5 湿法初级浓缩 ：粗矿 → 碎块(clump)/石(gem)  TR 化反 / OR 精炼厂 / OR 流体离心
//   T2   工业分离     ：浓缩物 → 高纯 dust + 0~2 副产  TR 工业磨粉机 / 大型化反
//   T2.3 魔法催化     ：灵魂注入催化剂强化既有步骤（不新增并行倍增链）
//
// 机器槽位硬约束（写配方前必须核对，超额会 NPE）：
//   TR 磨粉机    1 进 1 出    ← 只要 1 个输出槽，多输出配方执行必崩
//   TR 提取机    1 进 1 出
//   OR 基础离心  1流体1物品 → 1流体1物品
//   TR 化反      2 进 2 出
//   OR 精炼厂    1流体1物品 → 3 流体（放弃后两个输出位时第一个增产）
//   TR 蒸馏塔    4 进 6 出
//   TR 工业磨粉  1流体1物品 → 4 物品
//   TR 大型化反  6 进 4 出
//
// 命名约定：
//   general.t1.*  / general.t15.*  / general.t2.*  / general.t23.*
//
// 当前进度：T1 已实现；T1.5 / T2 / T2.3 见文件末尾的规划占位。
// ============================================================

// ============================================================
// T1 清退：旧的矿石入口配方
// ============================================================
// 被清退的是「矿石 → 直接出粉/出粗矿 + 副产」的整条旧入口，共 142 条。
// 它们的问题：
//   · 绕过 T1.5 的浸出/析出/重结晶工序，矿石一步就变高纯粉或粗矿；
//   · 副产结构由 base mod 决定，与本包「每种矿物 0~2 类有依据副产」冲突；
//   · 两套体系对同一矿石给出不同产物，玩家按机器不同拿到不同东西。
// 下列配方全部由 T1 + T1.5 的新链取代。
// **油砂 / 金红石 / 硅岩系属特殊线，不在清退范围。**

// —— oritech:centrifuge ——
<recipetype:oritech:centrifuge>.removeByName("oritech:centrifuge/clump/copper");
<recipetype:oritech:centrifuge>.removeByName("oritech:centrifuge/clump/gold");
<recipetype:oritech:centrifuge>.removeByName("oritech:centrifuge/clump/iron");
<recipetype:oritech:centrifuge>.removeByName("oritech:centrifuge/clump/nickel");
<recipetype:oritech:centrifuge>.removeByName("oritech:centrifuge/clump/platinum");
// —— oritech:centrifuge_fluid ——
<recipetype:oritech:centrifuge_fluid>.removeByName("oritech:centrifuge/fluid/clump/copper");
<recipetype:oritech:centrifuge_fluid>.removeByName("oritech:centrifuge/fluid/clump/gold");
<recipetype:oritech:centrifuge_fluid>.removeByName("oritech:centrifuge/fluid/clump/iron");
<recipetype:oritech:centrifuge_fluid>.removeByName("oritech:centrifuge/fluid/clump/nickel");
<recipetype:oritech:centrifuge_fluid>.removeByName("oritech:centrifuge/fluid/clump/platinum");
<recipetype:oritech:centrifuge_fluid>.removeByName("oritech:centrifuge/fluid/clumpacid/copper");
<recipetype:oritech:centrifuge_fluid>.removeByName("oritech:centrifuge/fluid/clumpacid/gold");
<recipetype:oritech:centrifuge_fluid>.removeByName("oritech:centrifuge/fluid/clumpacid/iron");
<recipetype:oritech:centrifuge_fluid>.removeByName("oritech:centrifuge/fluid/clumpacid/nickel");
<recipetype:oritech:centrifuge_fluid>.removeByName("oritech:centrifuge/fluid/clumpacid/platinum");
// —— oritech:grinder ——
<recipetype:oritech:grinder>.removeByName("oritech:grinder/coalore");
<recipetype:oritech:grinder>.removeByName("oritech:grinder/compat/techreborn/bauxite_ore");
<recipetype:oritech:grinder>.removeByName("oritech:grinder/compat/techreborn/cinnabar_ore");
<recipetype:oritech:grinder>.removeByName("oritech:grinder/compat/techreborn/galena_ore");
<recipetype:oritech:grinder>.removeByName("oritech:grinder/compat/techreborn/iridium_ore");
<recipetype:oritech:grinder>.removeByName("oritech:grinder/compat/techreborn/lead_ore");
<recipetype:oritech:grinder>.removeByName("oritech:grinder/compat/techreborn/peridot_ore");
<recipetype:oritech:grinder>.removeByName("oritech:grinder/compat/techreborn/pyrite_ore");
<recipetype:oritech:grinder>.removeByName("oritech:grinder/compat/techreborn/ruby_ore");
<recipetype:oritech:grinder>.removeByName("oritech:grinder/compat/techreborn/sapphire_ore");
<recipetype:oritech:grinder>.removeByName("oritech:grinder/compat/techreborn/sheldonite_ore");
<recipetype:oritech:grinder>.removeByName("oritech:grinder/compat/techreborn/silver_ore");
<recipetype:oritech:grinder>.removeByName("oritech:grinder/compat/techreborn/sodalite_ore");
<recipetype:oritech:grinder>.removeByName("oritech:grinder/compat/techreborn/sphalerite_ore");
<recipetype:oritech:grinder>.removeByName("oritech:grinder/compat/techreborn/tin_ore");
<recipetype:oritech:grinder>.removeByName("oritech:grinder/compat/techreborn/tungsten_ore");
<recipetype:oritech:grinder>.removeByName("oritech:grinder/diamondore");
<recipetype:oritech:grinder>.removeByName("oritech:grinder/lapisore");
<recipetype:oritech:grinder>.removeByName("oritech:grinder/ore/copper");
<recipetype:oritech:grinder>.removeByName("oritech:grinder/ore/gold");
<recipetype:oritech:grinder>.removeByName("oritech:grinder/ore/iron");
<recipetype:oritech:grinder>.removeByName("oritech:grinder/ore/nickel");
<recipetype:oritech:grinder>.removeByName("oritech:grinder/ore/platinum");
<recipetype:oritech:grinder>.removeByName("oritech:grinder/raw/copper");
<recipetype:oritech:grinder>.removeByName("oritech:grinder/raw/gold");
<recipetype:oritech:grinder>.removeByName("oritech:grinder/raw/iron");
<recipetype:oritech:grinder>.removeByName("oritech:grinder/raw/nickel");
<recipetype:oritech:grinder>.removeByName("oritech:grinder/raw/platinum");
<recipetype:oritech:grinder>.removeByName("oritech:grinder/redstoneore");
<recipetype:oritech:grinder>.removeByName("oritech:grinder/uranium");
<recipetype:oritech:grinder>.removeByName("oritech:grinder/uraniumore");
// —— oritech:pulverizer ——
<recipetype:oritech:pulverizer>.removeByName("oritech:pulverizer/coalore");
<recipetype:oritech:pulverizer>.removeByName("oritech:pulverizer/compat/techreborn/bauxite");
<recipetype:oritech:pulverizer>.removeByName("oritech:pulverizer/compat/techreborn/cinnabar");
<recipetype:oritech:pulverizer>.removeByName("oritech:pulverizer/compat/techreborn/galena");
<recipetype:oritech:pulverizer>.removeByName("oritech:pulverizer/compat/techreborn/lead_ore");
<recipetype:oritech:pulverizer>.removeByName("oritech:pulverizer/compat/techreborn/peridot_ore");
<recipetype:oritech:pulverizer>.removeByName("oritech:pulverizer/compat/techreborn/pyrite_ore");
<recipetype:oritech:pulverizer>.removeByName("oritech:pulverizer/compat/techreborn/ruby_ore");
<recipetype:oritech:pulverizer>.removeByName("oritech:pulverizer/compat/techreborn/sapphire_ore");
<recipetype:oritech:pulverizer>.removeByName("oritech:pulverizer/compat/techreborn/silver_ore");
<recipetype:oritech:pulverizer>.removeByName("oritech:pulverizer/compat/techreborn/sodalite");
<recipetype:oritech:pulverizer>.removeByName("oritech:pulverizer/compat/techreborn/sphalerite");
<recipetype:oritech:pulverizer>.removeByName("oritech:pulverizer/compat/techreborn/tin_ore");
<recipetype:oritech:pulverizer>.removeByName("oritech:pulverizer/diamondore");
<recipetype:oritech:pulverizer>.removeByName("oritech:pulverizer/lapisore");
<recipetype:oritech:pulverizer>.removeByName("oritech:pulverizer/ore/copper");
<recipetype:oritech:pulverizer>.removeByName("oritech:pulverizer/ore/gold");
<recipetype:oritech:pulverizer>.removeByName("oritech:pulverizer/ore/iron");
<recipetype:oritech:pulverizer>.removeByName("oritech:pulverizer/ore/nickel");
<recipetype:oritech:pulverizer>.removeByName("oritech:pulverizer/ore/platinum");
<recipetype:oritech:pulverizer>.removeByName("oritech:pulverizer/raw/copper");
<recipetype:oritech:pulverizer>.removeByName("oritech:pulverizer/raw/gold");
<recipetype:oritech:pulverizer>.removeByName("oritech:pulverizer/raw/iron");
<recipetype:oritech:pulverizer>.removeByName("oritech:pulverizer/raw/nickel");
<recipetype:oritech:pulverizer>.removeByName("oritech:pulverizer/raw/platinum");
<recipetype:oritech:pulverizer>.removeByName("oritech:pulverizer/redstoneore");
<recipetype:oritech:pulverizer>.removeByName("oritech:pulverizer/uranium");
<recipetype:oritech:pulverizer>.removeByName("oritech:pulverizer/uraniumore");
// —— oritech:refinery ——
<recipetype:oritech:refinery>.removeByName("oritech:refinery/rawsheol/copper");
<recipetype:oritech:refinery>.removeByName("oritech:refinery/rawsheol/gold");
<recipetype:oritech:refinery>.removeByName("oritech:refinery/rawsheol/iron");
<recipetype:oritech:refinery>.removeByName("oritech:refinery/rawsheol/nickel");
<recipetype:oritech:refinery>.removeByName("oritech:refinery/rawsheol/platinum");
// —— techreborn:grinder ——
<recipetype:techreborn:grinder>.removeByName("oritech:compat/techreborn/grinder/nickel_ore");
<recipetype:techreborn:grinder>.removeByName("oritech:compat/techreborn/grinder/raw_nickel");
<recipetype:techreborn:grinder>.removeByName("techreborn:grinder/bauxite_dust");
<recipetype:techreborn:grinder>.removeByName("techreborn:grinder/cinnabar_dust");
<recipetype:techreborn:grinder>.removeByName("techreborn:grinder/coal");
<recipetype:techreborn:grinder>.removeByName("techreborn:grinder/diamond");
<recipetype:techreborn:grinder>.removeByName("techreborn:grinder/emerald");
<recipetype:techreborn:grinder>.removeByName("techreborn:grinder/galena_dust");
<recipetype:techreborn:grinder>.removeByName("techreborn:grinder/lapis_lazuli");
<recipetype:techreborn:grinder>.removeByName("techreborn:grinder/peridot_dust_from_ore");
<recipetype:techreborn:grinder>.removeByName("techreborn:grinder/pyrite_dust");
<recipetype:techreborn:grinder>.removeByName("techreborn:grinder/raw_copper");
<recipetype:techreborn:grinder>.removeByName("techreborn:grinder/raw_gold");
<recipetype:techreborn:grinder>.removeByName("techreborn:grinder/raw_iron");
<recipetype:techreborn:grinder>.removeByName("techreborn:grinder/raw_lead");
<recipetype:techreborn:grinder>.removeByName("techreborn:grinder/raw_silver");
<recipetype:techreborn:grinder>.removeByName("techreborn:grinder/raw_tin");
<recipetype:techreborn:grinder>.removeByName("techreborn:grinder/redstone");
<recipetype:techreborn:grinder>.removeByName("techreborn:grinder/ruby_dust_from_ore");
<recipetype:techreborn:grinder>.removeByName("techreborn:grinder/sapphire_dust_from_ore");
<recipetype:techreborn:grinder>.removeByName("techreborn:grinder/sodalite_dust");
<recipetype:techreborn:grinder>.removeByName("techreborn:grinder/sphalerite_dust");
<recipetype:techreborn:grinder>.removeByName("techreborn:grinder/sulfur_dust");
// —— techreborn:industrial_grinder ——
<recipetype:techreborn:industrial_grinder>.removeByName("oritech:compat/techreborn/industrial_grinder/nickel");
<recipetype:techreborn:industrial_grinder>.removeByName("oritech:compat/techreborn/industrial_grinder/nickel_ore");
<recipetype:techreborn:industrial_grinder>.removeByName("oritech:compat/techreborn/industrial_grinder/platinum");
<recipetype:techreborn:industrial_grinder>.removeByName("oritech:compat/techreborn/industrial_grinder/platinum_ore");
<recipetype:techreborn:industrial_grinder>.removeByName("techreborn:industrial_grinder/bauxite_dust_from_bauxite_ore_with_water");
<recipetype:techreborn:industrial_grinder>.removeByName("techreborn:industrial_grinder/cinnabar_dust_from_cinnabar_ore_with_water");
<recipetype:techreborn:industrial_grinder>.removeByName("techreborn:industrial_grinder/coal_from_coal_ore_with_mercury");
<recipetype:techreborn:industrial_grinder>.removeByName("techreborn:industrial_grinder/coal_from_coal_ore_with_water");
<recipetype:techreborn:industrial_grinder>.removeByName("techreborn:industrial_grinder/diamond_from_diamond_ore_with_mercury");
<recipetype:techreborn:industrial_grinder>.removeByName("techreborn:industrial_grinder/diamond_from_diamond_ore_with_water");
<recipetype:techreborn:industrial_grinder>.removeByName("techreborn:industrial_grinder/emerald_from_emerald_ore_with_mercury");
<recipetype:techreborn:industrial_grinder>.removeByName("techreborn:industrial_grinder/emerald_from_emerald_ore_with_water");
<recipetype:techreborn:industrial_grinder>.removeByName("techreborn:industrial_grinder/galena_dust_from_galena_ore_with_mercury");
<recipetype:techreborn:industrial_grinder>.removeByName("techreborn:industrial_grinder/galena_dust_from_galena_ore_with_water");
<recipetype:techreborn:industrial_grinder>.removeByName("techreborn:industrial_grinder/lapis_lazuli_from_lapis_ore_with_water");
<recipetype:techreborn:industrial_grinder>.removeByName("techreborn:industrial_grinder/peridot_gem_from_peridot_ore_with_water");
<recipetype:techreborn:industrial_grinder>.removeByName("techreborn:industrial_grinder/platinum_dust_from_sheldonite_ore_with_mercury");
<recipetype:techreborn:industrial_grinder>.removeByName("techreborn:industrial_grinder/platinum_dust_from_sheldonite_ore_with_water");
<recipetype:techreborn:industrial_grinder>.removeByName("techreborn:industrial_grinder/pyrite_dust_from_pyrite_ore_with_water");
<recipetype:techreborn:industrial_grinder>.removeByName("techreborn:industrial_grinder/raw_copper_from_copper_ore_with_mercury");
<recipetype:techreborn:industrial_grinder>.removeByName("techreborn:industrial_grinder/raw_copper_from_copper_ore_with_sodium_persulfate");
<recipetype:techreborn:industrial_grinder>.removeByName("techreborn:industrial_grinder/raw_copper_from_copper_ore_with_water");
<recipetype:techreborn:industrial_grinder>.removeByName("techreborn:industrial_grinder/raw_gold_from_gold_ore_with_mercury");
<recipetype:techreborn:industrial_grinder>.removeByName("techreborn:industrial_grinder/raw_gold_from_gold_ore_with_sodium_persulfate");
<recipetype:techreborn:industrial_grinder>.removeByName("techreborn:industrial_grinder/raw_gold_from_gold_ore_with_water");
<recipetype:techreborn:industrial_grinder>.removeByName("techreborn:industrial_grinder/raw_iridium_from_iridium_ore_with_mercury");
<recipetype:techreborn:industrial_grinder>.removeByName("techreborn:industrial_grinder/raw_iridium_from_iridium_ore_with_sodium_persulfate");
<recipetype:techreborn:industrial_grinder>.removeByName("techreborn:industrial_grinder/raw_iridium_from_iridium_ore_with_water");
<recipetype:techreborn:industrial_grinder>.removeByName("techreborn:industrial_grinder/raw_iron_from_iron_ore_with_water");
<recipetype:techreborn:industrial_grinder>.removeByName("techreborn:industrial_grinder/raw_lead_from_lead_ore_with_water");
<recipetype:techreborn:industrial_grinder>.removeByName("techreborn:industrial_grinder/raw_silver_from_silver_ore_with_water");
<recipetype:techreborn:industrial_grinder>.removeByName("techreborn:industrial_grinder/raw_tin_from_tin_ore_with_sodium_persulfate");
<recipetype:techreborn:industrial_grinder>.removeByName("techreborn:industrial_grinder/raw_tin_from_tin_ore_with_water");
<recipetype:techreborn:industrial_grinder>.removeByName("techreborn:industrial_grinder/raw_tungsten_from_tungsten_ore_with_water");
<recipetype:techreborn:industrial_grinder>.removeByName("techreborn:industrial_grinder/redstone_from_redstone_ore_with_water");
<recipetype:techreborn:industrial_grinder>.removeByName("techreborn:industrial_grinder/ruby_gem_from_ruby_ore_with_water");
<recipetype:techreborn:industrial_grinder>.removeByName("techreborn:industrial_grinder/sapphire_gem_from_sapphire_ore_with_water");
<recipetype:techreborn:industrial_grinder>.removeByName("techreborn:industrial_grinder/sodalite_dust_from_sodalite_ore_with_water");
<recipetype:techreborn:industrial_grinder>.removeByName("techreborn:industrial_grinder/sphalerite_dust_from_sphalerite_ore_with_sodium_persulfate");
<recipetype:techreborn:industrial_grinder>.removeByName("techreborn:industrial_grinder/sphalerite_dust_from_sphalerite_ore_with_water");

// ============================================================
// T1：干法粗处理（TR 磨粉机，全部严格 1 输出、零副产）
// ============================================================
// 规则：
//   · 只用 TR 磨粉机做入口。OR 粉碎机的矿石处理属于 T1.5，故上面已清退。
//   · 单一输出，不产出小撮粉、不产出副产金属 —— 副产是 T2 工业磨粉机的职责。
//   · 不使用酸 / 过硫酸钠 / 地狱火 / 魔法催化剂。
//   · 能量统一 power 8 / time 80，与原盐系配方一致。
//   · 金属矿给 raw（粗矿），宝石矿给宝石本体，盐系给盐粉。
//     少数矿物（铝土、朱砂、方铅、黄铁、闪锌、方钠）在原 mod 里没有 raw 形态，
//     其 *_dust 就是该矿的初级矿料，T1 沿用；高纯 dust 由 T2 建立区分。

// —— 金属矿 → 粗矿 ——
<recipetype:techreborn:grinder>.addJsonRecipe("general.t1.raw_copper", {type: "techreborn:grinder",
    time: 80, power: 8,
    outputs: [{id: "minecraft:raw_copper", count: 2}],
    ingredients: [{tag: "minecraft:copper_ores"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t1.raw_gold", {type: "techreborn:grinder",
    time: 80, power: 8,
    outputs: [{id: "minecraft:raw_gold", count: 2}],
    ingredients: [{tag: "minecraft:gold_ores"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t1.raw_iron", {type: "techreborn:grinder",
    time: 80, power: 8,
    outputs: [{id: "minecraft:raw_iron", count: 2}],
    ingredients: [{tag: "minecraft:iron_ores"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t1.raw_nickel", {type: "techreborn:grinder",
    time: 80, power: 8,
    outputs: [{id: "oritech:raw_nickel", count: 2}],
    ingredients: [{tag: "c:ores/nickel"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t1.raw_platinum", {type: "techreborn:grinder",
    time: 80, power: 8,
    outputs: [{id: "oritech:raw_platinum", count: 2}],
    ingredients: [{tag: "c:ores/platinum"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t1.raw_lead", {type: "techreborn:grinder",
    time: 80, power: 8,
    outputs: [{id: "techreborn:raw_lead", count: 2}],
    ingredients: [{tag: "c:ores/lead"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t1.raw_silver", {type: "techreborn:grinder",
    time: 80, power: 8,
    outputs: [{id: "techreborn:raw_silver", count: 2}],
    ingredients: [{tag: "c:ores/silver"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t1.raw_tin", {type: "techreborn:grinder",
    time: 80, power: 8,
    outputs: [{id: "techreborn:raw_tin", count: 2}],
    ingredients: [{tag: "c:ores/tin"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t1.raw_tungsten", {type: "techreborn:grinder",
    time: 80, power: 8,
    outputs: [{id: "techreborn:raw_tungsten", count: 2}],
    ingredients: [{tag: "c:ores/tungsten"}]
});
// 铱是铂族痕量矿，粗矿只给 1
<recipetype:techreborn:grinder>.addJsonRecipe("general.t1.raw_iridium", {type: "techreborn:grinder",
    time: 80, power: 8,
    outputs: [{id: "techreborn:raw_iridium", count: 1}],
    ingredients: [{tag: "c:ores/iridium"}]
});
// 铀：T1 只给粗铀，不产钚（钚需要后续辐照/反应逻辑）
<recipetype:techreborn:grinder>.addJsonRecipe("general.t1.raw_uranium", {type: "techreborn:grinder",
    time: 80, power: 8,
    outputs: [{id: "oritech:raw_uranium", count: 2}],
    ingredients: [{tag: "c:ores/uranium"}]
});

// —— 无 raw 形态的矿物 → 初级矿料 ——
<recipetype:techreborn:grinder>.addJsonRecipe("general.t1.bauxite", {type: "techreborn:grinder",
    time: 80, power: 8,
    outputs: [{id: "techreborn:bauxite_dust", count: 2}],
    ingredients: [{tag: "c:ores/bauxite"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t1.cinnabar", {type: "techreborn:grinder",
    time: 80, power: 8,
    outputs: [{id: "techreborn:cinnabar_dust", count: 2}],
    ingredients: [{tag: "c:ores/cinnabar"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t1.galena", {type: "techreborn:grinder",
    time: 80, power: 8,
    outputs: [{id: "techreborn:galena_dust", count: 2}],
    ingredients: [{tag: "c:ores/galena"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t1.pyrite", {type: "techreborn:grinder",
    time: 80, power: 8,
    outputs: [{id: "techreborn:pyrite_dust", count: 2}],
    ingredients: [{tag: "c:ores/pyrite"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t1.sphalerite", {type: "techreborn:grinder",
    time: 80, power: 8,
    outputs: [{id: "techreborn:sphalerite_dust", count: 2}],
    ingredients: [{tag: "c:ores/sphalerite"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t1.sodalite", {type: "techreborn:grinder",
    time: 80, power: 8,
    outputs: [{id: "techreborn:sodalite_dust", count: 2}],
    ingredients: [{tag: "c:ores/sodalite"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t1.sulfur", {type: "techreborn:grinder",
    time: 80, power: 8,
    outputs: [{id: "techreborn:sulfur_dust", count: 2}],
    ingredients: [{tag: "c:ores/sulfur"}]
});
// 辉砷镍是铂族矿，T1 直接给铂粉（原 mod 语义）
<recipetype:techreborn:grinder>.addJsonRecipe("general.t1.sheldonite", {type: "techreborn:grinder",
    time: 80, power: 8,
    outputs: [{id: "techreborn:platinum_dust", count: 2}],
    ingredients: [{tag: "c:ores/sheldonite"}]
});

// —— 宝石矿 → 宝石本体 ——
<recipetype:techreborn:grinder>.addJsonRecipe("general.t1.ruby", {type: "techreborn:grinder",
    time: 80, power: 8,
    outputs: [{id: "techreborn:ruby_gem", count: 1}],
    ingredients: [{tag: "c:ores/ruby"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t1.sapphire", {type: "techreborn:grinder",
    time: 80, power: 8,
    outputs: [{id: "techreborn:sapphire_gem", count: 1}],
    ingredients: [{tag: "c:ores/sapphire"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t1.peridot", {type: "techreborn:grinder",
    time: 80, power: 8,
    outputs: [{id: "techreborn:peridot_gem", count: 1}],
    ingredients: [{tag: "c:ores/peridot"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t1.diamond", {type: "techreborn:grinder",
    time: 80, power: 8,
    outputs: [{id: "minecraft:diamond", count: 1}],
    ingredients: [{tag: "minecraft:diamond_ores"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t1.emerald", {type: "techreborn:grinder",
    time: 80, power: 8,
    outputs: [{id: "minecraft:emerald", count: 1}],
    ingredients: [{tag: "minecraft:emerald_ores"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t1.lapis", {type: "techreborn:grinder",
    time: 80, power: 8,
    outputs: [{id: "minecraft:lapis_lazuli", count: 8}],
    ingredients: [{tag: "minecraft:lapis_ores"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t1.quartz", {type: "techreborn:grinder",
    time: 80, power: 8,
    outputs: [{id: "minecraft:quartz", count: 2}],
    ingredients: [{item: "minecraft:nether_quartz_ore"}]
});

// —— 原版能源/杂矿 ——
<recipetype:techreborn:grinder>.addJsonRecipe("general.t1.coal", {type: "techreborn:grinder",
    time: 80, power: 8,
    outputs: [{id: "minecraft:coal", count: 2}],
    ingredients: [{tag: "minecraft:coal_ores"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t1.redstone", {type: "techreborn:grinder",
    time: 80, power: 8,
    outputs: [{id: "minecraft:redstone", count: 8}],
    ingredients: [{tag: "minecraft:redstone_ores"}]
});

// —— 盐系（jsonreg 自定义矿，纳入基础体系）——
// 化学定位：盐矿 = NaCl 来源，岩盐 = KCl 来源，两者**不可互换**。
// 后续电解仍走 oil_chemistry.zs 的 electrolyze_salt / electrolyze_rocksalt。
<recipetype:techreborn:grinder>.addJsonRecipe("general.t1.salt", {type: "techreborn:grinder",
    time: 80, power: 8,
    outputs: [{id: "jsonreg:salt_dust", count: 4}],
    ingredients: [{item: "jsonreg:salt_ore"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t1.rock_salt", {type: "techreborn:grinder",
    time: 80, power: 8,
    outputs: [{id: "jsonreg:rock_salt_dust", count: 4}],
    ingredients: [{item: "jsonreg:rock_salt_ore"}]
});

// ============================================================
// T1b：粗矿制粉（早期干法路线）
// ============================================================
// 「不搞化学也能出粉」的基础路线：**1 粗矿 → 1 粉**。
//   产出核账：1 矿石 →(T1) 粗矿 ×2 →(T1b) 粉 ×2   ⇒ **2 倍**
//   阶梯关系：T1b 2×  <  T1.5 湿法 3×  <  T2 浓缩 5×
//
// ⚠ 不要写成 `1 粗矿 → 2 粉`：那会让 1 矿石 = 4 粉，直接超过 T1.5 的 3 倍，
//   使整套湿法化学失去意义。
//
// 两台机器都是 1 进 1 出，安全：TR 磨粉机只有 1 个输出槽；OR 粉碎机在本包内也只用单输出
// （其原版 5 条 2 输出的 raw/* 配方已清退，且若移植到 TR 磨粉机会 NPE）。
//
// ⚠ 配方名必须带机器后缀（.tr. / .or.）：CrT 的配方名是**全局唯一**的，
//   两台机器用同名会导致 SynchronizeRecipes 包 duplicate key 报错、客户端连不上服务器。

<recipetype:techreborn:grinder>.addJsonRecipe("general.t1b.grind_raw.tr.copper", {type: "techreborn:grinder",
    time: 100, power: 16,
    outputs: [{id: "oritech:copper_dust", count: 1}],
    ingredients: [{item: "minecraft:raw_copper"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("general.t1b.grind_raw.or.copper", {type: "oritech:pulverizer",
    time: 100,
    results: [{id: "oritech:copper_dust", count: 1}],
    ingredients: [{item: "minecraft:raw_copper"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t1b.grind_raw.tr.gold", {type: "techreborn:grinder",
    time: 100, power: 16,
    outputs: [{id: "oritech:gold_dust", count: 1}],
    ingredients: [{item: "minecraft:raw_gold"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("general.t1b.grind_raw.or.gold", {type: "oritech:pulverizer",
    time: 100,
    results: [{id: "oritech:gold_dust", count: 1}],
    ingredients: [{item: "minecraft:raw_gold"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t1b.grind_raw.tr.iron", {type: "techreborn:grinder",
    time: 100, power: 16,
    outputs: [{id: "oritech:iron_dust", count: 1}],
    ingredients: [{item: "minecraft:raw_iron"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("general.t1b.grind_raw.or.iron", {type: "oritech:pulverizer",
    time: 100,
    results: [{id: "oritech:iron_dust", count: 1}],
    ingredients: [{item: "minecraft:raw_iron"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t1b.grind_raw.tr.nickel", {type: "techreborn:grinder",
    time: 100, power: 16,
    outputs: [{id: "techreborn:nickel_dust", count: 1}],
    ingredients: [{item: "oritech:raw_nickel"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("general.t1b.grind_raw.or.nickel", {type: "oritech:pulverizer",
    time: 100,
    results: [{id: "techreborn:nickel_dust", count: 1}],
    ingredients: [{item: "oritech:raw_nickel"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t1b.grind_raw.tr.platinum", {type: "techreborn:grinder",
    time: 100, power: 16,
    outputs: [{id: "techreborn:platinum_dust", count: 1}],
    ingredients: [{item: "oritech:raw_platinum"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("general.t1b.grind_raw.or.platinum", {type: "oritech:pulverizer",
    time: 100,
    results: [{id: "techreborn:platinum_dust", count: 1}],
    ingredients: [{item: "oritech:raw_platinum"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t1b.grind_raw.tr.lead", {type: "techreborn:grinder",
    time: 100, power: 16,
    outputs: [{id: "jsonreg:lead_dust", count: 1}],
    ingredients: [{item: "techreborn:raw_lead"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("general.t1b.grind_raw.or.lead", {type: "oritech:pulverizer",
    time: 100,
    results: [{id: "jsonreg:lead_dust", count: 1}],
    ingredients: [{item: "techreborn:raw_lead"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t1b.grind_raw.tr.silver", {type: "techreborn:grinder",
    time: 100, power: 16,
    outputs: [{id: "jsonreg:silver_dust", count: 1}],
    ingredients: [{item: "techreborn:raw_silver"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("general.t1b.grind_raw.or.silver", {type: "oritech:pulverizer",
    time: 100,
    results: [{id: "jsonreg:silver_dust", count: 1}],
    ingredients: [{item: "techreborn:raw_silver"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t1b.grind_raw.tr.tin", {type: "techreborn:grinder",
    time: 100, power: 16,
    outputs: [{id: "jsonreg:tin_dust", count: 1}],
    ingredients: [{item: "techreborn:raw_tin"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("general.t1b.grind_raw.or.tin", {type: "oritech:pulverizer",
    time: 100,
    results: [{id: "jsonreg:tin_dust", count: 1}],
    ingredients: [{item: "techreborn:raw_tin"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t1b.grind_raw.tr.tungsten", {type: "techreborn:grinder",
    time: 100, power: 16,
    outputs: [{id: "jsonreg:tungsten_dust", count: 1}],
    ingredients: [{item: "techreborn:raw_tungsten"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("general.t1b.grind_raw.or.tungsten", {type: "oritech:pulverizer",
    time: 100,
    results: [{id: "jsonreg:tungsten_dust", count: 1}],
    ingredients: [{item: "techreborn:raw_tungsten"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t1b.grind_raw.tr.iridium", {type: "techreborn:grinder",
    time: 100, power: 16,
    outputs: [{id: "jsonreg:iridium_dust", count: 1}],
    ingredients: [{item: "techreborn:raw_iridium"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("general.t1b.grind_raw.or.iridium", {type: "oritech:pulverizer",
    time: 100,
    results: [{id: "jsonreg:iridium_dust", count: 1}],
    ingredients: [{item: "techreborn:raw_iridium"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t1b.grind_raw.tr.uranium", {type: "techreborn:grinder",
    time: 100, power: 16,
    outputs: [{id: "oritech:uranium_dust", count: 1}],
    ingredients: [{item: "oritech:raw_uranium"}]
});
<recipetype:oritech:pulverizer>.addJsonRecipe("general.t1b.grind_raw.or.uranium", {type: "oritech:pulverizer",
    time: 100,
    results: [{id: "oritech:uranium_dust", count: 1}],
    ingredients: [{item: "oritech:raw_uranium"}]
});

// ============================================================
// T1.5：湿法处理与初级浓缩
// ============================================================
// 每个矿石走五步，浓缩物必须有明确来源：
//   a 浸出      OR 精炼厂    粗矿 ×2 + 硫酸 → X盐溶液[主] + 矿物浆液[副]
//   b 选择性析出 OR 流体离心  X盐溶液(1桶) + 盐粉 ×1 → X碎块 ×1
//   c 重结晶    OR 流体离心  X碎块 ×1 + 硫酸 → X石(gem) ×1 + 矿物浆液
//   d 石磨粉    TR 磨粉机    X石 ×1 → X高纯粉 ×3
//
// ⚠ **OR 离心机只支持大小为 1 的输入**（物品 count 与流体桶数都必须是 1，见 CrTNOTE）。
//   所以 b/c 的进料恒为 1 桶溶液 / 1 个碎块，倍率只能靠产出侧：d 步 1 石 → 3 粉是唯一倍增点。
//   （精炼厂不受此限：naquadah 线在用 count 10/4/2，故 a 步的 粗矿 ×2 安全。）
//
// 产出核账（以 1 个矿石计）：
//   1 矿 --T1--> 粗矿 ×2 --a--> 1 桶盐溶液 --b--> 碎块 ×1 --c--> 石 ×1 --d--> **粉 ×3**
//   ⇒ T1.5 终点为 **3 倍**矿物产出。
//
// 槽位：精炼厂 1流体+1物品→2流体；流体离心 1流体+1物品→1流体+1物品；
//       TR 磨粉机 1 进 1 出（**只有 1 个输出槽，绝不能多输出**）。
// 精炼厂只用 2 个流体输出位：放弃第 3 位会让第 1 位增产，与「浸出率」设定方向一致，
// 且不虚构并不存在的回收液。
//
// 浓缩物（jsonreg:*_concentrate）留待 T2 —— 它是 dust 之上的进一步提纯产物，
// 不在 T1.5 出现。

// ---------- 铜 ----------
<recipetype:oritech:refinery>.addJsonRecipe("general.t15a.leach.copper", {type: "oritech:refinery",
    results: [],
    fluidOutputs: [
        {fluid: "jsonreg:copper_solution", amount: 81000},
        {fluid: "oritech:still_mineral_slurry", amount: 20250}
    ],
    time: 160,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 81000},
    ingredients: [{item: "minecraft:raw_copper", count: 2}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15b.precipitate.copper", {type: "oritech:centrifuge_fluid",
    results: [{id: "oritech:copper_clump", count: 1}],
    time: 150,
    fluidInput: {fluid: "jsonreg:copper_solution", amount: 81000},
    ingredients: [{item: "jsonreg:salt_dust", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15c.recrystallize.copper", {type: "oritech:centrifuge_fluid",
    results: [{id: "oritech:copper_gem", count: 1}],
    fluidOutputs: [{fluid: "oritech:still_mineral_slurry", amount: 8100}],
    time: 200,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 40500},
    ingredients: [{item: "oritech:copper_clump", count: 1}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t15d.grind_gem.copper", {type: "techreborn:grinder",
    time: 200, power: 32,
    outputs: [{id: "oritech:copper_dust", count: 3}],
    ingredients: [{item: "oritech:copper_gem"}]
});

// ---------- 金 ----------
<recipetype:oritech:refinery>.addJsonRecipe("general.t15a.leach.gold", {type: "oritech:refinery",
    results: [],
    fluidOutputs: [
        {fluid: "jsonreg:gold_solution", amount: 81000},
        {fluid: "oritech:still_mineral_slurry", amount: 20250}
    ],
    time: 160,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 81000},
    ingredients: [{item: "minecraft:raw_gold", count: 2}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15b.precipitate.gold", {type: "oritech:centrifuge_fluid",
    results: [{id: "oritech:gold_clump", count: 1}],
    time: 150,
    fluidInput: {fluid: "jsonreg:gold_solution", amount: 81000},
    ingredients: [{item: "jsonreg:salt_dust", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15c.recrystallize.gold", {type: "oritech:centrifuge_fluid",
    results: [{id: "oritech:gold_gem", count: 1}],
    fluidOutputs: [{fluid: "oritech:still_mineral_slurry", amount: 8100}],
    time: 200,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 40500},
    ingredients: [{item: "oritech:gold_clump", count: 1}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t15d.grind_gem.gold", {type: "techreborn:grinder",
    time: 200, power: 32,
    outputs: [{id: "oritech:gold_dust", count: 3}],
    ingredients: [{item: "oritech:gold_gem"}]
});

// ---------- 铁 ----------
<recipetype:oritech:refinery>.addJsonRecipe("general.t15a.leach.iron", {type: "oritech:refinery",
    results: [],
    fluidOutputs: [
        {fluid: "jsonreg:iron_solution", amount: 81000},
        {fluid: "oritech:still_mineral_slurry", amount: 20250}
    ],
    time: 160,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 81000},
    ingredients: [{item: "minecraft:raw_iron", count: 2}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15b.precipitate.iron", {type: "oritech:centrifuge_fluid",
    results: [{id: "oritech:iron_clump", count: 1}],
    time: 150,
    fluidInput: {fluid: "jsonreg:iron_solution", amount: 81000},
    ingredients: [{item: "jsonreg:salt_dust", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15c.recrystallize.iron", {type: "oritech:centrifuge_fluid",
    results: [{id: "oritech:iron_gem", count: 1}],
    fluidOutputs: [{fluid: "oritech:still_mineral_slurry", amount: 8100}],
    time: 200,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 40500},
    ingredients: [{item: "oritech:iron_clump", count: 1}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t15d.grind_gem.iron", {type: "techreborn:grinder",
    time: 200, power: 32,
    outputs: [{id: "oritech:iron_dust", count: 3}],
    ingredients: [{item: "oritech:iron_gem"}]
});

// ---------- 镍 ----------
<recipetype:oritech:refinery>.addJsonRecipe("general.t15a.leach.nickel", {type: "oritech:refinery",
    results: [],
    fluidOutputs: [
        {fluid: "jsonreg:nickel_solution", amount: 81000},
        {fluid: "oritech:still_mineral_slurry", amount: 20250}
    ],
    time: 160,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 81000},
    ingredients: [{item: "oritech:raw_nickel", count: 2}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15b.precipitate.nickel", {type: "oritech:centrifuge_fluid",
    results: [{id: "oritech:nickel_clump", count: 1}],
    time: 150,
    fluidInput: {fluid: "jsonreg:nickel_solution", amount: 81000},
    ingredients: [{item: "jsonreg:salt_dust", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15c.recrystallize.nickel", {type: "oritech:centrifuge_fluid",
    results: [{id: "oritech:nickel_gem", count: 1}],
    fluidOutputs: [{fluid: "oritech:still_mineral_slurry", amount: 8100}],
    time: 200,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 40500},
    ingredients: [{item: "oritech:nickel_clump", count: 1}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t15d.grind_gem.nickel", {type: "techreborn:grinder",
    time: 200, power: 32,
    outputs: [{id: "techreborn:nickel_dust", count: 3}],
    ingredients: [{item: "oritech:nickel_gem"}]
});

// ---------- 铂 ----------
<recipetype:oritech:refinery>.addJsonRecipe("general.t15a.leach.platinum", {type: "oritech:refinery",
    results: [],
    fluidOutputs: [
        {fluid: "jsonreg:platinum_solution", amount: 81000},
        {fluid: "oritech:still_mineral_slurry", amount: 20250}
    ],
    time: 160,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 81000},
    ingredients: [{item: "oritech:raw_platinum", count: 2}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15b.precipitate.platinum", {type: "oritech:centrifuge_fluid",
    results: [{id: "oritech:platinum_clump", count: 1}],
    time: 150,
    fluidInput: {fluid: "jsonreg:platinum_solution", amount: 81000},
    ingredients: [{item: "jsonreg:salt_dust", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15c.recrystallize.platinum", {type: "oritech:centrifuge_fluid",
    results: [{id: "oritech:platinum_gem", count: 1}],
    fluidOutputs: [{fluid: "oritech:still_mineral_slurry", amount: 8100}],
    time: 200,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 40500},
    ingredients: [{item: "oritech:platinum_clump", count: 1}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t15d.grind_gem.platinum", {type: "techreborn:grinder",
    time: 200, power: 32,
    outputs: [{id: "techreborn:platinum_dust", count: 3}],
    ingredients: [{item: "oritech:platinum_gem"}]
});

// ---------- 铅 ----------
<recipetype:oritech:refinery>.addJsonRecipe("general.t15a.leach.lead", {type: "oritech:refinery",
    results: [],
    fluidOutputs: [
        {fluid: "jsonreg:lead_solution", amount: 81000},
        {fluid: "oritech:still_mineral_slurry", amount: 20250}
    ],
    time: 160,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 81000},
    ingredients: [{item: "techreborn:raw_lead", count: 2}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15b.precipitate.lead", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:lead_clump", count: 1}],
    time: 150,
    fluidInput: {fluid: "jsonreg:lead_solution", amount: 81000},
    ingredients: [{item: "jsonreg:salt_dust", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15c.recrystallize.lead", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:lead_gem", count: 1}],
    fluidOutputs: [{fluid: "oritech:still_mineral_slurry", amount: 8100}],
    time: 200,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 40500},
    ingredients: [{item: "jsonreg:lead_clump", count: 1}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t15d.grind_gem.lead", {type: "techreborn:grinder",
    time: 200, power: 32,
    outputs: [{id: "jsonreg:lead_dust", count: 3}],
    ingredients: [{item: "jsonreg:lead_gem"}]
});

// ---------- 银 ----------
<recipetype:oritech:refinery>.addJsonRecipe("general.t15a.leach.silver", {type: "oritech:refinery",
    results: [],
    fluidOutputs: [
        {fluid: "jsonreg:silver_solution", amount: 81000},
        {fluid: "oritech:still_mineral_slurry", amount: 20250}
    ],
    time: 160,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 81000},
    ingredients: [{item: "techreborn:raw_silver", count: 2}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15b.precipitate.silver", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:silver_clump", count: 1}],
    time: 150,
    fluidInput: {fluid: "jsonreg:silver_solution", amount: 81000},
    ingredients: [{item: "jsonreg:salt_dust", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15c.recrystallize.silver", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:silver_gem", count: 1}],
    fluidOutputs: [{fluid: "oritech:still_mineral_slurry", amount: 8100}],
    time: 200,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 40500},
    ingredients: [{item: "jsonreg:silver_clump", count: 1}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t15d.grind_gem.silver", {type: "techreborn:grinder",
    time: 200, power: 32,
    outputs: [{id: "jsonreg:silver_dust", count: 3}],
    ingredients: [{item: "jsonreg:silver_gem"}]
});

// ---------- 锡 ----------
<recipetype:oritech:refinery>.addJsonRecipe("general.t15a.leach.tin", {type: "oritech:refinery",
    results: [],
    fluidOutputs: [
        {fluid: "jsonreg:tin_solution", amount: 81000},
        {fluid: "oritech:still_mineral_slurry", amount: 20250}
    ],
    time: 160,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 81000},
    ingredients: [{item: "techreborn:raw_tin", count: 2}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15b.precipitate.tin", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:tin_clump", count: 1}],
    time: 150,
    fluidInput: {fluid: "jsonreg:tin_solution", amount: 81000},
    ingredients: [{item: "jsonreg:salt_dust", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15c.recrystallize.tin", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:tin_gem", count: 1}],
    fluidOutputs: [{fluid: "oritech:still_mineral_slurry", amount: 8100}],
    time: 200,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 40500},
    ingredients: [{item: "jsonreg:tin_clump", count: 1}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t15d.grind_gem.tin", {type: "techreborn:grinder",
    time: 200, power: 32,
    outputs: [{id: "jsonreg:tin_dust", count: 3}],
    ingredients: [{item: "jsonreg:tin_gem"}]
});

// ---------- 钨 ----------
<recipetype:oritech:refinery>.addJsonRecipe("general.t15a.leach.tungsten", {type: "oritech:refinery",
    results: [],
    fluidOutputs: [
        {fluid: "jsonreg:tungsten_solution", amount: 81000},
        {fluid: "oritech:still_mineral_slurry", amount: 20250}
    ],
    time: 160,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 81000},
    ingredients: [{item: "techreborn:raw_tungsten", count: 2}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15b.precipitate.tungsten", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:tungsten_clump", count: 1}],
    time: 150,
    fluidInput: {fluid: "jsonreg:tungsten_solution", amount: 81000},
    ingredients: [{item: "jsonreg:salt_dust", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15c.recrystallize.tungsten", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:tungsten_gem", count: 1}],
    fluidOutputs: [{fluid: "oritech:still_mineral_slurry", amount: 8100}],
    time: 200,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 40500},
    ingredients: [{item: "jsonreg:tungsten_clump", count: 1}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t15d.grind_gem.tungsten", {type: "techreborn:grinder",
    time: 200, power: 32,
    outputs: [{id: "jsonreg:tungsten_dust", count: 3}],
    ingredients: [{item: "jsonreg:tungsten_gem"}]
});

// ---------- 铱 ----------
<recipetype:oritech:refinery>.addJsonRecipe("general.t15a.leach.iridium", {type: "oritech:refinery",
    results: [],
    fluidOutputs: [
        {fluid: "jsonreg:iridium_solution", amount: 81000},
        {fluid: "oritech:still_mineral_slurry", amount: 20250}
    ],
    time: 160,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 81000},
    ingredients: [{item: "techreborn:raw_iridium", count: 2}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15b.precipitate.iridium", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:iridium_clump", count: 1}],
    time: 150,
    fluidInput: {fluid: "jsonreg:iridium_solution", amount: 81000},
    ingredients: [{item: "jsonreg:salt_dust", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15c.recrystallize.iridium", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:iridium_gem", count: 1}],
    fluidOutputs: [{fluid: "oritech:still_mineral_slurry", amount: 8100}],
    time: 200,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 40500},
    ingredients: [{item: "jsonreg:iridium_clump", count: 1}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t15d.grind_gem.iridium", {type: "techreborn:grinder",
    time: 200, power: 32,
    outputs: [{id: "jsonreg:iridium_dust", count: 3}],
    ingredients: [{item: "jsonreg:iridium_gem"}]
});

// ---------- 铀 ----------
<recipetype:oritech:refinery>.addJsonRecipe("general.t15a.leach.uranium", {type: "oritech:refinery",
    results: [],
    fluidOutputs: [
        {fluid: "jsonreg:uranium_solution", amount: 81000},
        {fluid: "oritech:still_mineral_slurry", amount: 20250}
    ],
    time: 160,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 81000},
    ingredients: [{item: "oritech:raw_uranium", count: 2}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15b.precipitate.uranium", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:uranium_clump", count: 1}],
    time: 150,
    fluidInput: {fluid: "jsonreg:uranium_solution", amount: 81000},
    ingredients: [{item: "jsonreg:salt_dust", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15c.recrystallize.uranium", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:uranium_gem", count: 1}],
    fluidOutputs: [{fluid: "oritech:still_mineral_slurry", amount: 8100}],
    time: 200,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 40500},
    ingredients: [{item: "jsonreg:uranium_clump", count: 1}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t15d.grind_gem.uranium", {type: "techreborn:grinder",
    time: 200, power: 32,
    outputs: [{id: "oritech:uranium_dust", count: 3}],
    ingredients: [{item: "jsonreg:uranium_gem"}]
});

// ---------- 铝 ----------
<recipetype:oritech:refinery>.addJsonRecipe("general.t15a.leach.aluminum", {type: "oritech:refinery",
    results: [],
    fluidOutputs: [
        {fluid: "jsonreg:aluminum_solution", amount: 81000},
        {fluid: "oritech:still_mineral_slurry", amount: 20250}
    ],
    time: 160,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 81000},
    ingredients: [{tag: "c:ores/bauxite", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15b.precipitate.aluminum", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:aluminum_clump", count: 1}],
    time: 150,
    fluidInput: {fluid: "jsonreg:aluminum_solution", amount: 81000},
    ingredients: [{item: "jsonreg:salt_dust", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15c.recrystallize.aluminum", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:aluminum_gem", count: 1}],
    fluidOutputs: [{fluid: "oritech:still_mineral_slurry", amount: 8100}],
    time: 200,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 40500},
    ingredients: [{item: "jsonreg:aluminum_clump", count: 1}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t15d.grind_gem.aluminum", {type: "techreborn:grinder",
    time: 200, power: 32,
    outputs: [{id: "techreborn:aluminum_dust", count: 3}],
    ingredients: [{item: "jsonreg:aluminum_gem"}]
});

// ---------- 方铅 ----------
<recipetype:oritech:refinery>.addJsonRecipe("general.t15a.leach.galena", {type: "oritech:refinery",
    results: [],
    fluidOutputs: [
        {fluid: "jsonreg:galena_solution", amount: 81000},
        {fluid: "oritech:still_mineral_slurry", amount: 20250}
    ],
    time: 160,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 81000},
    ingredients: [{tag: "c:ores/galena", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15b.precipitate.galena", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:galena_clump", count: 1}],
    time: 150,
    fluidInput: {fluid: "jsonreg:galena_solution", amount: 81000},
    ingredients: [{item: "jsonreg:salt_dust", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15c.recrystallize.galena", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:galena_gem", count: 1}],
    fluidOutputs: [{fluid: "oritech:still_mineral_slurry", amount: 8100}],
    time: 200,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 40500},
    ingredients: [{item: "jsonreg:galena_clump", count: 1}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t15d.grind_gem.galena", {type: "techreborn:grinder",
    time: 200, power: 32,
    outputs: [{id: "techreborn:galena_dust", count: 3}],
    ingredients: [{item: "jsonreg:galena_gem"}]
});

// ---------- 闪锌 ----------
<recipetype:oritech:refinery>.addJsonRecipe("general.t15a.leach.sphalerite", {type: "oritech:refinery",
    results: [],
    fluidOutputs: [
        {fluid: "jsonreg:sphalerite_solution", amount: 81000},
        {fluid: "oritech:still_mineral_slurry", amount: 20250}
    ],
    time: 160,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 81000},
    ingredients: [{tag: "c:ores/sphalerite", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15b.precipitate.sphalerite", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:sphalerite_clump", count: 1}],
    time: 150,
    fluidInput: {fluid: "jsonreg:sphalerite_solution", amount: 81000},
    ingredients: [{item: "jsonreg:salt_dust", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15c.recrystallize.sphalerite", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:sphalerite_gem", count: 1}],
    fluidOutputs: [{fluid: "oritech:still_mineral_slurry", amount: 8100}],
    time: 200,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 40500},
    ingredients: [{item: "jsonreg:sphalerite_clump", count: 1}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t15d.grind_gem.sphalerite", {type: "techreborn:grinder",
    time: 200, power: 32,
    outputs: [{id: "techreborn:sphalerite_dust", count: 3}],
    ingredients: [{item: "jsonreg:sphalerite_gem"}]
});

// ---------- 朱砂 ----------
<recipetype:oritech:refinery>.addJsonRecipe("general.t15a.leach.cinnabar", {type: "oritech:refinery",
    results: [],
    fluidOutputs: [
        {fluid: "jsonreg:cinnabar_solution", amount: 81000},
        {fluid: "oritech:still_mineral_slurry", amount: 20250}
    ],
    time: 160,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 81000},
    ingredients: [{tag: "c:ores/cinnabar", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15b.precipitate.cinnabar", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:cinnabar_clump", count: 1}],
    time: 150,
    fluidInput: {fluid: "jsonreg:cinnabar_solution", amount: 81000},
    ingredients: [{item: "jsonreg:salt_dust", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15c.recrystallize.cinnabar", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:cinnabar_gem", count: 1}],
    fluidOutputs: [{fluid: "oritech:still_mineral_slurry", amount: 8100}],
    time: 200,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 40500},
    ingredients: [{item: "jsonreg:cinnabar_clump", count: 1}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t15d.grind_gem.cinnabar", {type: "techreborn:grinder",
    time: 200, power: 32,
    outputs: [{id: "techreborn:cinnabar_dust", count: 3}],
    ingredients: [{item: "jsonreg:cinnabar_gem"}]
});

// ---------- 黄铁 ----------
<recipetype:oritech:refinery>.addJsonRecipe("general.t15a.leach.pyrite", {type: "oritech:refinery",
    results: [],
    fluidOutputs: [
        {fluid: "jsonreg:pyrite_solution", amount: 81000},
        {fluid: "oritech:still_mineral_slurry", amount: 20250}
    ],
    time: 160,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 81000},
    ingredients: [{tag: "c:ores/pyrite", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15b.precipitate.pyrite", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:pyrite_clump", count: 1}],
    time: 150,
    fluidInput: {fluid: "jsonreg:pyrite_solution", amount: 81000},
    ingredients: [{item: "jsonreg:salt_dust", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15c.recrystallize.pyrite", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:pyrite_gem", count: 1}],
    fluidOutputs: [{fluid: "oritech:still_mineral_slurry", amount: 8100}],
    time: 200,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 40500},
    ingredients: [{item: "jsonreg:pyrite_clump", count: 1}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t15d.grind_gem.pyrite", {type: "techreborn:grinder",
    time: 200, power: 32,
    outputs: [{id: "techreborn:pyrite_dust", count: 3}],
    ingredients: [{item: "jsonreg:pyrite_gem"}]
});

// ---------- 方钠 ----------
<recipetype:oritech:refinery>.addJsonRecipe("general.t15a.leach.sodalite", {type: "oritech:refinery",
    results: [],
    fluidOutputs: [
        {fluid: "jsonreg:sodalite_solution", amount: 81000},
        {fluid: "oritech:still_mineral_slurry", amount: 20250}
    ],
    time: 160,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 81000},
    ingredients: [{tag: "c:ores/sodalite", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15b.precipitate.sodalite", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:sodalite_clump", count: 1}],
    time: 150,
    fluidInput: {fluid: "jsonreg:sodalite_solution", amount: 81000},
    ingredients: [{item: "jsonreg:salt_dust", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15c.recrystallize.sodalite", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:sodalite_gem", count: 1}],
    fluidOutputs: [{fluid: "oritech:still_mineral_slurry", amount: 8100}],
    time: 200,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 40500},
    ingredients: [{item: "jsonreg:sodalite_clump", count: 1}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t15d.grind_gem.sodalite", {type: "techreborn:grinder",
    time: 200, power: 32,
    outputs: [{id: "techreborn:sodalite_dust", count: 3}],
    ingredients: [{item: "jsonreg:sodalite_gem"}]
});

// ============================================================
// T2：工业分离与副产物
// ============================================================
// 前提：**dust 是永远的最终产物** —— 中间产物与加工链条只决定一个矿石最终能产出多少粉。
// 所以 T2 不是「比 dust 更高一级的产物」，而是把产粉量从 T1.5 的 3 倍推到 5 倍。
//
//   T2a 浓缩化  TR 化反(2进2出)  X碎块 ×1 + 硫酸单元 → X浓缩物 ×1 + 空单元
//   T2b 高纯粉  TR 工业磨粉机     X浓缩物 + 流体 → X粉 ×N + 0~2 副产
//
// 注：T2a 在 **TR 化反**上，不受「OR 离心机只支持 1 输入」的限制；
//     碎块取 1 个，使 1 矿石 → 1 碎块 → 1 浓缩物 → 5 粉（水支路）成立。
//
// 三条流体分支**互斥**，不可叠加最大倍率：
//   水       粉 ×5              主产物最高
//   汞       粉 ×4 + 副产 ×1     兼顾
//   过硫酸钠 粉 ×3 + 副产 ×2     副产最多（与 TR 既有工艺一致：
//                                过硫酸钠的价值是改变副产结构而非拉高主产物）
//
// 产出阶梯（每 1 个矿石）：T1 粗矿 ×2 → T1.5 石 → 粉 ×3 → T2 水支路 粉 ×5
//
// 副产依据（每种矿物 0~2 类，均有矿物学理由）：
//   铜→金/镍   金→铜/镍   铁→镍/锡   镍→铂/铜   铂→镍/铱   铱→铂
//   铅→方铅/硫 银→方铅/硫 锡→铁/锌   钨→铁/锰   铀→铅（放射成因，**不产钚**）
//   铝→铁/镓   方铅→硫/银 闪锌→硫/锌 朱砂→硫    黄铁→硫     方钠→铝

// ---------- 铜 ----------
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("general.t2a.concentrate.copper", {type: "techreborn:chemical_reactor",
    time: 400,
    power: 128,
    outputs: [
        {id: "jsonreg:copper_concentrate", count: 1},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {item: "oritech:copper_clump", count: 1},
        {count: 1, components: {"techreborn:fluid": "oritech:still_sulfuric_acid"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.water.copper", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "oritech:copper_dust", count: 5}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "minecraft:water"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:copper_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.mercury.copper", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "oritech:copper_dust", count: 4},
        {id: "minecraft:raw_gold", count: 2}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "techreborn:mercury"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:copper_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.persulfate.copper", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "oritech:copper_dust", count: 3},
        {id: "minecraft:raw_gold", count: 2},
        {id: "techreborn:nickel_dust", count: 1}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "techreborn:sodium_persulfate"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:copper_concentrate"}]
});

// ---------- 金 ----------
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("general.t2a.concentrate.gold", {type: "techreborn:chemical_reactor",
    time: 400,
    power: 128,
    outputs: [
        {id: "jsonreg:gold_concentrate", count: 1},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {item: "oritech:gold_clump", count: 1},
        {count: 1, components: {"techreborn:fluid": "oritech:still_sulfuric_acid"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.water.gold", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "oritech:gold_dust", count: 5}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "minecraft:water"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:gold_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.mercury.gold", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "oritech:gold_dust", count: 4},
        {id: "minecraft:raw_copper", count: 2}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "techreborn:mercury"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:gold_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.persulfate.gold", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "oritech:gold_dust", count: 3},
        {id: "minecraft:raw_copper", count: 2},
        {id: "techreborn:nickel_dust", count: 1}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "techreborn:sodium_persulfate"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:gold_concentrate"}]
});

// ---------- 铁 ----------
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("general.t2a.concentrate.iron", {type: "techreborn:chemical_reactor",
    time: 400,
    power: 128,
    outputs: [
        {id: "jsonreg:iron_concentrate", count: 1},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {item: "oritech:iron_clump", count: 1},
        {count: 1, components: {"techreborn:fluid": "oritech:still_sulfuric_acid"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.water.iron", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "oritech:iron_dust", count: 5}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "minecraft:water"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:iron_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.mercury.iron", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "oritech:iron_dust", count: 4},
        {id: "techreborn:nickel_dust", count: 2}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "techreborn:mercury"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:iron_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.persulfate.iron", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "oritech:iron_dust", count: 3},
        {id: "techreborn:nickel_dust", count: 2},
        {id: "techreborn:tin_nugget", count: 1}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "techreborn:sodium_persulfate"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:iron_concentrate"}]
});

// ---------- 镍 ----------
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("general.t2a.concentrate.nickel", {type: "techreborn:chemical_reactor",
    time: 400,
    power: 128,
    outputs: [
        {id: "jsonreg:nickel_concentrate", count: 1},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {item: "oritech:nickel_clump", count: 1},
        {count: 1, components: {"techreborn:fluid": "oritech:still_sulfuric_acid"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.water.nickel", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "techreborn:nickel_dust", count: 5}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "minecraft:water"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:nickel_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.mercury.nickel", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "techreborn:nickel_dust", count: 4},
        {id: "techreborn:platinum_dust", count: 2}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "techreborn:mercury"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:nickel_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.persulfate.nickel", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "techreborn:nickel_dust", count: 3},
        {id: "techreborn:platinum_dust", count: 2},
        {id: "minecraft:raw_copper", count: 1}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "techreborn:sodium_persulfate"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:nickel_concentrate"}]
});

// ---------- 铂 ----------
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("general.t2a.concentrate.platinum", {type: "techreborn:chemical_reactor",
    time: 400,
    power: 128,
    outputs: [
        {id: "jsonreg:platinum_concentrate", count: 1},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {item: "oritech:platinum_clump", count: 1},
        {count: 1, components: {"techreborn:fluid": "oritech:still_sulfuric_acid"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.water.platinum", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "techreborn:platinum_dust", count: 5}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "minecraft:water"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:platinum_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.mercury.platinum", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "techreborn:platinum_dust", count: 4},
        {id: "techreborn:nickel_dust", count: 2}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "techreborn:mercury"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:platinum_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.persulfate.platinum", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "techreborn:platinum_dust", count: 3},
        {id: "techreborn:nickel_dust", count: 2},
        {id: "techreborn:iridium_nugget", count: 1}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "techreborn:sodium_persulfate"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:platinum_concentrate"}]
});

// ---------- 铅 ----------
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("general.t2a.concentrate.lead", {type: "techreborn:chemical_reactor",
    time: 400,
    power: 128,
    outputs: [
        {id: "jsonreg:lead_concentrate", count: 1},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {item: "jsonreg:lead_clump", count: 1},
        {count: 1, components: {"techreborn:fluid": "oritech:still_sulfuric_acid"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.water.lead", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "jsonreg:lead_dust", count: 5}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "minecraft:water"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:lead_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.mercury.lead", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "jsonreg:lead_dust", count: 4},
        {id: "techreborn:galena_small_dust", count: 2}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "techreborn:mercury"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:lead_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.persulfate.lead", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "jsonreg:lead_dust", count: 3},
        {id: "techreborn:galena_small_dust", count: 2},
        {id: "techreborn:sulfur_dust", count: 1}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "techreborn:sodium_persulfate"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:lead_concentrate"}]
});

// ---------- 银 ----------
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("general.t2a.concentrate.silver", {type: "techreborn:chemical_reactor",
    time: 400,
    power: 128,
    outputs: [
        {id: "jsonreg:silver_concentrate", count: 1},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {item: "jsonreg:silver_clump", count: 1},
        {count: 1, components: {"techreborn:fluid": "oritech:still_sulfuric_acid"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.water.silver", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "jsonreg:silver_dust", count: 5}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "minecraft:water"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:silver_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.mercury.silver", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "jsonreg:silver_dust", count: 4},
        {id: "techreborn:galena_small_dust", count: 2}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "techreborn:mercury"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:silver_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.persulfate.silver", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "jsonreg:silver_dust", count: 3},
        {id: "techreborn:galena_small_dust", count: 2},
        {id: "techreborn:sulfur_dust", count: 1}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "techreborn:sodium_persulfate"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:silver_concentrate"}]
});

// ---------- 锡 ----------
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("general.t2a.concentrate.tin", {type: "techreborn:chemical_reactor",
    time: 400,
    power: 128,
    outputs: [
        {id: "jsonreg:tin_concentrate", count: 1},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {item: "jsonreg:tin_clump", count: 1},
        {count: 1, components: {"techreborn:fluid": "oritech:still_sulfuric_acid"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.water.tin", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "jsonreg:tin_dust", count: 5}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "minecraft:water"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:tin_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.mercury.tin", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "jsonreg:tin_dust", count: 4},
        {id: "minecraft:iron_nugget", count: 2}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "techreborn:mercury"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:tin_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.persulfate.tin", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "jsonreg:tin_dust", count: 3},
        {id: "minecraft:iron_nugget", count: 2},
        {id: "techreborn:zinc_dust", count: 1}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "techreborn:sodium_persulfate"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:tin_concentrate"}]
});

// ---------- 钨 ----------
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("general.t2a.concentrate.tungsten", {type: "techreborn:chemical_reactor",
    time: 400,
    power: 128,
    outputs: [
        {id: "jsonreg:tungsten_concentrate", count: 1},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {item: "jsonreg:tungsten_clump", count: 1},
        {count: 1, components: {"techreborn:fluid": "oritech:still_sulfuric_acid"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.water.tungsten", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "jsonreg:tungsten_dust", count: 5}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "minecraft:water"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:tungsten_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.mercury.tungsten", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "jsonreg:tungsten_dust", count: 4},
        {id: "minecraft:iron_nugget", count: 2}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "techreborn:mercury"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:tungsten_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.persulfate.tungsten", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "jsonreg:tungsten_dust", count: 3},
        {id: "minecraft:iron_nugget", count: 2},
        {id: "techreborn:manganese_small_dust", count: 1}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "techreborn:sodium_persulfate"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:tungsten_concentrate"}]
});

// ---------- 铱 ----------
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("general.t2a.concentrate.iridium", {type: "techreborn:chemical_reactor",
    time: 400,
    power: 128,
    outputs: [
        {id: "jsonreg:iridium_concentrate", count: 1},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {item: "jsonreg:iridium_clump", count: 1},
        {count: 1, components: {"techreborn:fluid": "oritech:still_sulfuric_acid"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.water.iridium", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "jsonreg:iridium_dust", count: 5}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "minecraft:water"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:iridium_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.mercury.iridium", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "jsonreg:iridium_dust", count: 4},
        {id: "techreborn:platinum_small_dust", count: 2}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "techreborn:mercury"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:iridium_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.persulfate.iridium", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "jsonreg:iridium_dust", count: 3},
        {id: "techreborn:platinum_small_dust", count: 2}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "techreborn:sodium_persulfate"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:iridium_concentrate"}]
});

// ---------- 铀 ----------
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("general.t2a.concentrate.uranium", {type: "techreborn:chemical_reactor",
    time: 400,
    power: 128,
    outputs: [
        {id: "jsonreg:uranium_concentrate", count: 1},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {item: "jsonreg:uranium_clump", count: 1},
        {count: 1, components: {"techreborn:fluid": "oritech:still_sulfuric_acid"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.water.uranium", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "oritech:uranium_dust", count: 5}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "minecraft:water"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:uranium_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.mercury.uranium", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "oritech:uranium_dust", count: 4},
        {id: "techreborn:raw_lead", count: 2}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "techreborn:mercury"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:uranium_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.persulfate.uranium", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "oritech:uranium_dust", count: 3},
        {id: "techreborn:raw_lead", count: 2}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "techreborn:sodium_persulfate"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:uranium_concentrate"}]
});

// ---------- 铝 ----------
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("general.t2a.concentrate.aluminum", {type: "techreborn:chemical_reactor",
    time: 400,
    power: 128,
    outputs: [
        {id: "jsonreg:aluminum_concentrate", count: 1},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {item: "jsonreg:aluminum_clump", count: 1},
        {count: 1, components: {"techreborn:fluid": "oritech:still_sulfuric_acid"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.water.aluminum", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "techreborn:aluminum_dust", count: 5}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "minecraft:water"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:aluminum_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.mercury.aluminum", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "techreborn:aluminum_dust", count: 4},
        {id: "oritech:iron_dust", count: 2}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "techreborn:mercury"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:aluminum_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.persulfate.aluminum", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "techreborn:aluminum_dust", count: 3},
        {id: "oritech:iron_dust", count: 2},
        {id: "jsonreg:gallium_dust", count: 1}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "techreborn:sodium_persulfate"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:aluminum_concentrate"}]
});

// ---------- 方铅 ----------
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("general.t2a.concentrate.galena", {type: "techreborn:chemical_reactor",
    time: 400,
    power: 128,
    outputs: [
        {id: "jsonreg:galena_concentrate", count: 1},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {item: "jsonreg:galena_clump", count: 1},
        {count: 1, components: {"techreborn:fluid": "oritech:still_sulfuric_acid"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.water.galena", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "techreborn:galena_dust", count: 5}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "minecraft:water"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:galena_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.mercury.galena", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "techreborn:galena_dust", count: 4},
        {id: "techreborn:sulfur_dust", count: 2}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "techreborn:mercury"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:galena_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.persulfate.galena", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "techreborn:galena_dust", count: 3},
        {id: "techreborn:sulfur_dust", count: 2},
        {id: "techreborn:raw_silver", count: 1}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "techreborn:sodium_persulfate"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:galena_concentrate"}]
});

// ---------- 闪锌 ----------
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("general.t2a.concentrate.sphalerite", {type: "techreborn:chemical_reactor",
    time: 400,
    power: 128,
    outputs: [
        {id: "jsonreg:sphalerite_concentrate", count: 1},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {item: "jsonreg:sphalerite_clump", count: 1},
        {count: 1, components: {"techreborn:fluid": "oritech:still_sulfuric_acid"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.water.sphalerite", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "techreborn:sphalerite_dust", count: 5}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "minecraft:water"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:sphalerite_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.mercury.sphalerite", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "techreborn:sphalerite_dust", count: 4},
        {id: "techreborn:sulfur_dust", count: 2}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "techreborn:mercury"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:sphalerite_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.persulfate.sphalerite", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "techreborn:sphalerite_dust", count: 3},
        {id: "techreborn:sulfur_dust", count: 2},
        {id: "techreborn:zinc_dust", count: 1}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "techreborn:sodium_persulfate"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:sphalerite_concentrate"}]
});

// ---------- 朱砂 ----------
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("general.t2a.concentrate.cinnabar", {type: "techreborn:chemical_reactor",
    time: 400,
    power: 128,
    outputs: [
        {id: "jsonreg:cinnabar_concentrate", count: 1},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {item: "jsonreg:cinnabar_clump", count: 1},
        {count: 1, components: {"techreborn:fluid": "oritech:still_sulfuric_acid"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.water.cinnabar", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "techreborn:cinnabar_dust", count: 5}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "minecraft:water"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:cinnabar_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.mercury.cinnabar", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "techreborn:cinnabar_dust", count: 4},
        {id: "techreborn:sulfur_dust", count: 2}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "techreborn:mercury"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:cinnabar_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.persulfate.cinnabar", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "techreborn:cinnabar_dust", count: 3},
        {id: "techreborn:sulfur_dust", count: 2}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "techreborn:sodium_persulfate"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:cinnabar_concentrate"}]
});

// ---------- 黄铁 ----------
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("general.t2a.concentrate.pyrite", {type: "techreborn:chemical_reactor",
    time: 400,
    power: 128,
    outputs: [
        {id: "jsonreg:pyrite_concentrate", count: 1},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {item: "jsonreg:pyrite_clump", count: 1},
        {count: 1, components: {"techreborn:fluid": "oritech:still_sulfuric_acid"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.water.pyrite", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "techreborn:pyrite_dust", count: 5}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "minecraft:water"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:pyrite_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.mercury.pyrite", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "techreborn:pyrite_dust", count: 4},
        {id: "techreborn:sulfur_dust", count: 2}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "techreborn:mercury"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:pyrite_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.persulfate.pyrite", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "techreborn:pyrite_dust", count: 3},
        {id: "techreborn:sulfur_dust", count: 2}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "techreborn:sodium_persulfate"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:pyrite_concentrate"}]
});

// ---------- 方钠 ----------
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("general.t2a.concentrate.sodalite", {type: "techreborn:chemical_reactor",
    time: 400,
    power: 128,
    outputs: [
        {id: "jsonreg:sodalite_concentrate", count: 1},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {item: "jsonreg:sodalite_clump", count: 1},
        {count: 1, components: {"techreborn:fluid": "oritech:still_sulfuric_acid"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.water.sodalite", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "techreborn:sodalite_dust", count: 5}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "minecraft:water"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:sodalite_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.mercury.sodalite", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "techreborn:sodalite_dust", count: 4},
        {id: "techreborn:aluminum_dust", count: 2}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "techreborn:mercury"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:sodalite_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.persulfate.sodalite", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "techreborn:sodalite_dust", count: 3},
        {id: "techreborn:aluminum_dust", count: 2}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "techreborn:sodium_persulfate"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:sodalite_concentrate"}]
});

// ============================================================
// T2.3：魔法催化（灵魂注入催化剂）
// ============================================================
// 定位：**强化 Tier 2 的既有步骤**，不新增并行倍增链。
//
// 为什么是「第四个分支」而不是「给旧分支加催化剂」：
//   TR 工业磨粉机只有 **1 个流体 + 1 个物品**输入槽，催化剂只能**取代**
//   水 / 汞 / 过硫酸钠，物理上无法叠加 ——
//   机器的槽位限制本身就天然保证了 plan 里「不叠加最大倍率」这条要求。
//
// 四条分支互斥（同一批浓缩物只能选一条）：
//   水        粉 ×5
//   汞        粉 ×4 + 副产 ×1
//   过硫酸钠   粉 ×3 + 副产 ×2
//   催化剂    粉 ×6 + 副产 ×2      ← 本层；产出最高，代价在魔法侧
//
// 产出核账：1 矿石 → 碎块 ×1 → 浓缩物 ×1 → 粉 ×6  ⇒ **6 倍**（T2 水支路为 5 倍）
// 完整阶梯：T1b 2×  <  T1.5 3×  <  T2 5×  <  T2.3 6×
//
// 门槛不在矿物侧而在魔法侧：jsonreg:soul_injection_catalyst 由 etst&magic.zs 的
//   `etst.tr.lcr/soul_injection` 生产（需 永恒星光以太 + Affinity 结晶尘），
//   属 T2.3 魔法线，故不会让基础矿处提前起飞。
//
// 催化剂按**消耗品**计价：每批吃 1 单元（空单元归还），不把催化剂价值算进产出。

<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t23.catalyzed.copper", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "oritech:copper_dust", count: 6},
        {id: "minecraft:raw_gold", count: 2},
        {id: "techreborn:nickel_dust", count: 1}
    ],
    time: 200,
    power: 256,
    fluid: {fluid: {fluid: "jsonreg:soul_injection_catalyst"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:copper_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t23.catalyzed.gold", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "oritech:gold_dust", count: 6},
        {id: "minecraft:raw_copper", count: 2},
        {id: "techreborn:nickel_dust", count: 1}
    ],
    time: 200,
    power: 256,
    fluid: {fluid: {fluid: "jsonreg:soul_injection_catalyst"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:gold_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t23.catalyzed.iron", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "oritech:iron_dust", count: 6},
        {id: "techreborn:nickel_dust", count: 2},
        {id: "techreborn:tin_nugget", count: 1}
    ],
    time: 200,
    power: 256,
    fluid: {fluid: {fluid: "jsonreg:soul_injection_catalyst"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:iron_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t23.catalyzed.nickel", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "techreborn:nickel_dust", count: 6},
        {id: "techreborn:platinum_dust", count: 2},
        {id: "minecraft:raw_copper", count: 1}
    ],
    time: 200,
    power: 256,
    fluid: {fluid: {fluid: "jsonreg:soul_injection_catalyst"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:nickel_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t23.catalyzed.platinum", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "techreborn:platinum_dust", count: 6},
        {id: "techreborn:nickel_dust", count: 2},
        {id: "techreborn:iridium_nugget", count: 1}
    ],
    time: 200,
    power: 256,
    fluid: {fluid: {fluid: "jsonreg:soul_injection_catalyst"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:platinum_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t23.catalyzed.lead", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "jsonreg:lead_dust", count: 6},
        {id: "techreborn:galena_small_dust", count: 2},
        {id: "techreborn:sulfur_dust", count: 1}
    ],
    time: 200,
    power: 256,
    fluid: {fluid: {fluid: "jsonreg:soul_injection_catalyst"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:lead_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t23.catalyzed.silver", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "jsonreg:silver_dust", count: 6},
        {id: "techreborn:galena_small_dust", count: 2},
        {id: "techreborn:sulfur_dust", count: 1}
    ],
    time: 200,
    power: 256,
    fluid: {fluid: {fluid: "jsonreg:soul_injection_catalyst"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:silver_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t23.catalyzed.tin", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "jsonreg:tin_dust", count: 6},
        {id: "minecraft:iron_nugget", count: 2},
        {id: "techreborn:zinc_dust", count: 1}
    ],
    time: 200,
    power: 256,
    fluid: {fluid: {fluid: "jsonreg:soul_injection_catalyst"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:tin_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t23.catalyzed.tungsten", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "jsonreg:tungsten_dust", count: 6},
        {id: "minecraft:iron_nugget", count: 2},
        {id: "techreborn:manganese_small_dust", count: 1}
    ],
    time: 200,
    power: 256,
    fluid: {fluid: {fluid: "jsonreg:soul_injection_catalyst"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:tungsten_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t23.catalyzed.iridium", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "jsonreg:iridium_dust", count: 6},
        {id: "techreborn:platinum_small_dust", count: 2}
    ],
    time: 200,
    power: 256,
    fluid: {fluid: {fluid: "jsonreg:soul_injection_catalyst"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:iridium_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t23.catalyzed.uranium", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "oritech:uranium_dust", count: 6},
        {id: "techreborn:raw_lead", count: 2}
    ],
    time: 200,
    power: 256,
    fluid: {fluid: {fluid: "jsonreg:soul_injection_catalyst"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:uranium_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t23.catalyzed.aluminum", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "techreborn:aluminum_dust", count: 6},
        {id: "oritech:iron_dust", count: 2},
        {id: "jsonreg:gallium_dust", count: 1}
    ],
    time: 200,
    power: 256,
    fluid: {fluid: {fluid: "jsonreg:soul_injection_catalyst"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:aluminum_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t23.catalyzed.galena", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "techreborn:galena_dust", count: 6},
        {id: "techreborn:sulfur_dust", count: 2},
        {id: "techreborn:raw_silver", count: 1}
    ],
    time: 200,
    power: 256,
    fluid: {fluid: {fluid: "jsonreg:soul_injection_catalyst"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:galena_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t23.catalyzed.sphalerite", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "techreborn:sphalerite_dust", count: 6},
        {id: "techreborn:sulfur_dust", count: 2},
        {id: "techreborn:zinc_dust", count: 1}
    ],
    time: 200,
    power: 256,
    fluid: {fluid: {fluid: "jsonreg:soul_injection_catalyst"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:sphalerite_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t23.catalyzed.cinnabar", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "techreborn:cinnabar_dust", count: 6},
        {id: "techreborn:sulfur_dust", count: 2}
    ],
    time: 200,
    power: 256,
    fluid: {fluid: {fluid: "jsonreg:soul_injection_catalyst"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:cinnabar_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t23.catalyzed.pyrite", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "techreborn:pyrite_dust", count: 6},
        {id: "techreborn:sulfur_dust", count: 2}
    ],
    time: 200,
    power: 256,
    fluid: {fluid: {fluid: "jsonreg:soul_injection_catalyst"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:pyrite_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t23.catalyzed.sodalite", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "techreborn:sodalite_dust", count: 6},
        {id: "techreborn:aluminum_dust", count: 2}
    ],
    time: 200,
    power: 256,
    fluid: {fluid: {fluid: "jsonreg:soul_injection_catalyst"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:sodalite_concentrate"}]
});
