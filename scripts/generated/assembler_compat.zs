// ============================================================
// 【自动生成 · 请勿手改】
// 由 scripts/tools/gen_assembler_compat.py 生成。
//
// 把 Oritech 装配机（oritech:assembler）配方逐条复制为 TR 精密组装机配方，
// 使 EMI 里两台机器都能直接看到配方，并统一 0.8× 耗时。
//
// 转换规则：results→outputs、type→techreborn:precise_assembler、
//           time = round(OR time × 0.8)（缺省按 OR 默认 60 ⇒ 48）、power = 128
// 来源：Oritech jar 的 data/oritech/recipe/assembler/*.json（不是过期 recipedump）
// 跳过：包内已 removeByName("oritech:assembler/<name>") 的条目
// ============================================================

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.oritech.assembler/amethystbud", {type: "techreborn:precise_assembler",
    outputs: [
        {id: "minecraft:budding_amethyst", count: 1},
    ],
    time: 128, power: 128,
    ingredients: [
        {tag: "c:gems/amethyst"},
        {tag: "c:gems/amethyst"},
        {item: "oritech:enderic_compound"},
        {item: "oritech:overcharged_crystal"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.oritech.assembler/battery", {type: "techreborn:precise_assembler",
    outputs: [
        {id: "oritech:basic_battery", count: 1},
    ],
    time: 38, power: 128,
    ingredients: [
        {tag: "c:plates/plastic"},
        {tag: "c:ingots/electrum"},
        {tag: "c:ingots/electrum"},
        {tag: "c:ingots/steel"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.oritech.assembler/batterybetter", {type: "techreborn:precise_assembler",
    outputs: [
        {id: "oritech:basic_battery", count: 2},
    ],
    time: 77, power: 128,
    ingredients: [
        {tag: "c:plates/plastic"},
        {item: "oritech:fluxite"},
        {item: "oritech:fluxite"},
        {tag: "c:ingots/steel"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.oritech.assembler/blazerod", {type: "techreborn:precise_assembler",
    outputs: [
        {id: "minecraft:blaze_rod", count: 1},
    ],
    time: 77, power: 128,
    ingredients: [
        {item: "minecraft:blaze_powder"},
        {item: "minecraft:blaze_powder"},
        {item: "minecraft:blaze_powder"},
        {item: "minecraft:blaze_powder"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.oritech.assembler/book", {type: "techreborn:precise_assembler",
    outputs: [
        {id: "minecraft:book", count: 2},
    ],
    time: 77, power: 128,
    ingredients: [
        {item: "minecraft:paper"},
        {item: "minecraft:paper"},
        {item: "minecraft:paper"},
        {tag: "c:leathers"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.oritech.assembler/claybeads", {type: "techreborn:precise_assembler",
    outputs: [
        {id: "oritech:clay_catalyst_beads", count: 32},
    ],
    time: 96, power: 128,
    ingredients: [
        {item: "minecraft:clay_ball"},
        {item: "minecraft:clay_ball"},
        {tag: "minecraft:sand"},
        {item: "minecraft:redstone"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.oritech.assembler/enderlens", {type: "techreborn:precise_assembler",
    outputs: [
        {id: "oritech:enderic_lens", count: 1},
    ],
    time: 115, power: 128,
    ingredients: [
        {item: "oritech:adamant_ingot"},
        {tag: "c:carbon_fibre"},
        {item: "oritech:enderic_compound"},
        {item: "oritech:enderic_compound"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.oritech.assembler/fireball", {type: "techreborn:precise_assembler",
    outputs: [
        {id: "minecraft:fire_charge", count: 4},
    ],
    time: 77, power: 128,
    ingredients: [
        {item: "minecraft:gunpowder"},
        {item: "minecraft:blaze_powder"},
        {tag: "minecraft:coals"},
        {tag: "minecraft:coals"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.oritech.assembler/fluxgate", {type: "techreborn:precise_assembler",
    outputs: [
        {id: "oritech:flux_gate", count: 1},
    ],
    time: 115, power: 128,
    ingredients: [
        {item: "oritech:processing_unit"},
        {item: "oritech:fluxite"},
        {item: "oritech:fluxite"},
        {tag: "c:ingots/platinum"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.oritech.assembler/ionthruster", {type: "techreborn:precise_assembler",
    outputs: [
        {id: "oritech:ion_thruster", count: 2},
    ],
    time: 192, power: 128,
    ingredients: [
        {item: "oritech:reinforced_carbon_sheet"},
        {item: "oritech:reinforced_carbon_sheet"},
        {item: "oritech:advanced_battery"},
        {item: "oritech:flux_gate"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.oritech.assembler/plating", {type: "techreborn:precise_assembler",
    outputs: [
        {id: "oritech:machine_plating_block", count: 8},
    ],
    time: 77, power: 128,
    ingredients: [
        {tag: "c:ingots/steel"},
        {tag: "c:ingots/steel"},
        {tag: "c:ingots/copper"},
        {tag: "c:plates/plastic"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.oritech.assembler/platingcarbon", {type: "techreborn:precise_assembler",
    outputs: [
        {id: "oritech:carbon_plating_block", count: 8},
    ],
    time: 77, power: 128,
    ingredients: [
        {tag: "c:ingots/steel"},
        {tag: "c:ingots/steel"},
        {item: "oritech:reinforced_carbon_sheet"},
        {tag: "c:plates/plastic"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.oritech.assembler/platingiron", {type: "techreborn:precise_assembler",
    outputs: [
        {id: "oritech:iron_plating_block", count: 8},
    ],
    time: 77, power: 128,
    ingredients: [
        {tag: "c:ingots/steel"},
        {tag: "c:ingots/steel"},
        {tag: "c:ingots/iron"},
        {tag: "c:plates/plastic"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.oritech.assembler/platingnickel", {type: "techreborn:precise_assembler",
    outputs: [
        {id: "oritech:nickel_plating_block", count: 8},
    ],
    time: 77, power: 128,
    ingredients: [
        {tag: "c:ingots/steel"},
        {tag: "c:ingots/steel"},
        {tag: "c:ingots/nickel"},
        {tag: "c:plates/plastic"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.oritech.assembler/plutoniumpelletbasic", {type: "techreborn:precise_assembler",
    outputs: [
        {id: "oritech:plutonium_pellet", count: 2},
    ],
    time: 77, power: 128,
    ingredients: [
        {item: "oritech:plutonium_dust"},
        {item: "oritech:plutonium_dust"},
        {tag: "c:plates/plastic"},
        {tag: "c:ingots/nickel"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.oritech.assembler/plutoniumpelletbetter", {type: "techreborn:precise_assembler",
    outputs: [
        {id: "oritech:plutonium_pellet", count: 3},
    ],
    time: 77, power: 128,
    ingredients: [
        {item: "oritech:plutonium_dust"},
        {item: "oritech:plutonium_dust"},
        {tag: "c:plates/plastic"},
        {item: "oritech:adamant_ingot"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.oritech.assembler/plutoniumpelletult", {type: "techreborn:precise_assembler",
    outputs: [
        {id: "oritech:plutonium_pellet", count: 4},
    ],
    time: 77, power: 128,
    ingredients: [
        {item: "oritech:plutonium_dust"},
        {item: "oritech:plutonium_dust"},
        {tag: "c:plates/plastic"},
        {item: "oritech:duratium_ingot"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.oritech.assembler/shroomlight", {type: "techreborn:precise_assembler",
    outputs: [
        {id: "minecraft:shroomlight", count: 1},
    ],
    time: 77, power: 128,
    ingredients: [
        {tag: "minecraft:logs"},
        {item: "minecraft:glowstone"},
        {item: "minecraft:glowstone"},
        {item: "minecraft:glowstone"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.oritech.assembler/slime", {type: "techreborn:precise_assembler",
    outputs: [
        {id: "minecraft:slime_ball", count: 1},
    ],
    time: 77, power: 128,
    ingredients: [
        {item: "minecraft:honeycomb"},
        {tag: "c:fuels/bio"},
        {tag: "c:fuels/bio"},
        {tag: "c:fuels/bio"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.oritech.assembler/solidbiofuel", {type: "techreborn:precise_assembler",
    outputs: [
        {id: "oritech:solid_biofuel", count: 1},
    ],
    time: 77, power: 128,
    ingredients: [
        {tag: "c:fuels/bio"},
        {tag: "c:fuels/bio"},
        {tag: "c:fuels/bio"},
        {tag: "minecraft:planks"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.oritech.assembler/superconductor", {type: "techreborn:precise_assembler",
    outputs: [
        {id: "oritech:superconductor", count: 4},
    ],
    time: 154, power: 128,
    ingredients: [
        {item: "oritech:flux_gate"},
        {tag: "c:ingots/electrum"},
        {item: "oritech:dubios_container"},
        {item: "oritech:energite_ingot"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.oritech.assembler/uranpelletbasic", {type: "techreborn:precise_assembler",
    outputs: [
        {id: "oritech:uranium_pellet", count: 2},
    ],
    time: 77, power: 128,
    ingredients: [
        {item: "oritech:uranium_gem"},
        {item: "oritech:uranium_gem"},
        {tag: "c:plates/plastic"},
        {tag: "c:ingots/nickel"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.oritech.assembler/uranpelletbetter", {type: "techreborn:precise_assembler",
    outputs: [
        {id: "oritech:uranium_pellet", count: 3},
    ],
    time: 77, power: 128,
    ingredients: [
        {item: "oritech:uranium_gem"},
        {item: "oritech:uranium_gem"},
        {tag: "c:plates/plastic"},
        {item: "oritech:adamant_ingot"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.oritech.assembler/uranpelletult", {type: "techreborn:precise_assembler",
    outputs: [
        {id: "oritech:uranium_pellet", count: 4},
    ],
    time: 77, power: 128,
    ingredients: [
        {item: "oritech:uranium_gem"},
        {item: "oritech:uranium_gem"},
        {tag: "c:plates/plastic"},
        {item: "oritech:duratium_ingot"},
    ]
});
