
// === T2.3：魔法催化（灵魂注入催化剂）===

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

// ============================================================
// T2.3：魔法催化（灵魂注入催化剂，×6）
// ============================================================
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t23.catalyzed.vanadium_magnetite", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "jsonreg:vanadium_magnetite_dust", count: 6},
        {id: "techreborn:chrome_dust", count: 1}
    ],
    time: 200,
    power: 256,
    fluid: {fluid: {fluid: "jsonreg:soul_injection_catalyst"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:vanadium_magnetite_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t23.catalyzed.pyrolusite", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "techreborn:manganese_dust", count: 6},
        {id: "oritech:iron_dust", count: 2}
    ],
    time: 200,
    power: 256,
    fluid: {fluid: {fluid: "jsonreg:soul_injection_catalyst"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:pyrolusite_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t23.catalyzed.chromite", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "techreborn:chrome_dust", count: 6},
        {id: "oritech:iron_dust", count: 2}
    ],
    time: 200,
    power: 256,
    fluid: {fluid: {fluid: "jsonreg:soul_injection_catalyst"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:chromite_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t23.catalyzed.hausmannite", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "techreborn:manganese_dust", count: 6},
        {id: "oritech:iron_dust", count: 2}
    ],
    time: 200,
    power: 256,
    fluid: {fluid: {fluid: "jsonreg:soul_injection_catalyst"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:hausmannite_concentrate"}]
});

// ============================================================
// 【补齐】氟石 T2 / T2.3
// ============================================================

// ---------- T2a：碎块 + 氢氧化钠 → 浓缩物 ----------
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("general.t2a.concentrate.fluorite", {type: "techreborn:chemical_reactor",
    time: 400,
    power: 128,
    outputs: [
        {id: "jsonreg:fluorite_concentrate", count: 1},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {item: "jsonreg:fluorite_clump", count: 1},
        {count: 1, components: {"techreborn:fluid": "jsonreg:sodium_hydroxide_solution"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// ---------- T2b：三条互斥支路 ----------
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.water.fluorite", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "jsonreg:fluorite_dust", count: 5}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "minecraft:water"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:fluorite_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.mercury.fluorite", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "jsonreg:fluorite_dust", count: 4},
        {id: "jsonreg:salt_dust", count: 1}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "techreborn:mercury"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:fluorite_concentrate"}]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.persulfate.fluorite", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "jsonreg:fluorite_dust", count: 3},
        {id: "jsonreg:salt_dust", count: 1},
        {id: "jsonreg:rock_salt_dust", count: 1}
    ],
    time: 200,
    power: 128,
    fluid: {fluid: {fluid: "techreborn:sodium_persulfate"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:fluorite_concentrate"}]
});

// ---------- T2.3：灵魂注入催化剂（×6）----------
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t23.catalyzed.fluorite", {type: "techreborn:industrial_grinder",
    outputs: [
        {id: "jsonreg:fluorite_dust", count: 6},
        {id: "jsonreg:salt_dust", count: 1},
        {id: "jsonreg:rock_salt_dust", count: 1}
    ],
    time: 200,
    power: 256,
    fluid: {fluid: {fluid: "jsonreg:soul_injection_catalyst"}, amount: {value: 81000}},
    ingredients: [{item: "jsonreg:fluorite_concentrate"}]
});
