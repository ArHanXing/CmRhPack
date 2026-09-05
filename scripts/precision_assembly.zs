import crafttweaker.api.tag.MCTag;
import crafttweaker.api.recipe.type.Recipe;

<item:techreborn:precise_assembler>.addTooltip("可用配方类型：§e精密组装机§r，§eOritech装配机§r");
<item:techreborn:precise_assembler>.addTooltip("执行§eOritech装配机§r配方时，具有0.8x耗时");

function _frameworkRecipe(_recipe as string, _output as string, _inputA as string, _inputB as string, _time as int) as void{
    <recipetype:techreborn:precise_assembler>.addJsonRecipe(_recipe, {type: "techreborn:precise_assembler", 
        time: _time,
        outputs: [{id: _output, count: 1}],
        power: 64,
        ingredients: [{item: _inputA, count:4},{item: _inputB, count:1}]
    });
}
_frameworkRecipe("ps_framework.titanium", "jsonreg:titanium_frame", "jsonreg:titanium_rod", "techreborn:titanium_ingot", 128);
_frameworkRecipe("ps_framework.aluminum", "jsonreg:aluminum_frame", "jsonreg:aluminum_rod", "techreborn:aluminum_ingot", 128);
_frameworkRecipe("ps_framework.bronze", "jsonreg:bronze_frame", "jsonreg:bronze_rod", "techreborn:bronze_ingot", 128);
_frameworkRecipe("ps_framework.naquadah", "jsonreg:naquadah_frame", "jsonreg:naquadah_rod", "jsonreg:naquadah_ingot", 256);
_frameworkRecipe("ps_framework.duratium", "jsonreg:duratium_frame", "jsonreg:duratium_rod", "oritech:duratium_ingot", 256);
_frameworkRecipe("ps_framework.unrealium", "jsonreg:unrealium_frame", "jsonreg:unrealium_rod", "eternal_starlight:unrealium_ingot", 256);
/*
<recipetype:techreborn:precise_assembler>.addJsonRecipe("test", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "jsonreg:silicon_carbide_dust", count: 1},
        {id: "techreborn:cell", count: 2}
    ],
    time: 600, power: 128,
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "techreborn:silicon"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 1, components: {"techreborn:fluid": "techreborn:carbon"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});
*/
// ============================================================
// 以下由某一天的所有OR装配配方转换而来
// 转换规则: results→outputs, type→techreborn:precise_assembler, time×0.8（缺 time 按 Oritech 默认 60）, power=128
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

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.oritech.assembler/reactorplatingalt", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "oritech:reactor_wall", count: 3},
    ],
    time: 77, power: 128,
    ingredients: [
        {tag: "oritech:plating"},
        {tag: "oritech:plating"},
        {tag: "c:ingots/steel"},
        {tag: "c:ingots/nickel"},
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

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.misc.oritech.assembler/bauxite_node", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "jsonreg:resource_node_bauxite", count: 1},
    ],
    time: 960, power: 128,
    ingredients: [
        {item: "techreborn:magnalium_plate"},
        {item: "tesseract:tesseract"},
        {item: "oritech:advanced_computing_engine"},
        {item: "techreborn:magnalium_plate"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.misc.oritech.assembler/cell", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "techreborn:cell", count: 8},
    ],
    time: 16, power: 128,
    ingredients: [
        {item: "techreborn:tin_ingot"},
        {item: "techreborn:tin_ingot"},
        {item: "techreborn:tin_ingot"},
        {item: "techreborn:tin_ingot"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.misc.oritech.assembler/coal_node", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "oritech:resource_node_coal", count: 1},
    ],
    time: 960, power: 128,
    ingredients: [
        {item: "minecraft:coal_block"},
        {item: "tesseract:tesseract"},
        {item: "oritech:advanced_computing_engine"},
        {item: "minecraft:coal_block"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.misc.oritech.assembler/copper_node", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "oritech:resource_node_copper", count: 1},
    ],
    time: 960, power: 128,
    ingredients: [
        {item: "minecraft:copper_block"},
        {item: "tesseract:tesseract"},
        {item: "oritech:advanced_computing_engine"},
        {item: "minecraft:copper_block"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.misc.oritech.assembler/diamond_node", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "oritech:resource_node_diamond", count: 1},
    ],
    time: 960, power: 128,
    ingredients: [
        {item: "minecraft:diamond_block"},
        {item: "tesseract:tesseract"},
        {item: "oritech:advanced_computing_engine"},
        {item: "minecraft:diamond_block"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.misc.oritech.assembler/emerald_node", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "oritech:resource_node_emerald", count: 1},
    ],
    time: 960, power: 128,
    ingredients: [
        {item: "minecraft:emerald_block"},
        {item: "tesseract:tesseract"},
        {item: "oritech:advanced_computing_engine"},
        {item: "minecraft:emerald_block"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.misc.oritech.assembler/fossil_node", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "jsonreg:resource_node_fossil", count: 1},
    ],
    time: 960, power: 128,
    ingredients: [
        {item: "minecraft:ancient_debris"},
        {item: "tesseract:tesseract"},
        {item: "oritech:advanced_computing_engine"},
        {item: "minecraft:ancient_debris"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.misc.oritech.assembler/gem_node", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "jsonreg:resource_node_gem", count: 1},
    ],
    time: 960, power: 128,
    ingredients: [
        {item: "techreborn:ruby_plate"},
        {item: "tesseract:tesseract"},
        {item: "oritech:advanced_computing_engine"},
        {item: "techreborn:ruby_plate"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.misc.oritech.assembler/gold_node", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "oritech:resource_node_gold", count: 1},
    ],
    time: 960, power: 128,
    ingredients: [
        {item: "minecraft:gold_block"},
        {item: "tesseract:tesseract"},
        {item: "oritech:advanced_computing_engine"},
        {item: "minecraft:gold_block"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.misc.oritech.assembler/iridium_node", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "jsonreg:resource_node_iridium", count: 1},
    ],
    time: 960, power: 128,
    ingredients: [
        {item: "techreborn:iridium_alloy_plate"},
        {item: "tesseract:tesseract"},
        {item: "oritech:super_ai_chip"},
        {item: "techreborn:tungstensteel_plate"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.misc.oritech.assembler/iron_node", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "oritech:resource_node_iron", count: 1},
    ],
    time: 960, power: 128,
    ingredients: [
        {item: "minecraft:iron_block"},
        {item: "tesseract:tesseract"},
        {item: "oritech:advanced_computing_engine"},
        {item: "minecraft:iron_block"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.misc.oritech.assembler/lapis_node", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "oritech:resource_node_lapis", count: 1},
    ],
    time: 960, power: 128,
    ingredients: [
        {item: "minecraft:lapis_block"},
        {item: "tesseract:tesseract"},
        {item: "oritech:advanced_computing_engine"},
        {item: "minecraft:lapis_block"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.misc.oritech.assembler/lead_node", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "jsonreg:resource_node_lead", count: 1},
    ],
    time: 960, power: 128,
    ingredients: [
        {item: "techreborn:lead_plate"},
        {item: "tesseract:tesseract"},
        {item: "oritech:advanced_computing_engine"},
        {item: "techreborn:lead_plate"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.misc.oritech.assembler/naquadah_node", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "jsonreg:resource_node_naquadah", count: 1},
    ],
    time: 960, power: 128,
    ingredients: [
        {item: "jsonreg:naquadah_plate"},
        {item: "tesseract:tesseract"},
        {item: "oritech:advanced_computing_engine"},
        {item: "jsonreg:naquadah_plate"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.misc.oritech.assembler/neutron_node", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "jsonreg:resource_node_neutron", count: 1},
    ],
    time: 960, power: 128,
    ingredients: [
        {item: "avaritia:neutronium_block"},
        {item: "tesseract:tesseract"},
        {item: "oritech:super_ai_chip"},
        {item: "avaritia:neutronium_block"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.misc.oritech.assembler/nickel_node", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "oritech:resource_node_nickel", count: 1},
    ],
    time: 960, power: 128,
    ingredients: [
        {item: "techreborn:nickel_storage_block"},
        {item: "tesseract:tesseract"},
        {item: "oritech:advanced_computing_engine"},
        {item: "techreborn:nickel_storage_block"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.misc.oritech.assembler/platinum_node", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "oritech:resource_node_platinum", count: 1},
    ],
    time: 960, power: 128,
    ingredients: [
        {item: "techreborn:platinum_storage_block"},
        {item: "tesseract:tesseract"},
        {item: "oritech:advanced_computing_engine"},
        {item: "techreborn:platinum_storage_block"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.misc.oritech.assembler/redstone_node", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "oritech:resource_node_redstone", count: 1},
    ],
    time: 960, power: 128,
    ingredients: [
        {item: "minecraft:redstone_block"},
        {item: "tesseract:tesseract"},
        {item: "oritech:advanced_computing_engine"},
        {item: "minecraft:redstone_block"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.misc.oritech.assembler/silver_node", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "jsonreg:resource_node_silver", count: 1},
    ],
    time: 960, power: 128,
    ingredients: [
        {item: "techreborn:silver_plate"},
        {item: "tesseract:tesseract"},
        {item: "oritech:advanced_computing_engine"},
        {item: "techreborn:silver_plate"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.misc.oritech.assembler/sphalerite_node", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "jsonreg:resource_node_sphalerite", count: 1},
    ],
    time: 960, power: 128,
    ingredients: [
        {item: "techreborn:zinc_storage_block"},
        {item: "tesseract:tesseract"},
        {item: "oritech:advanced_computing_engine"},
        {item: "techreborn:zinc_storage_block"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.misc.oritech.assembler/tesseract", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "tesseract:tesseract", count: 2},
    ],
    time: 80, power: 128,
    ingredients: [
        {item: "minecraft:obsidian"},
        {item: "minecraft:ender_pearl"},
        {item: "minecraft:ender_pearl"},
        {item: "techreborn:diamond_plate"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.misc.oritech.assembler/tin_node", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "jsonreg:resource_node_tin", count: 1},
    ],
    time: 960, power: 128,
    ingredients: [
        {item: "techreborn:tin_plate"},
        {item: "tesseract:tesseract"},
        {item: "oritech:advanced_computing_engine"},
        {item: "techreborn:tin_plate"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.misc.oritech.assembler/tungsten_node", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "jsonreg:resource_node_tungsten", count: 1},
    ],
    time: 960, power: 128,
    ingredients: [
        {item: "techreborn:hot_tungstensteel_ingot"},
        {item: "tesseract:tesseract"},
        {item: "oritech:super_ai_chip"},
        {item: "techreborn:hot_tungstensteel_ingot"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.misc.oritech.assembler/uranium_node", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "oritech:resource_node_uranium", count: 1},
    ],
    time: 960, power: 128,
    ingredients: [
        {item: "oritech:deepslate_uranium_ore"},
        {item: "tesseract:tesseract"},
        {item: "oritech:advanced_computing_engine"},
        {item: "oritech:deepslate_uranium_ore"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.t1.or.magnet", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "oritech:magnetic_coil", count: 4},
    ],
    time: 32, power: 128,
    ingredients: [
        {item: "techreborn:copper_cable"},
        {item: "jsonreg:steel_rod"},
        {item: "techreborn:copper_cable"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.t1.or.t1motor", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "oritech:motor", count: 2},
    ],
    time: 32, power: 128,
    ingredients: [
        {item: "jsonreg:copper_rod"},
        {item: "techreborn:steel_ingot"},
        {item: "oritech:magnetic_coil"},
        {item: "oritech:magnetic_coil"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.t1.ori.assembler/capacitor", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "jsonreg:smd_capacitor", count: 2},
    ],
    time: 64, power: 128,
    ingredients: [
        {item: "jsonreg:aluminum_rod"},
        {item: "techreborn:aluminum_plate"},
        {item: "jsonreg:polyethylene_plate"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.t1.ori.assembler/diode", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "jsonreg:smd_diode", count: 2},
    ],
    time: 64, power: 128,
    ingredients: [
        {item: "techreborn:copper_cable"},
        {item: "minecraft:glass"},
        {item: "techreborn:tin_ingot"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.t1.ori.assembler/inductor", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "jsonreg:smd_inductor", count: 2},
    ],
    time: 64, power: 128,
    ingredients: [
        {item: "techreborn:copper_cable"},
        {item: "techreborn:steel_ingot"},
        {item: "jsonreg:polyethylene_ingot"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.t1.ori.assembler/resistor", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "jsonreg:smd_resistor", count: 2},
    ],
    time: 64, power: 128,
    ingredients: [
        {item: "techreborn:sap"},
        {item: "minecraft:paper"},
        {item: "techreborn:coal_dust"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.t1.ori.assembler/rs.advanced_processor", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "refinedstorage:advanced_processor", count: 4},
    ],
    time: 40, power: 128,
    ingredients: [
        {item: "oritech:processing_unit"},
        {item: "refinedstorage:raw_advanced_processor"},
        {item: "refinedstorage:raw_advanced_processor"},
        {item: "minecraft:redstone"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.t1.ori.assembler/rs.basic_processor", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "refinedstorage:basic_processor", count: 4},
    ],
    time: 24, power: 128,
    ingredients: [
        {item: "oritech:processing_unit"},
        {item: "refinedstorage:raw_basic_processor"},
        {item: "refinedstorage:raw_basic_processor"},
        {item: "minecraft:redstone"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.t1.ori.assembler/rs.improved_processor", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "refinedstorage:improved_processor", count: 4},
    ],
    time: 32, power: 128,
    ingredients: [
        {item: "oritech:processing_unit"},
        {item: "refinedstorage:raw_improved_processor"},
        {item: "refinedstorage:raw_improved_processor"},
        {item: "minecraft:redstone"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.t1.ori.assembler/transistor", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "jsonreg:smd_transistor", count: 2},
    ],
    time: 64, power: 128,
    ingredients: [
        {item: "techreborn:tin_cable"},
        {item: "techreborn:silicon_plate"},
        {item: "jsonreg:polyethylene_ingot"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.t1.oritech.assembler/advanced_circuit", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "techreborn:advanced_circuit", count: 2},
    ],
    time: 64, power: 128,
    ingredients: [
        {item: "techreborn:electrum_plate"},
        {item: "techreborn:electronic_circuit"},
        {item: "techreborn:electronic_circuit"},
        {item: "oritech:flux_gate"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.t1.oritech.assembler/advanced_circuit/soc", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "techreborn:advanced_circuit", count: 8},
    ],
    time: 64, power: 128,
    ingredients: [
        {item: "techreborn:electrum_plate"},
        {item: "oritech:advanced_computing_engine"},
        {item: "oritech:advanced_computing_engine"},
        {item: "oritech:plastic_sheet"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.t1.oritech.assembler/advanced_machine_frame", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "techreborn:advanced_machine_frame", count: 2},
    ],
    time: 64, power: 128,
    ingredients: [
        {item: "techreborn:advanced_alloy_plate"},
        {item: "techreborn:carbon_plate"},
        {item: "techreborn:basic_machine_frame"},
        {item: "oritech:plastic_sheet"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.t1.oritech.assembler/basic_machine_frame", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "techreborn:basic_machine_frame", count: 1},
    ],
    time: 16, power: 128,
    ingredients: [
        {item: "techreborn:refined_iron_ingot"},
        {item: "techreborn:refined_iron_ingot"},
        {item: "techreborn:refined_iron_ingot"},
        {item: "minecraft:redstone"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.t1.oritech.assembler/carbon_fibre_strands", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "oritech:carbon_fibre_strands", count: 4},
    ],
    time: 80, power: 128,
    ingredients: [
        {item: "techreborn:carbon_fiber"},
        {item: "techreborn:carbon_fiber"},
        {item: "techreborn:refined_iron_plate"},
        {item: "techreborn:carbon_fiber"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.t1.oritech.assembler/carbon_mesh", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "techreborn:carbon_mesh", count: 2},
    ],
    time: 48, power: 128,
    ingredients: [
        {item: "oritech:iron_dust"},
        {item: "oritech:carbon_fibre_strands"},
        {item: "techreborn:refined_iron_plate"},
        {item: "oritech:carbon_fibre_strands"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.t1.oritech.assembler/electronic_circuit/soc", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "techreborn:electronic_circuit", count: 8},
    ],
    time: 64, power: 128,
    ingredients: [
        {item: "techreborn:refined_iron_plate"},
        {item: "oritech:processing_unit"},
        {item: "oritech:processing_unit"},
        {item: "minecraft:redstone"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.t2.or.coil.cupronickel", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "techreborn:coil_cupronickel", count: 1},
    ],
    time: 64, power: 128,
    ingredients: [
        {item: "techreborn:cupronickel_heating_coil"},
        {item: "techreborn:tin_plate"},
        {item: "techreborn:cupronickel_heating_coil"},
        {item: "techreborn:tin_plate"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.t2.or.coil.kanthal", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "techreborn:coil_kanthal", count: 1},
    ],
    time: 64, power: 128,
    ingredients: [
        {item: "techreborn:kanthal_heating_coil"},
        {item: "techreborn:tin_plate"},
        {item: "techreborn:kanthal_heating_coil"},
        {item: "techreborn:tin_plate"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.t2.or.coil.nichrome", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "techreborn:coil_nichrome", count: 1},
    ],
    time: 64, power: 128,
    ingredients: [
        {item: "techreborn:nichrome_heating_coil"},
        {item: "techreborn:tin_plate"},
        {item: "techreborn:nichrome_heating_coil"},
        {item: "techreborn:tin_plate"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.t2.or.t2coil", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "jsonreg:mv_voltage_coil", count: 4},
    ],
    time: 32, power: 128,
    ingredients: [
        {item: "techreborn:insulated_gold_cable"},
        {item: "jsonreg:aluminum_rod"},
        {item: "techreborn:insulated_gold_cable"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.t2.or.t2motor", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "jsonreg:mv_electric_motor", count: 1},
    ],
    time: 32, power: 128,
    ingredients: [
        {item: "jsonreg:titanium_rod"},
        {item: "techreborn:aluminum_ingot"},
        {item: "jsonreg:mv_voltage_coil"},
        {item: "jsonreg:mv_voltage_coil"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.t2.oritech.assembler/industrial_circuit/soc", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "techreborn:industrial_circuit", count: 8},
    ],
    time: 64, power: 128,
    ingredients: [
        {item: "techreborn:platinum_plate"},
        {item: "techreborn:platinum_plate"},
        {item: "oritech:super_ai_chip"},
        {item: "oritech:flux_gate"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.t2.oritech.assembler/industrial_machine_frame", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "techreborn:industrial_machine_frame", count: 2},
    ],
    time: 48, power: 128,
    ingredients: [
        {item: "techreborn:advanced_machine_frame"},
        {item: "techreborn:iridium_alloy_plate"},
        {item: "techreborn:advanced_circuit"},
        {item: "oritech:flux_gate"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.t2.oritech.assembler/jart2rod", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "justarod:basic_electric_rod", count: 1},
    ],
    time: 48, power: 128,
    ingredients: [
        {item: "justarod:redstone_rod"},
        {item: "oritech:advanced_computing_engine"},
        {item: "affinity:fairly_attuned_amethyst_shard"},
        {item: "techreborn:lithium_ion_battery"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.t2.oritech.assembler/lapotron", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "techreborn:lapotron_crystal", count: 1},
    ],
    time: 48, power: 128,
    ingredients: [
        {item: "techreborn:lazurite_plate"},
        {item: "techreborn:industrial_circuit"},
        {item: "techreborn:lazurite_plate"},
        {item: "techreborn:energy_crystal"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.t3.or.t3coil", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "jsonreg:hv_voltage_coil", count: 3},
    ],
    time: 64, power: 128,
    ingredients: [
        {item: "techreborn:insulated_hv_cable"},
        {item: "jsonreg:naquadah_rod"},
        {item: "techreborn:insulated_hv_cable"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.t3.or.t3motor", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "jsonreg:hv_electric_motor", count: 1},
    ],
    time: 64, power: 128,
    ingredients: [
        {item: "jsonreg:duratium_rod"},
        {item: "techreborn:tungstensteel_ingot"},
        {item: "jsonreg:hv_voltage_coil"},
        {item: "jsonreg:hv_voltage_coil"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.t3.oritech.assembler/jart3rod", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "justarod:advanced_electric_rod", count: 1},
    ],
    time: 96, power: 128,
    ingredients: [
        {item: "justarod:basic_electric_rod"},
        {item: "techreborn:industrial_circuit"},
        {item: "affinity:stabilized_artifact_blade"},
        {item: "techreborn:lapotron_crystal"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.uni.insulated.copper_batch", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "techreborn:insulated_copper_cable", count: 4},
    ],
    time: 32, power: 128,
    ingredients: [
        {item: "minecraft:copper_ingot"},
        {item: "jsonreg:rubber_plate"},
        {item: "jsonreg:rubber_plate"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.uni.insulated.gold_batch", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "techreborn:insulated_gold_cable", count: 4},
    ],
    time: 32, power: 128,
    ingredients: [
        {item: "minecraft:gold_ingot"},
        {item: "jsonreg:polyethylene_plate"},
        {item: "jsonreg:polyethylene_plate"},
        {item: "minecraft:gold_ingot"},
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("converted.crafttweaker.uni.insulated.silver", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "techreborn:insulated_hv_cable", count: 1},
    ],
    time: 32, power: 128,
    ingredients: [
        {item: "techreborn:hv_cable"},
        {item: "jsonreg:polyethylene_plate"},
        {item: "jsonreg:epoxy_resin_plate"},
        {item: "jsonreg:epoxy_resin_plate"},
    ]
});
