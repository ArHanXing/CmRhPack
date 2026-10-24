
// === T2：工业分离与副产物 ===

// ============================================================
// T2：工业分离与副产物
// ============================================================
// 前提：**dust 是永远的最终产物** —— 中间产物与加工链条只决定一个矿石最终能产出多少粉。
// 所以 T2 不是「比 dust 更高一级的产物」，而是把产粉量从 T1.5 的 3 倍推到 5 倍。
//
//   T2a 浓缩化  TR 化反(2进2出)  X碎块 ×1 + 氢氧化钠溶液单元 → X浓缩物 ×1 + 空单元
//   T2b 高纯粉  TR 工业磨粉机     X浓缩物 + 流体 → X粉 ×N + 0~2 副产
//
// T2a 试剂用**氢氧化钠溶液**（氯碱电解：盐水单元 ×1 + 空单元 ×2 → 氯气 + 氢气 + 氢氧化钠溶液），
// 需要工业电解机，构成相对 T1.5c（只用水）的门槛；硫酸专属 T1.5a 酸浸，不再重复出现。
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
        {count: 1, components: {"techreborn:fluid": "jsonreg:sodium_hydroxide_solution"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
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
        {count: 1, components: {"techreborn:fluid": "jsonreg:sodium_hydroxide_solution"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
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
        {count: 1, components: {"techreborn:fluid": "jsonreg:sodium_hydroxide_solution"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
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
        {count: 1, components: {"techreborn:fluid": "jsonreg:sodium_hydroxide_solution"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
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
        {count: 1, components: {"techreborn:fluid": "jsonreg:sodium_hydroxide_solution"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
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
        {count: 1, components: {"techreborn:fluid": "jsonreg:sodium_hydroxide_solution"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
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
        {count: 1, components: {"techreborn:fluid": "jsonreg:sodium_hydroxide_solution"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
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
        {count: 1, components: {"techreborn:fluid": "jsonreg:sodium_hydroxide_solution"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
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
        {count: 1, components: {"techreborn:fluid": "jsonreg:sodium_hydroxide_solution"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
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
        {count: 1, components: {"techreborn:fluid": "jsonreg:sodium_hydroxide_solution"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
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
        {count: 1, components: {"techreborn:fluid": "jsonreg:sodium_hydroxide_solution"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
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
        {count: 1, components: {"techreborn:fluid": "jsonreg:sodium_hydroxide_solution"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
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
        {count: 1, components: {"techreborn:fluid": "jsonreg:sodium_hydroxide_solution"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
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
        {count: 1, components: {"techreborn:fluid": "jsonreg:sodium_hydroxide_solution"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
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
        {count: 1, components: {"techreborn:fluid": "jsonreg:sodium_hydroxide_solution"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
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
        {count: 1, components: {"techreborn:fluid": "jsonreg:sodium_hydroxide_solution"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
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
        {count: 1, components: {"techreborn:fluid": "jsonreg:sodium_hydroxide_solution"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
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
// T2：工业分离（浓缩物 → 高纯粉 + 副产）
// ============================================================
// ---------- 钒磁铁矿：铁为主，钒为副产 ----------
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("general.t2a.concentrate.vanadium_magnetite", {type: "techreborn:chemical_reactor",
    time: 400,
    power: 128,
    outputs: [
        {id: "jsonreg:vanadium_magnetite_concentrate", count: 1},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {item: "jsonreg:vanadium_magnetite_clump", count: 1},
        {count: 1, components: {"techreborn:fluid": "jsonreg:sodium_hydroxide_solution"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.water.vanadium_magnetite", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "oritech:iron_dust", count: 5}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "minecraft:water"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:vanadium_magnetite_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.mercury.vanadium_magnetite", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "oritech:iron_dust", count: 4},
        {id: "jsonreg:vanadium_dust", count: 2}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "techreborn:mercury"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:vanadium_magnetite_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.persulfate.vanadium_magnetite", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "oritech:iron_dust", count: 3},
        {id: "jsonreg:vanadium_dust", count: 2},
        {id: "techreborn:chrome_dust", count: 1}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "techreborn:sodium_persulfate"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:vanadium_magnetite_concentrate"}]
});

// ---------- 软锰矿：锰为主 ----------
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("general.t2a.concentrate.pyrolusite", {type: "techreborn:chemical_reactor",
    time: 400,
    power: 128,
    outputs: [
        {id: "jsonreg:pyrolusite_concentrate", count: 1},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {item: "jsonreg:pyrolusite_clump", count: 1},
        {count: 1, components: {"techreborn:fluid": "jsonreg:sodium_hydroxide_solution"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.water.pyrolusite", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "techreborn:manganese_dust", count: 5}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "minecraft:water"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:pyrolusite_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.mercury.pyrolusite", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "techreborn:manganese_dust", count: 4},
        {id: "oritech:iron_dust", count: 1}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "techreborn:mercury"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:pyrolusite_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.persulfate.pyrolusite", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "techreborn:manganese_dust", count: 3},
        {id: "oritech:iron_dust", count: 2},
        {id: "oritech:copper_dust", count: 1}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "techreborn:sodium_persulfate"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:pyrolusite_concentrate"}]
});

// ---------- 铬铁矿 ----------
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("general.t2a.concentrate.chromite", {type: "techreborn:chemical_reactor",
    time: 400,
    power: 128,
    outputs: [
        {id: "jsonreg:chromite_concentrate", count: 1},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {item: "jsonreg:chromite_clump", count: 1},
        {count: 1, components: {"techreborn:fluid": "jsonreg:sodium_hydroxide_solution"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.water.chromite", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "techreborn:chrome_dust", count: 5}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "minecraft:water"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:chromite_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.mercury.chromite", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "techreborn:chrome_dust", count: 4},
        {id: "oritech:iron_dust", count: 1}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "techreborn:mercury"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:chromite_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.persulfate.chromite", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "techreborn:chrome_dust", count: 3},
        {id: "oritech:iron_dust", count: 2},
        {id: "techreborn:nickel_dust", count: 1}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "techreborn:sodium_persulfate"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:chromite_concentrate"}]
});

// ---------- 硬锰矿 ----------
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("general.t2a.concentrate.hausmannite", {type: "techreborn:chemical_reactor",
    time: 400,
    power: 128,
    outputs: [
        {id: "jsonreg:hausmannite_concentrate", count: 1},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {item: "jsonreg:hausmannite_clump", count: 1},
        {count: 1, components: {"techreborn:fluid": "jsonreg:sodium_hydroxide_solution"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.water.hausmannite", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "techreborn:manganese_dust", count: 5}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "minecraft:water"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:hausmannite_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.mercury.hausmannite", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "techreborn:manganese_dust", count: 4},
        {id: "oritech:iron_dust", count: 1}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "techreborn:mercury"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:hausmannite_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.persulfate.hausmannite", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "techreborn:manganese_dust", count: 3},
        {id: "oritech:iron_dust", count: 2},
        {id: "jsonreg:tin_dust", count: 1}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "techreborn:sodium_persulfate"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:hausmannite_concentrate"}]
});

