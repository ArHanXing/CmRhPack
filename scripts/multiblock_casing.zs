import crafttweaker.api.tag.MCTag;
import crafttweaker.api.recipe.type.Recipe;

//TODO
<recipetype:techreborn:precise_assembler>.addJsonRecipe("mbcasing.stress_proof_casing", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "jsonreg:stress_proof_casing", count: 8}
    ],
    time: 400, power: 128,
    ingredients: [
        {count: 8, item:"techreborn:steel_plate"},
        {count: 2, item:"techreborn:advanced_machine_casing"},
        {count: 1, item:"techreborn:iridium_plate"}
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("mbcasing.vibration_safe_casing", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "jsonreg:vibration_safe_casing", count: 2}
    ],
    time: 400, power: 128,
    ingredients: [
        {count: 4, item:"techreborn:advanced_alloy_plate"},
        {count: 4, item:"jsonreg:titanium_frame"},
        {count: 2, item:"techreborn:advanced_machine_casing"}
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("mbcasing.reaction_safe_mixing_casing", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "jsonreg:reaction_safe_mixing_casing", count: 2}
    ],
    time: 400, power: 128,
    ingredients: [
        {count: 4, item:"jsonreg:tetrafluoroethylene_plate"},
        {count: 2, item:"jsonreg:vibration_safe_casing"},
        {count: 2, item:"jsonreg:aluminum_frame"}
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("mbcasing.turbine_titanium", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "jsonreg:machine_casing_turbine_titanium", count: 1}
    ],
    time: 100, power: 128,
    ingredients: [
        {count: 4, item:"techreborn:titanium_plate"},
        {count: 2, item:"jsonreg:steel_frame"}
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("mbcasing.robust_tungstensteel", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "jsonreg:machine_casing_robust_tungstensteel", count: 1}
    ],
    time: 100, power: 128,
    ingredients: [
        {count: 2, item:"jsonreg:steel_frame"},
        {count: 4, item:"techreborn:tungstensteel_plate"}
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("mbcasing.large_scale_assembling_casing", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "jsonreg:large_scale_assembling_casing", count: 4}
    ],
    time: 100, power: 128,
    ingredients: [
        {count: 4, item:"techreborn:aluminum_plate"},
        {count: 1, item:"techreborn:advanced_machine_frame"}
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("mbcasing.reinforced_glass", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "jsonreg:reinforced_glass", count: 4}
    ],
    time: 200, power: 128,
    ingredients: [
        {count: 4, item:"oritech:industrial_glass_block"},
        {count: 2, item:"jsonreg:titanium_rod"}
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("mbcasing.gearbox_steel", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "jsonreg:machine_casing_gearbox_steel", count: 2}
    ],
    time: 200, power: 128,
    ingredients: [
        {count: 4, item:"immersive_aircraft:industrial_gears"},
        {count: 2, item:"jsonreg:steel_frame"},
        {count: 4, item:"techreborn:steel_plate"}
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("mbcasing.pipe_steel", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "jsonreg:machine_casing_pipe_steel", count: 2}
    ],
    time: 200, power: 128,
    ingredients: [
        {count: 4, item:"immersive_aircraft:sturdy_pipes"},
        {count: 2, item:"jsonreg:steel_frame"},
        {count: 4, item:"techreborn:steel_plate"}
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("mbcasing.pipe_tungstensteel", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "jsonreg:machine_casing_pipe_tungstensteel", count: 2}
    ],
    time: 200, power: 128,
    ingredients: [
        {count: 4, item:"immersive_aircraft:sturdy_pipes"},
        {count: 2, item:"jsonreg:steel_frame"},
        {count: 4, item:"techreborn:tungstensteel_plate"}
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("mbcasing.electrolytic_cell", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "jsonreg:electrolytic_cell", count: 2}
    ],
    time: 200, power: 128,
    ingredients: [
        {count: 2, item:"jsonreg:reaction_safe_mixing_casing"},
        {count: 4, item:"techreborn:copper_plate"},
        {count: 4, item:"techreborn:iron_plate"}
    ]
});
//泰拉钢外壳
<recipetype:techreborn:precise_assembler>.addJsonRecipe("magic.tr.assembly/terrasteel_casing", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "jsonreg:terrasteel_casing", count: 4}
    ],
    time: 300, power: 256,
    ingredients: [
        {count: 2, item:"botania:terrasteel_ingot"},
        {count: 1, item:"jsonreg:steel_frame"},
        {count: 2, item:"affinity:crystalline_wisp_matter_composite"}
    ]
});
/* 核反应堆 */
<recipetype:oritech:assembler>.removeByName("oritech:assembler/reactorplatingalt");
<recipetype:techreborn:precise_assembler>.addJsonRecipe("mbcasing.reactor", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "oritech:reactor_controller", count: 1}
    ],
    time: 2000, power: 128,
    ingredients: [
        {count: 16, item:"oritech:advanced_computing_engine"},
        {count: 4, item:"jsonreg:duratium_frame"},
        {count: 64, item:"techreborn:lead_plate"},
        {count: 64, item:"techreborn:lead_plate"},
        {count: 64, item:"techreborn:steel_plate"},
        {count: 16, item:"jsonreg:mv_robot_arm"},
        {count: 16, item:"jsonreg:mv_sensor"},
        {count: 32, item:"eternal_starlight:frozen_tube"},
        {count: 4, item:"techreborn:computer_cube"},
        {count: 2, item:"techreborn:universal_chemical_fuel_engine"}
    ]
});
<recipetype:techreborn:precise_assembler>.addJsonRecipe("mbcasing.reactor.wall/depleted_uranium_better", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "oritech:reactor_wall", count: 4}
    ],
    time: 100, power: 128,
    ingredients: [
        {count: 2, item:"oritech:advanced_computing_engine"},
        {count: 1, item:"jsonreg:duratium_frame"},
        {count: 1, item:"jsonreg:depleted_uranium_dense_plate"}
    ]
});
