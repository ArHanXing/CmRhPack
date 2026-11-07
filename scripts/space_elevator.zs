import crafttweaker.api.tag.MCTag;
import crafttweaker.api.recipe.type.Recipe;

// =====================================================================
// 太空电梯 —— 强化硅岩合金 / 超高强度混凝土 / 结构方块
// =====================================================================


// 一、强化硅岩合金

// --- 1. 强化批次（大化反，4 进 / 4 出）---
// 既有基体：钨粉×7 + 富集硅岩粉×2 + 镍粉×1 → 硅岩合金粉×10（t2.zs，不改）
// 强化改性：加钛（比强度）+ 铬（β稳定/抗氧化）+ 碳化硅（颗粒增强）
<recipetype:techreborn:large_chemical_reactor>.addJsonRecipe("space.reinforced_alloy.dust", {type: "techreborn:large_chemical_reactor",
    time: 1200,
    power: 256,
    outputs: [
        {id: "jsonreg:reinforced_naquadah_alloy_dust", count: 20}
    ],
    ingredients: [
        {item: "jsonreg:naquadah_alloy_dust", count: 10},
        {item: "techreborn:titanium_dust", count: 4},
        {item: "techreborn:chrome_dust", count: 3},
        {item: "jsonreg:silicon_carbide_dust", count: 3}
    ]
});

