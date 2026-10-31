import crafttweaker.api.tag.MCTag;
import crafttweaker.api.recipe.type.Recipe;

// =====================================================================
// 火箭燃料线 —— 五种预混推进剂 + F-1A 火箭引擎
// =====================================================================
// 设计要点：
//   1. 燃料是**单一流体**（GT 风格预混推进剂），因为 TR 的
//      FluidGeneratorRecipe 只有 `fluid` 一个字段，物理上无法双流体共燃。
//      所以「偏二甲肼 + 四氧化二氮」在化反里预混成一种燃料再烧。
//   2. 烧燃料用 **techreborn:rocketdyne_engine** 这个独立配方类型
//      （ModRecipes.ROCKETDYNE_ENGINE），UCFE / 大型内燃机 / 燃气机
//      **都不吃**这个类型 —— 天然隔离，不会污染既有发电体系。
//   3. 引擎本体是 TR 内置多方块 `techreborn:rocketdyne_f1a_engine`
//      （3×3×6，44 工业机壳 + 8 高级机壳），无需新建方块。
//
// 氧气说明：包内 `techreborn:compressed_air` 的中文已被改为「气态氧」
//   （languageadd 里 block/fluid.techreborn.compressed_air = 气态氧），
//   真实配方里它就是当氧气用的（35 条配方），所以液氧 = 气态氧深冷。
//
// 功率梯度（相对硝基煤油 364）：
//   RP-1/LOx      400   （开式煤油机，门槛最低）
//   甲烷/LOx       550   （燃气发生器循环）
//   MMH/N2O4       700   （常温可储，化工重头）
//   UDMH/N2O4      850   （N-甲基化，比 MMH 多一步）
//   液氢/LOx      1200   （最高比冲，深冷要求最苛刻）
//
// F-1A 引擎参数（jar 默认，未改动）：MaxOutput 8192 / EnergyPerTick 8192
//   → 1200 power 完全在范围内，且 UCFE（4096）吃不到这些配方。
// =====================================================================


// =====================================================================
// 一、低温中间体（深冷：OR 流体离心机，纯流体转换）
// =====================================================================
// 依据：真实工业上氧/氮/氢/甲烷的液化都是「压缩 + 深冷」，本包用
// OR 流体离心机代表深冷单元（它支持 fluidInput → fluidOutputs，
// 且 ingredients 可为空，见 bio.sep.ethanol 的先例）。

