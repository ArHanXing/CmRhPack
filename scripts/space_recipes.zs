import crafttweaker.api.recipe.type.Recipe;

// =====================================================================
// T1 太空计划 —— 航天器制造与注油（CraftTweaker 层）
// =====================================================================

<recipetype:techreborn:space_elevator_assembler>.removeByName("techreborn:space_elevator_assembler/test");
<recipetype:techreborn:space_elevator_miner>.removeByName("techreborn:space_elevator_miner/test");

// 太空无人机 MK1 —— 采矿主力。钻头 + 双 HV 马达 + 钛框架
<recipetype:techreborn:space_elevator_assembler>.addJsonRecipe("cmrh.space.t1.drone", {type: "techreborn:space_elevator_assembler",
    time: 1200,
    power: 512,
    outputs: [
        {id: "techreborn:space_drone_mk1", count: 1}
    ],
    ingredients: [
        {count: 2, item: "jsonreg:titanium_frame"},
        {count: 1, item: "techreborn:advanced_drill"},
        {count: 2, item: "jsonreg:hv_electric_motor"},
        {count: 4, item: "techreborn:advanced_circuit"}
    ]
});

// 测绘探测器 MK1 —— 传感 + 发射 + 钛板
<recipetype:techreborn:space_elevator_assembler>.addJsonRecipe("cmrh.space.t1.probe", {type: "techreborn:space_elevator_assembler",
    time: 600,
    power: 512,
    outputs: [
        {id: "techreborn:space_probe_mk1", count: 1}
    ],
    ingredients: [
        {count: 8, item: "techreborn:titanium_plate"},
        {count: 4, item: "jsonreg:mv_sensor"},
        {count: 2, item: "jsonreg:mv_emitter"},
        {count: 4, item: "techreborn:advanced_circuit"}
    ]
});

// 登陆舱 MK1 —— 结构 + 四台 HV 马达
<recipetype:techreborn:space_elevator_assembler>.addJsonRecipe("cmrh.space.t1.lander", {type: "techreborn:space_elevator_assembler",
    time: 1800,
    power: 512,
    outputs: [
        {id: "techreborn:space_lander_mk1", count: 1}
    ],
    ingredients: [
        {count: 4, item: "jsonreg:titanium_frame"},
        {count: 16, item: "techreborn:titanium_plate"},
        {count: 4, item: "jsonreg:hv_electric_motor"},
        {count: 8, item: "techreborn:advanced_circuit"}
    ]
});

// 据点核心 MK1 —— 计算 + 结构，建据点时消耗
<recipetype:techreborn:space_elevator_assembler>.addJsonRecipe("cmrh.space.t1.core", {type: "techreborn:space_elevator_assembler",
    time: 2400,
    power: 512,
    outputs: [
        {id: "techreborn:core_mk1", count: 1}
    ],
    ingredients: [
        {count: 4, item: "jsonreg:titanium_frame"},
        {count: 16, item: "techreborn:titanium_plate"},
        {count: 16, item: "techreborn:advanced_circuit"},
        {count: 4, item: "oritech:advanced_computing_engine"}
    ]
});


// 二、注油（精密组装机，512 EU/t / 100 tick）

// --- 无人机 ---
<recipetype:techreborn:precise_assembler>.addJsonRecipe("cmrh.space.t1.drone.rp1", {type: "techreborn:precise_assembler",
    time: 100,
    power: 512,
    outputs: [
        {id: "techreborn:space_drone_mk1_powered", count: 1},
        {id: "techreborn:cell", count: 4, components: {"techreborn:fluid": "minecraft:empty"}}
    ],
    ingredients: [
        {count: 1, item: "techreborn:space_drone_mk1"},
        {count: 4, components: {"techreborn:fluid": "jsonreg:rocket_fuel_rp1"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});
<recipetype:techreborn:precise_assembler>.addJsonRecipe("cmrh.space.t1.drone.methane", {type: "techreborn:precise_assembler",
    time: 100,
    power: 512,
    outputs: [
        {id: "techreborn:space_drone_mk1_powered", count: 1},
        {id: "techreborn:cell", count: 2, components: {"techreborn:fluid": "minecraft:empty"}}
    ],
    ingredients: [
        {count: 1, item: "techreborn:space_drone_mk1"},
        {count: 2, components: {"techreborn:fluid": "jsonreg:rocket_fuel_methane"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// --- 探测器 ---
<recipetype:techreborn:precise_assembler>.addJsonRecipe("cmrh.space.t1.probe.rp1", {type: "techreborn:precise_assembler",
    time: 100,
    power: 512,
    outputs: [
        {id: "techreborn:space_probe_mk1_powered", count: 1},
        {id: "techreborn:cell", count: 4, components: {"techreborn:fluid": "minecraft:empty"}}
    ],
    ingredients: [
        {count: 1, item: "techreborn:space_probe_mk1"},
        {count: 4, components: {"techreborn:fluid": "jsonreg:rocket_fuel_rp1"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});
<recipetype:techreborn:precise_assembler>.addJsonRecipe("cmrh.space.t1.probe.methane", {type: "techreborn:precise_assembler",
    time: 100,
    power: 512,
    outputs: [
        {id: "techreborn:space_probe_mk1_powered", count: 1},
        {id: "techreborn:cell", count: 2, components: {"techreborn:fluid": "minecraft:empty"}}
    ],
    ingredients: [
        {count: 1, item: "techreborn:space_probe_mk1"},
        {count: 2, components: {"techreborn:fluid": "jsonreg:rocket_fuel_methane"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// --- 登陆舱 ---
<recipetype:techreborn:precise_assembler>.addJsonRecipe("cmrh.space.t1.lander.rp1", {type: "techreborn:precise_assembler",
    time: 100,
    power: 512,
    outputs: [
        {id: "techreborn:space_lander_mk1_powered", count: 1},
        {id: "techreborn:cell", count: 4, components: {"techreborn:fluid": "minecraft:empty"}}
    ],
    ingredients: [
        {count: 1, item: "techreborn:space_lander_mk1"},
        {count: 4, components: {"techreborn:fluid": "jsonreg:rocket_fuel_rp1"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});
<recipetype:techreborn:precise_assembler>.addJsonRecipe("cmrh.space.t1.lander.methane", {type: "techreborn:precise_assembler",
    time: 100,
    power: 512,
    outputs: [
        {id: "techreborn:space_lander_mk1_powered", count: 1},
        {id: "techreborn:cell", count: 2, components: {"techreborn:fluid": "minecraft:empty"}}
    ],
    ingredients: [
        {count: 1, item: "techreborn:space_lander_mk1"},
        {count: 2, components: {"techreborn:fluid": "jsonreg:rocket_fuel_methane"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});
