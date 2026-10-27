
// ============================================================
// 【拆分说明】
// ============================================================
// 本文件由原 scripts/general_ore_process.zs 按 tier 拆分而来。
// 拆分原因：原文件 2558 行被 ZenCode 编译成**单个 run() 方法**，超过
//   JVM 64KB 方法体上限 → MethodTooLargeException：
//   "Method too large: scripts/general_ore_process.run ()V"
//   后果是整份脚本一条都不执行，矿石处理全线失效。
//
// 拆分后按文件名数字前缀顺序加载：
//   01_t1.zs    T1 清退 + T1 干法粗处理 + T1b 粗矿制粉
//   02_t15.zs   T1.5 湿法处理与初级浓缩
//   03_t2.zs    T2 工业分离与副产物
//   04_t23.zs   T2.3 魔法催化（灵魂注入催化剂）
//
// 加载位置：ore_process/ 按路径排序落在 oil_chemistry.zs(o) 之后、
//   precision_assembly.zs(p) 之前 —— 此时 material_tags.zs(m) 已加载。
//   已确认其后没有任何脚本对 grinder / industrial_grinder /
//   chemical_reactor / refinery / centrifuge_fluid 调用 removeAll()。
//
// 配方名未改动（仍为 general.tX.*），全局唯一性不受影响。
// ============================================================

// === T1 / T1b：干法粗处理与粗矿制粉 ===

/*
    AI 真的好好用。
    崭新矿处 plan 来自 GPT-6-sol，实现来自 v4.1f。

    不要 sonnet 个！
*/

// ============================================================
// 基础矿物处理链路（原 general_ore_process.zs，已按 tier 拆分）
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
// 当前进度：结束了。
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

// —— 氟石（jsonreg 自定义矿，产氟）——
// 化学定位：氟石 = CaF₂，本包唯一的**独立氟源**。
// 在此之前氟 / 氢氟酸只能从超能硅岩线自身的副产里回收（nqdria.4a、nqdh.5b），
// 而 nqdria.3 的氢氟酸浸出一次就要 10B —— 属于鸡生蛋死锁，氟石线就是为解开它而加。
// 矿脉见 GTOreVein 的 nether_fluorite（下界，主矿氟石 + 副矿岩盐 40%）。
// 注：与 salt/rock_salt 一样**用直接物品引用而非 c:ores/fluorite 标签** ——
//   本文件(g) 比 material_tags.zs(m) 先加载，靠后者定义的标签不安全。
//   标签仍照常登记，供 EMI 归类使用。
<recipetype:techreborn:grinder>.addJsonRecipe("general.t1.fluorite", {type: "techreborn:grinder",
    time: 80, power: 8,
    outputs: [{id: "jsonreg:fluorite_dust", count: 2}],
    ingredients: [{item: "jsonreg:nether_fluorite_ore"}]
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
// 【追加】下界钒磁铁矿 / 软锰矿 / 铬铁矿 / 硬锰矿 完整链路
// ============================================================
// 四种矿全部生成于**下界**，方块均为「下界岩底 + dull/ore 子材质」形态
// （见 GTOreVein 的 nether_vanadium_magnetite / nether_pyrolusite）。
//
//   nether_vanadium_magnetite_ore  主矿 → 铁 + 钒      伴生 nether_chromite_ore → 铬
//   nether_pyrolusite_ore          主矿 → 锰          伴生 nether_hausmannite_ore → 锰
//
// 阶段结构与既有 18 种矿完全一致（T1 → T1.5a/b/c/d → T2a/b → T2.3），
// 因此这里只写新增部分：
//   T1   磨粉机     矿石 → 粉 ×2            （干法，零副产）
//   T1.5 精炼厂     矿石 → 盐溶液 ×1        （酸浸）
//        流体离心   盐溶液 + 盐粉 → 碎块
//        流体离心   碎块 + 水 → 石
//        磨粉机     石 → 粉 ×3
//   T2   化反       碎块 + NaOH → 浓缩物
//        工业磨粉   浓缩物 + 水/汞/过硫酸钠 → 粉 ×5/×4/×3
//   T2.3 工业磨粉   浓缩物 + 灵魂注入催化剂 → 粉 ×6
//
// ⚠ 用**直接物品引用**而非 c:ores/* 标签：本文件(g) 早于 material_tags.zs(m) 加载。
// ============================================================

// ============================================================
// T1：干法粗处理（矿石 → 粉 ×2）
// ============================================================
// 钒磁铁矿的终产物是**钒磁铁矿粉**（不是铁粉），再由离心机分离成铁 + 钒
<recipetype:techreborn:grinder>.addJsonRecipe("general.t1.vanadium_magnetite", {type: "techreborn:grinder",
    time: 100, power: 16,
    outputs: [{id: "jsonreg:vanadium_magnetite_dust", count: 2}],
    ingredients: [{item: "jsonreg:nether_vanadium_magnetite_ore"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t1.pyrolusite", {type: "techreborn:grinder",
    time: 100, power: 16,
    outputs: [{id: "techreborn:manganese_dust", count: 2}],
    ingredients: [{item: "jsonreg:nether_pyrolusite_ore"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t1.chromite", {type: "techreborn:grinder",
    time: 100, power: 16,
    outputs: [{id: "techreborn:chrome_dust", count: 2}],
    ingredients: [{item: "jsonreg:nether_chromite_ore"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t1.hausmannite", {type: "techreborn:grinder",
    time: 100, power: 16,
    outputs: [{id: "techreborn:manganese_dust", count: 2}],
    ingredients: [{item: "jsonreg:nether_hausmannite_ore"}]
});