// 液氧：气态氧 → 液氧（−183°C）
// 用 TR 真空冷冻机的「单元组件」形式（TR 原生就有 heliumplasma 单元 → helium 单元的先例），
// 耗时给足，体现深冷是这个门类最贵的环节。
<recipetype:techreborn:vacuum_freezer>.addJsonRecipe("rocket.cryo.liquid_oxygen", {type: "techreborn:vacuum_freezer",
    time: 1200,
    power: 128,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:liquid_oxygen"}}
    ],
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "techreborn:compressed_air"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// 液氢：氢气 → 液氢（−253°C，全系列最低温，耗时最长）
<recipetype:techreborn:vacuum_freezer>.addJsonRecipe("rocket.cryo.liquid_hydrogen", {type: "techreborn:vacuum_freezer",
    time: 1800,
    power: 128,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:liquid_hydrogen"}}
    ],
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "techreborn:hydrogen"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// 液态甲烷：甲烷 → 液态甲烷（−162°C，三者中最容易液化）
<recipetype:techreborn:vacuum_freezer>.addJsonRecipe("rocket.cryo.liquid_methane", {type: "techreborn:vacuum_freezer",
    time: 1000,
    power: 128,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:liquid_methane"}}
    ],
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "techreborn:methane"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});


// =====================================================================
// 二、精炼煤油 RP-1
// =====================================================================
// 依据：真实 RP-1 是石油直馏的 180~280°C 馏分，经脱硫/精制得到。
// 本包用「重柴油 →(真空精馏) 精炼煤油」表示（重柴油正是该沸程馏分）。
// 用 oritech:refinery（本包既有的真空蒸馏机，见 oil.process.or.vacuum_distillation），
// 单流体输出的 refinery 配方在包内已有 5 条先例。
<recipetype:oritech:refinery>.addJsonRecipe("rocket.refine.kerosene", {type: "oritech:refinery",
    results: [],
    fluidOutputs: [
        {fluid: "jsonreg:refined_kerosene", amount: 81000}
    ],
    time: 300,
    fluidInput: {fluid: "jsonreg:heavy_diesel", amount: 81000},
    ingredients: []
});


// =====================================================================
// 三、甲醇 / 甲醛 / 一氧化碳（肼类上游）
// =====================================================================
// 一氧化碳：碳 + 氧 → CO（真实为碳不完全燃烧/水煤气）
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("rocket.chem.carbon_monoxide", {type: "techreborn:chemical_reactor",
    time: 200,
    power: 30,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:carbon_monoxide"}},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "techreborn:carbon"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 1, components: {"techreborn:fluid": "techreborn:compressed_air"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// 甲醇：CO + 2H₂ → CH₃OH（真实工业甲醇合成的铜基催化路线）
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("rocket.chem.methanol", {type: "techreborn:chemical_reactor",
    time: 200,
    power: 30,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:methanol"}},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:carbon_monoxide"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 1, components: {"techreborn:fluid": "techreborn:hydrogen"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// 甲醛：甲醇 + 氧 → HCHO（真实为银/铁钼催化氧化）
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("rocket.chem.formaldehyde", {type: "techreborn:chemical_reactor",
    time: 200,
    power: 30,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:formaldehyde"}},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:methanol"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 1, components: {"techreborn:fluid": "techreborn:compressed_air"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});


// =====================================================================
// 四、四氧化二氮 N₂O₄（氧化剂）
// =====================================================================
// 依据：2NO₂ ⇌ N₂O₄，低温加压即二聚。本包已有 nitrogen_dioxide，
// 所以只需一步「深冷二聚」。
<recipetype:techreborn:vacuum_freezer>.addJsonRecipe("rocket.chem.n2o4", {type: "techreborn:vacuum_freezer",
    time: 1200,
    power: 128,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:dinitrogen_tetroxide"}}
    ],
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "techreborn:nitrogen_dioxide"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});


// =====================================================================
// 五、肼类（MMH / UDMH）
// =====================================================================
// MMH：NH₃ + CH₃OH + HCHO → MMH + H₂O
//   真实工业路线经亚甲胺中间体，本包按三步并一步（LCR 3 进）。
<recipetype:techreborn:large_chemical_reactor>.addJsonRecipe("rocket.hydrazine.mmh", {type: "techreborn:large_chemical_reactor",
    time: 400,
    power: 128,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:monomethylhydrazine"}},
        {id: "techreborn:cell", count: 2}
    ],
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:ammonia"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 1, components: {"techreborn:fluid": "jsonreg:methanol"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 1, components: {"techreborn:fluid": "jsonreg:formaldehyde"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// UDMH：MMH + CH₃OH → UDMH + H₂O（N-甲基化）
//   真实路线经亚硝基二甲胺还原，本包简化为一步甲基化。
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("rocket.hydrazine.udmh", {type: "techreborn:chemical_reactor",
    time: 300,
    power: 64,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:unsymmetrical_dimethylhydrazine"}},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:monomethylhydrazine"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 1, components: {"techreborn:fluid": "jsonreg:methanol"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});


// =====================================================================
// 六、预混火箭燃料（GT 风格单流体）
// =====================================================================
// 双组元推进剂在化反里预混成**一种**燃料，绕开引擎单流体限制。
// 混合比参考真实：
//   RP-1/LOx     约 2.3:1（富燃）
//   甲烷/LOx     约 3.6:1（富燃）
//   液氢/LOx     约 6:1
//   MMH/N2O4 与 UDMH/N2O4  约 2:1
// 游戏里统一简化为 1:1 体积比，靠 time/power 与上游成本区分。

// RP-1/液氧
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("rocket.fuel.rp1", {type: "techreborn:chemical_reactor",
    time: 200,
    power: 64,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:rocket_fuel_rp1"}},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:refined_kerosene"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 1, components: {"techreborn:fluid": "jsonreg:liquid_oxygen"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// 甲烷/液氧
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("rocket.fuel.methane", {type: "techreborn:chemical_reactor",
    time: 200,
    power: 64,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:rocket_fuel_methane"}},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:liquid_methane"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 1, components: {"techreborn:fluid": "jsonreg:liquid_oxygen"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// 甲基肼/四氧化二氮
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("rocket.fuel.mmh", {type: "techreborn:chemical_reactor",
    time: 200,
    power: 64,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:rocket_fuel_mmh"}},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:monomethylhydrazine"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 1, components: {"techreborn:fluid": "jsonreg:dinitrogen_tetroxide"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// 偏二甲肼/四氧化二氮
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("rocket.fuel.udmh", {type: "techreborn:chemical_reactor",
    time: 200,
    power: 64,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:rocket_fuel_udmh"}},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:unsymmetrical_dimethylhydrazine"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 1, components: {"techreborn:fluid": "jsonreg:dinitrogen_tetroxide"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// 液氢/液氧
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("rocket.fuel.lh2", {type: "techreborn:chemical_reactor",
    time: 200,
    power: 64,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:rocket_fuel_lh2"}},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:liquid_hydrogen"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 1, components: {"techreborn:fluid": "jsonreg:liquid_oxygen"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});


// =====================================================================
// 七、F-1A 火箭引擎燃烧配方
// =====================================================================
// 用 techreborn:rocketdyne_engine —— **UCFE / 大型内燃机 / 燃气机都不吃**，
// 只有 rocketdyne_f1a_engine 多方块能烧，实现燃料体系隔离。
// power 即每桶能量 ÷ 1000（FluidGeneratorRecipe 语义）。
// 注意：TR 原本有一条 hydrogen.json（power 60），是占位符，这里不覆盖，
//   但氢气本身不再作为火箭燃料 —— 只有预混燃料能驱动 F-1A。

// RP-1/液氧  —— 开式煤油机
<recipetype:techreborn:rocketdyne_engine>.addJsonRecipe("rocket.burn.rp1", {type: "techreborn:rocketdyne_engine",
    fluid: "jsonreg:rocket_fuel_rp1",
    power: 400
});

// 甲烷/液氧
<recipetype:techreborn:rocketdyne_engine>.addJsonRecipe("rocket.burn.methane", {type: "techreborn:rocketdyne_engine",
    fluid: "jsonreg:rocket_fuel_methane",
    power: 550
});

// 甲基肼/四氧化二氮
<recipetype:techreborn:rocketdyne_engine>.addJsonRecipe("rocket.burn.mmh", {type: "techreborn:rocketdyne_engine",
    fluid: "jsonreg:rocket_fuel_mmh",
    power: 700
});

// 偏二甲肼/四氧化二氮
<recipetype:techreborn:rocketdyne_engine>.addJsonRecipe("rocket.burn.udmh", {type: "techreborn:rocketdyne_engine",
    fluid: "jsonreg:rocket_fuel_udmh",
    power: 850
});

// 液氢/液氧  —— 最高比冲
<recipetype:techreborn:rocketdyne_engine>.addJsonRecipe("rocket.burn.lh2", {type: "techreborn:rocketdyne_engine",
    fluid: "jsonreg:rocket_fuel_lh2",
    power: 1200
});