// --- 2. 热强化锭（电高炉）---
// 裸烧 5000 = 硅岩线圈上限；催化剂路线 4000 提前解锁
<recipetype:techreborn:blast_furnace>.addJsonRecipe("space.reinforced_alloy.hot_ingot", {type: "techreborn:blast_furnace",
    outputs: [
        {id: "jsonreg:hot_reinforced_naquadah_alloy_ingot", count: 1}
    ],
    time: 1200,
    heat: 5000,
    power: 256,
    ingredients: [
        {item: "jsonreg:reinforced_naquadah_alloy_dust", count: 1}
    ]
});
// 催化剂变体：2 单元灵魂注入催化剂把热量压到 4000，催化剂(cell)原样返还
<recipetype:techreborn:blast_furnace>.addJsonRecipe("space.reinforced_alloy.hot_ingot_catalyzed", {type: "techreborn:blast_furnace",
    outputs: [
        {id: "jsonreg:hot_reinforced_naquadah_alloy_ingot", count: 1},
        {id: "techreborn:cell", count: 2}
    ],
    time: 1200,
    heat: 4000,
    power: 256,
    ingredients: [
        {item: "jsonreg:reinforced_naquadah_alloy_dust", count: 1},
        {count: 2, components: {"techreborn:fluid": "jsonreg:soul_injection_catalyst"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// --- 3. 热锭 → 锭（真空冷冻机）---
<recipetype:techreborn:vacuum_freezer>.addJsonRecipe("space.reinforced_alloy.ingot", {type: "techreborn:vacuum_freezer",
    time: 400,
    power: 64,
    outputs: [
        {id: "jsonreg:reinforced_naquadah_alloy_ingot", count: 1}
    ],
    ingredients: [
        {item: "jsonreg:hot_reinforced_naquadah_alloy_ingot", count: 1}
    ]
});

// --- 4. 锭 → 板（压缩机）---
<recipetype:techreborn:compressor>.addJsonRecipe("space.reinforced_alloy.plate", {type: "techreborn:compressor",
    outputs: [
        {id: "jsonreg:reinforced_naquadah_alloy_plate", count: 1}
    ],
    time: 300,
    power: 16,
    ingredients: [
        {item: "jsonreg:reinforced_naquadah_alloy_ingot", count: 1}
    ]
});

// --- 5. 锭 → 杆（车床）---
<recipetype:techreborn:lathe>.addJsonRecipe("space.reinforced_alloy.rod", {type: "techreborn:lathe",
    time: 40,
    power: 8,
    outputs: [
        {id: "jsonreg:reinforced_naquadah_alloy_rod", count: 1}
    ],
    ingredients: [
        {item: "jsonreg:reinforced_naquadah_alloy_ingot", count: 1}
    ]
});

// --- 6. 太空电梯机械外壳（精密装配）---
// 形制对齐 multiblock_casing.zs 的既有 6 种外壳
<recipetype:techreborn:precise_assembler>.addJsonRecipe("space.elevator_casing", {type: "techreborn:precise_assembler",
    outputs: [
        {id: "techreborn:space_elevator_casing", count: 4}
    ],
    time: 400,
    power: 256,
    ingredients: [
        {count: 2, item: "jsonreg:reinforced_naquadah_alloy_plate"},
        {count: 2, item: "jsonreg:duratium_frame"}
    ]
});


// 二、超高强度混凝土 UHPC

// --- 1. 生石灰（方解石煅烧路线）---
// 依据：CaCO₃ → CaO + CO₂
// 这条是「方解石富集区」的路线；石膏煅烧路线见 t2.zs 的 gypsum_calcination（heat 1500）
<recipetype:techreborn:blast_furnace>.addJsonRecipe("space.concrete.quicklime_from_calcite", {type: "techreborn:blast_furnace",
    outputs: [
        {id: "jsonreg:calcium_oxide_slag", count: 1}
    ],
    time: 200,
    heat: 1000,
    power: 64,
    ingredients: [
        {item: "techreborn:calcite_dust", count: 2}
    ]
});

// --- 2. 水泥熟料（高温烧结）---
// 依据：真实熟料 CaO 65% / SiO₂ 21% / Al₂O₃ 6%，矿物相 C₃S + C₂S + C₃A
<recipetype:techreborn:blast_furnace>.addJsonRecipe("space.concrete.clinker", {type: "techreborn:blast_furnace",
    outputs: [
        {id: "jsonreg:cement_clinker", count: 5}
    ],
    time: 400,
    heat: 1500,
    power: 128,
    ingredients: [
        {item: "jsonreg:calcium_oxide_slag", count: 3},
        {item: "techreborn:quartz_dust", count: 1},
        {item: "techreborn:aluminum_dust", count: 1}
    ]
});

// --- 3. 水泥（熟料掺石膏，约 5% 调凝）---
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("space.concrete.cement", {type: "techreborn:chemical_reactor",
    time: 400,
    power: 128,
    outputs: [
        {id: "jsonreg:cement", count: 20}
    ],
    ingredients: [
        {item: "jsonreg:cement_clinker", count: 19},
        {item: "jsonreg:calcium_sulfate_dust", count: 1}
    ]
});

// --- 4. 钢纤维（钢板冷拔切断）---
<recipetype:techreborn:lathe>.addJsonRecipe("space.concrete.steel_fiber", {type: "techreborn:lathe",
    time: 40,
    power: 8,
    outputs: [
        {id: "jsonreg:steel_fiber", count: 4}
    ],
    ingredients: [
        {item: "techreborn:steel_plate", count: 1}
    ]
});

// --- 5. UHPC 拌合料（大化反）---
// 依据：极低水胶比 —— 1 单元水对 13 份胶凝料，远低于普通混凝土的约 0.5
<recipetype:techreborn:large_chemical_reactor>.addJsonRecipe("space.concrete.uhpc", {type: "techreborn:large_chemical_reactor",
    time: 600,
    power: 128,
    outputs: [
        {id: "jsonreg:uhpc", count: 13},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {item: "jsonreg:cement", count: 10},
        {item: "techreborn:quartz_dust", count: 2},
        {item: "jsonreg:steel_fiber", count: 1},
        {count: 1, components: {"techreborn:fluid": "minecraft:water"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// --- 6. 蒸汽养护（OR 流体离心 + 蒸汽）---
// 依据：真实 UHPC 必须约 90℃ 蒸汽养护才能达到最终强度，否则只到 60% 左右
// 重跑 gen_large_machine_compat.py 后会自动镜像出 large_mixer 入口
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("space.concrete.steam_curing", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:structure_concrete", count: 1}],
    time: 200,
    fluidInput: {fluid: "oritech:still_steam", amount: 81000},
    ingredients: [{item: "jsonreg:uhpc", count: 1}]
});

// --- 7. 承压支撑混凝土（高钢纤维掺量 + 钨钢增强）---
<recipetype:techreborn:precise_assembler>.addJsonRecipe("space.concrete.support", {type: "techreborn:precise_assembler",
    outputs: [
        {id: "jsonreg:space_elevator_support_concrete", count: 4}
    ],
    time: 400,
    power: 128,
    ingredients: [
        {count: 4, item: "jsonreg:structure_concrete"},
        {count: 8, item: "jsonreg:steel_fiber"},
        {count: 2, item: "techreborn:tungstensteel_plate"}
    ]
});

// --- 8. 内部结构混凝土（轻量、铝质骨料）---
<recipetype:techreborn:precise_assembler>.addJsonRecipe("space.concrete.internal", {type: "techreborn:precise_assembler",
    outputs: [
        {id: "jsonreg:space_elevator_internal_concrete", count: 4}
    ],
    time: 400,
    power: 128,
    ingredients: [
        {count: 4, item: "jsonreg:structure_concrete"},
        {count: 2, item: "techreborn:aluminum_plate"}
    ]
});


// 三、太空电梯功能方块 

<recipetype:avaritia:extreme_crafting>.addJsonRecipe("space.elevator.main",
{type: "avaritia:extreme_shaped", result: {id: "techreborn:space_elevator", count: 1}, pattern: [
    "    B    ",
    "   BBB   ",
    "   BCB   ",
    "  BIIIB  ",
    "  BIHIB  ",
    " BGDHDGB ",
    " BGDEDGB ",
    "BFFDEDFFB",
    "BFFBABFFB"],
 key: {
    A: {item: "techreborn:elevator"},
    B: {item: "techreborn:space_elevator_casing"},
    C: {item: "jsonreg:gravi_star"},
    D: {item: "jsonreg:hv_electric_motor"},
    E: {item: "techreborn:computer_cube"},
    F: {item: "techreborn:universal_chemical_fuel_engine"},
    G: {item: "techreborn:large_compressor"},
    H: {item: "oritech:advanced_computing_engine"},
    I: {item: "jsonreg:naquadah_frame"}
}});

// --- 2. 动力模块（精密装配）---
<recipetype:techreborn:precise_assembler>.addJsonRecipe("space.elevator.power_module", {type: "techreborn:precise_assembler",
    outputs: [
        {id: "techreborn:space_elevator_power_module", count: 1}
    ],
    time: 200,
    power: 256,
    ingredients: [
        {count: 1, item: "techreborn:space_elevator_casing"},
        {count: 2, item: "jsonreg:naquadah_alloy_plate"},
        {count: 2, item: "jsonreg:hv_electric_motor"}
    ]
});

// --- 3. 组装机（精密装配）---
<recipetype:techreborn:precise_assembler>.addJsonRecipe("space.elevator.assembler", {type: "techreborn:precise_assembler",
    outputs: [
        {id: "techreborn:space_elevator_assembler", count: 1}
    ],
    time: 600,
    power: 256,
    ingredients: [
        {count: 4, item: "techreborn:space_elevator_casing"},
        {count: 2, item: "oritech:advanced_computing_engine"},
        {count: 4, item: "jsonreg:hv_robot_arm"},
        {count: 2, item: "techreborn:precise_assembler"}
    ]
});

// --- 4. 采矿机（精密装配）---
<recipetype:techreborn:precise_assembler>.addJsonRecipe("space.elevator.miner", {type: "techreborn:precise_assembler",
    outputs: [
        {id: "techreborn:space_elevator_miner", count: 1}
    ],
    time: 600,
    power: 256,
    ingredients: [
        {count: 4, item: "techreborn:space_elevator_casing"},
        {count: 2, item: "oritech:advanced_computing_engine"},
        {count: 4, item: "jsonreg:hv_robot_arm"},
        {count: 2, item: "techreborn:void_drill"}
    ]
});

