import crafttweaker.api.tag.MCTag;
import crafttweaker.api.ingredient.type.IIngredientEmpty;
import crafttweaker.api.ingredient.IIngredient;

<recipetype:oritech:fuel_generator>.removeAll();
<recipetype:oritech:refinery>.removeByName("oritech:refinery/oilbase");
<recipetype:oritech:refinery>.removeByName("oritech:refinery/oilalt");
<recipetype:techreborn:gas_generator>.removeAll();
<recipetype:techreborn:semi_fluid_generator>.removeAll();
<recipetype:techreborn:diesel_generator>.removeAll();
/*
[18:18:04.233][INFO][CraftTweaker-Commands]: Recipe type: '<recipetype:oritech:fuel_generator>'
  <recipetype:oritech:fuel_generator>.addJsonRecipe("oritech:fuelgen/compat/techreborn/diesel", {type: "oritech:fuel_generator", results: [], time: 280, fluidInput: {fluid: "techreborn:diesel", amount: 8100}, ingredients: []});
  <recipetype:oritech:fuel_generator>.addJsonRecipe("oritech:fuelgen/compat/techreborn/nitrocoalfuel", {type: "oritech:fuel_generator", results: [], time: 240, fluidInput: {fluid: "techreborn:nitrocoal_fuel", amount: 8100}, ingredients: []});
  <recipetype:oritech:fuel_generator>.addJsonRecipe("oritech:fuelgen/compat/techreborn/nitrodiesel", {type: "oritech:fuel_generator", results: [], time: 320, fluidInput: {fluid: "techreborn:nitro_diesel", amount: 8100}, ingredients: []});
  <recipetype:oritech:fuel_generator>.addJsonRecipe("oritech:fuelgen/compat/techreborn/nitrofuel", {type: "oritech:fuel_generator", results: [], time: 200, fluidInput: {fluid: "techreborn:nitrofuel", amount: 8100}, ingredients: []});
  <recipetype:oritech:fuel_generator>.addJsonRecipe("oritech:fuelgen/compat/techreborn/oil", {type: "oritech:fuel_generator", fluidInput: {fluid: "techreborn:oil", amount: 8100}, results: [], ingredients: []});
  <recipetype:oritech:fuel_generator>.addJsonRecipe("oritech:fuelgen/crude", {type: "oritech:fuel_generator", results: [], time: 20, fluidInput: {fluid: "#c:oil", amount: 8100}, ingredients: []});
  <recipetype:oritech:fuel_generator>.addJsonRecipe("oritech:fuelgen/diesel", {type: "oritech:fuel_generator", results: [], time: 80, fluidInput: {fluid: "#c:diesel", amount: 8100}, ingredients: []});
  <recipetype:oritech:fuel_generator>.addJsonRecipe("oritech:fuelgen/fuel", {type: "oritech:fuel_generator", results: [], time: 320, fluidInput: {fluid: "#c:turbofuel", amount: 8100}, ingredients: []});
  <recipetype:oritech:fuel_generator>.addJsonRecipe("oritech:fuelgen/heavyoil", {type: "oritech:fuel_generator", results: [], time: 40, fluidInput: {fluid: "oritech:still_heavy_oil", amount: 8100}, ingredients: []});
  <recipetype:oritech:fuel_generator>.addJsonRecipe("oritech:fuelgen/naphtha", {type: "oritech:fuel_generator", results: [], time: 40, fluidInput: {fluid: "#c:naphtha", amount: 8100}, ingredients: []});


[18:18:04.243][INFO][CraftTweaker-Commands]: Recipe type: '<recipetype:techreborn:gas_generator>'
  <recipetype:techreborn:gas_generator>.addJsonRecipe("techreborn:gas_generator/hydrogen", {type: "techreborn:gas_generator", power: 15, fluid: "techreborn:hydrogen"});
  <recipetype:techreborn:gas_generator>.addJsonRecipe("techreborn:gas_generator/methane", {type: "techreborn:gas_generator", power: 45, fluid: "techreborn:methane"});

[18:18:04.662][INFO][CraftTweaker-Commands]: Recipe type: '<recipetype:techreborn:semi_fluid_generator>'
  <recipetype:techreborn:semi_fluid_generator>.addJsonRecipe("techreborn:semi_fluid_generator/biofuel", {type: "techreborn:semi_fluid_generator", power: 6, fluid: "techreborn:biofuel"});
  <recipetype:techreborn:semi_fluid_generator>.addJsonRecipe("techreborn:semi_fluid_generator/lithium", {type: "techreborn:semi_fluid_generator", power: 60, fluid: "techreborn:lithium"});
  <recipetype:techreborn:semi_fluid_generator>.addJsonRecipe("techreborn:semi_fluid_generator/oil", {type: "techreborn:semi_fluid_generator", power: 16, fluid: "techreborn:oil"});
  <recipetype:techreborn:semi_fluid_generator>.addJsonRecipe("techreborn:semi_fluid_generator/sodium", {type: "techreborn:semi_fluid_generator", power: 30, fluid: "techreborn:sodium"});

[18:18:04.588][INFO][CraftTweaker-Commands]: Recipe type: '<recipetype:techreborn:diesel_generator>'
  <recipetype:techreborn:diesel_generator>.addJsonRecipe("techreborn:diesel_generator/diesel", {type: "techreborn:diesel_generator", power: 128, fluid: "techreborn:diesel"});
  <recipetype:techreborn:diesel_generator>.addJsonRecipe("techreborn:diesel_generator/nitro_diesel", {type: "techreborn:diesel_generator", power: 400, fluid: "techreborn:nitro_diesel"});
  <recipetype:techreborn:diesel_generator>.addJsonRecipe("techreborn:diesel_generator/nitrocoal_fuel", {type: "techreborn:diesel_generator", power: 48, fluid: "techreborn:nitrocoal_fuel"});
  <recipetype:techreborn:diesel_generator>.addJsonRecipe("techreborn:diesel_generator/nitrofuel", {type: "techreborn:diesel_generator", power: 24, fluid: "techreborn:nitrofuel"});


*/
// 石油化工，T1 ~ T2

//统一 OR still_oil 和 TR oil，共享配方
//决定采用 TR 的柴油
<recipetype:techreborn:distillation_tower>.removeByName("techreborn:distillation_tower/cell");
<recipetype:oritech:centrifuge_fluid>.removeByName("oritech:centrifuge/fluid/polymerresin");
<recipetype:oritech:centrifuge_fluid>.removeByName("oritech:centrifuge/fluid/compat/techreborn/fuel");
<recipetype:techreborn:chemical_reactor>.removeByName("techreborn:chemical_reactor/nitrofuel");
<recipetype:techreborn:chemical_reactor>.removeByName("techreborn:chemical_reactor/nitro_diesel");
<recipetype:techreborn:chemical_reactor>.removeByName("techreborn:chemical_reactor/nitrocoal_fuel");

// ========== 1. 原油脱盐 ==========
<recipetype:oritech:refinery>.addJsonRecipe("oil.process.or.desalt.crude.tr", {type: "oritech:refinery",
    results: [],
    fluidOutputs: [
        {fluid: "jsonreg:desalted_crude", amount: 81000},
        {fluid: "jsonreg:saline_water", amount: 81000}
    ],
    time: 200,
    fluidInput: {fluid: "techreborn:oil", amount: 81000},
    ingredients: []
});

<recipetype:oritech:refinery>.addJsonRecipe("oil.process.or.desalt.crude.or", {type: "oritech:refinery",
    results: [],
    fluidOutputs: [
        {fluid: "jsonreg:desalted_crude", amount: 81000},
        {fluid: "jsonreg:saline_water", amount: 81000}
    ],
    time: 200,
    fluidInput: {fluid: "oritech:still_oil", amount: 81000},
    ingredients: []
});

// ========== 2. 常压蒸馏 (TR 蒸馏塔) ==========
<recipetype:techreborn:distillation_tower>.addJsonRecipe("oil.process.tr.atmospheric_distillation", {type: "techreborn:distillation_tower",
    time: 200,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "oritech:still_naphtha"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:heavy_diesel"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:atmospheric_residue"}}
    ],
    power: 32,
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:desalted_crude"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 2, base: {item: "techreborn:cell"}, components: {"techreborn:fluid": "minecraft:empty"},  "fabric:type": "fabric:components"}
    ]
});

// ========== 3. 减压蒸馏 (OR 精炼机) ==========
<recipetype:oritech:refinery>.addJsonRecipe("oil.process.or.vacuum_distillation", {type: "oritech:refinery",
    results: [],
    fluidOutputs: [
        {fluid: "jsonreg:vacuum_diesel", amount: 30375},
        {fluid: "jsonreg:vacuum_residue", amount: 50625}
    ],
    time: 200,
    fluidInput: {fluid: "jsonreg:atmospheric_residue", amount: 81000},
    ingredients: []
});

// ========== 4. 延迟焦化 (OR 精炼机) ==========
<recipetype:oritech:refinery>.addJsonRecipe("oil.process.or.coking", {type: "oritech:refinery",
    results: [{id: "jsonreg:petroleum_coke", count: 1}],
    fluidOutputs: [
        {fluid: "jsonreg:coke_gas", amount: 16200},
        {fluid: "jsonreg:coker_light_oil", amount: 32400}
    ],
    time: 200,
    fluidInput: {fluid: "jsonreg:vacuum_residue", amount: 81000},
    ingredients: []
});

// ========== 5. 蒸汽裂解 (TR 化反 → 单输出) ==========
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("oil.process.tr.steam_cracking", {type: "techreborn:chemical_reactor",
    time: 200,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:pyrolysis_gas_mix"}},
        {id: "techreborn:cell", count: 1}
    ],
    power: 32,
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "oritech:still_naphtha"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 1, components: {"techreborn:fluid": "minecraft:water"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// ========== 6. 裂解气分离 (TR 蒸馏塔, fork 6出4进) ==========
// 原两段式（裂解汽油+干气 → 干气再分离）因 3 输出上限拆分，fork 后一次分出
<recipetype:techreborn:distillation_tower>.addJsonRecipe("oil.process.tr.gas_separation", {type: "techreborn:distillation_tower",
    time: 200,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:ethylene"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:propylene"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:butadiene"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:pyrolysis_gasoline"}}
    ],
    power: 32,
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:pyrolysis_gas_mix"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 3, base: {item: "techreborn:cell"}, components: {"techreborn:fluid": "minecraft:empty"},  "fabric:type": "fabric:components"}
    ]
});

// ========== 7. 芳烃抽提 (TR 蒸馏塔) ==========
<recipetype:techreborn:distillation_tower>.addJsonRecipe("oil.process.tr.aromatics_separation", {type: "techreborn:distillation_tower",
    time: 200,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:benzene"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:toluene"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:xylene"}}
    ],
    power: 32,
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:pyrolysis_gasoline"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 2, base: {item: "techreborn:cell"}, components: {"techreborn:fluid": "minecraft:empty"},  "fabric:type": "fabric:components"}
    ]
});

//空气分离挪到了下面

// ========== 9. 合成氨 (TR 化反 → 单输出) ==========
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("oil.process.tr.ammonia_synthesis", {type: "techreborn:chemical_reactor",
    time: 200,
    outputs: [
        {id: "techreborn:cell", count: 2, components: {"techreborn:fluid": "jsonreg:ammonia"}},
        {id: "techreborn:cell", count: 2}
    ],
    power: 30,
    ingredients: [
        {count: 3, components: {"techreborn:fluid": "techreborn:hydrogen"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 1, components: {"techreborn:fluid": "techreborn:nitrogen"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// ========== 10a. 氨氧化 (TR 化反 → 单输出) ==========
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("oil.process.tr.ammonia_oxidation", {type: "techreborn:chemical_reactor",
    time: 200,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:nitrous_gas"}},
        {id: "techreborn:cell", count: 1}
    ],
    power: 30,
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:ammonia"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 1, components: {"techreborn:fluid": "techreborn:compressed_air"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// ========== 10b. 硝酸合成 (OR 精炼机) ==========
<recipetype:oritech:refinery>.addJsonRecipe("oil.process.or.nitric_acid", {type: "oritech:refinery",
    results: [
      {id:"techreborn:cell",count:1}
    ],
    fluidOutputs: [
        {fluid: "jsonreg:nitric_acid", amount: 81000}
    ],
    time: 200,
    fluidInput: {fluid: "jsonreg:nitrous_gas", amount: 81000},
    ingredients: [{count: 1, components: {"techreborn:fluid": "minecraft:water"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}]
});

// ========== 11. 乙醇合成 (TR 化反 → 单输出) ==========
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("oil.process.tr.ethanol", {type: "techreborn:chemical_reactor",
    time: 200,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:ethanol"}},
        {id: "techreborn:cell", count: 1}
    ],
    power: 30,
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:ethylene"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 1, components: {"techreborn:fluid": "minecraft:water"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// ========== 12. 硝酸乙酯 (TR 化反 → 单输出) ==========
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("oil.process.tr.ethyl_nitrate", {type: "techreborn:chemical_reactor",
    time: 200,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:ethyl_nitrate"}},
        {id: "techreborn:cell", count: 1}
    ],
    power: 30,
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:ethanol"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 1, components: {"techreborn:fluid": "jsonreg:nitric_acid"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// ========== 13. 加氢脱硫 (TR 化反 → 单输出) ==========
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("oil.process.tr.hydrodesulfurization", {type: "techreborn:chemical_reactor",
    time: 200,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:ultra_low_sulfur_diesel"}},
        {id: "techreborn:cell", count: 1}
    ],
    power: 30,
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:heavy_diesel"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 1, components: {"techreborn:fluid": "techreborn:hydrogen"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// ========== 14. 硝基柴油 (TR 化反 → 单输出) ==========
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("oil.process.tr.nitrodiesel", {type: "techreborn:chemical_reactor",
    time: 200,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "techreborn:nitro_diesel"}},
        {id: "techreborn:cell", count: 1}
    ],
    power: 30,
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:ultra_low_sulfur_diesel"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 1, components: {"techreborn:fluid": "jsonreg:ethyl_nitrate"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// ========== 15. 硝基碳燃油 (TR 化反 → 单输出) ==========
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("oil.process.tr.nitrocoal_fuel", {type: "techreborn:chemical_reactor",
    time: 200,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "techreborn:nitrocoal_fuel"}}
    ],
    power: 30,
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "techreborn:nitro_diesel"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "jsonreg:petroleum_coke", count: 1}
    ]
});

// ========== 16. 聚乙烯 (TR 化反 → 单输出) ==========
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("oil.process.tr.polyethylene", {type: "techreborn:chemical_reactor",
    time: 200,
    outputs: [
        {id: "jsonreg:polyethylene_pellets", count: 2},
        {id: "techreborn:cell", count: 1}
    ],
    power: 30,
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:ethylene"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "oritech:small_iron_dust", count: 1}
    ]
});

// ========== 17. 汽油调和 (TR 化反 → 单输出) ==========
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("oil.process.tr.gasoline", {type: "techreborn:chemical_reactor",
    time: 200,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:gasoline"}},
        {id: "techreborn:cell", count: 1}
    ],
    power: 30,
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "oritech:still_naphtha"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 1, components: {"techreborn:fluid": "jsonreg:benzene"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// ========== 18. 异丙苯合成 (TR 化反 → 单输出) ==========
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("oil.process.tr.cumene", {type: "techreborn:chemical_reactor",
    time: 200,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:cumene"}},
        {id: "techreborn:cell", count: 1}
    ],
    power: 30,
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:benzene"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 1, components: {"techreborn:fluid": "jsonreg:propylene"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// ========== 19. 苯酚丙酮 (大化反: 异丙苯氧化, 六进四出单步完成) ==========
<recipetype:techreborn:large_chemical_reactor>.addJsonRecipe("oil.process.tr.phenol_acetone", {type: "techreborn:large_chemical_reactor",
    time: 200,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:phenol"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:acetone"}}
    ],
    power: 30,
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:cumene"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 1, components: {"techreborn:fluid": "techreborn:compressed_air"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// ========== 20. 双酚A (TR 化反 → 单输出) ==========
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("oil.process.tr.bisphenol_a", {type: "techreborn:chemical_reactor",
    time: 200,
    outputs: [
        {id: "jsonreg:bisphenol_a", count: 1},
        {id: "techreborn:cell", count: 2}
    ],
    power: 30,
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:phenol"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 1, components: {"techreborn:fluid": "jsonreg:acetone"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// ========== 21. 盐水电解 (TR 工业电解机) ==========
<recipetype:techreborn:industrial_electrolyzer>.addJsonRecipe("oil.process.tr.chloralkali", {type: "techreborn:industrial_electrolyzer",
    time: 200,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:chlorine"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "techreborn:hydrogen"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:sodium_hydroxide_solution"}}
    ],
    power: 32,
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:brine"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 2, base: {item: "techreborn:cell"}, components: {"techreborn:fluid": "minecraft:empty"},  "fabric:type": "fabric:components"}
    ]
});
<recipetype:techreborn:industrial_electrolyzer>.addJsonRecipe("oil.process.tr.chloralkali.saline_waste_water", {type: "techreborn:industrial_electrolyzer",
    time: 200,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:chlorine"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "techreborn:hydrogen"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:sodium_hydroxide_solution"}}
    ],
    power: 32,
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:saline_water"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 2, base: {item: "techreborn:cell"}, components: {"techreborn:fluid": "minecraft:empty"},  "fabric:type": "fabric:components"}
    ]
});

// ========== 22. 氯丙醇 (TR 化反 → 单输出) ==========
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("oil.process.tr.chloropropanol", {type: "techreborn:chemical_reactor",
    time: 200,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:chloropropanol"}},
        {id: "techreborn:cell", count: 1}
    ],
    power: 30,
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:propylene"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 1, components: {"techreborn:fluid": "jsonreg:chlorine"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// ========== 23. 环氧氯丙烷 (TR 化反 → 单输出) ==========
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("oil.process.tr.epichlorohydrin", {type: "techreborn:chemical_reactor",
    time: 200,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:epichlorohydrin"}},
        {id: "techreborn:cell", count: 1}
    ],
    power: 30,
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:chloropropanol"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 1, components: {"techreborn:fluid": "jsonreg:sodium_hydroxide_solution"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// ========== 24. 环氧树脂 (TR 化反 → 单输出) ==========
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("oil.process.tr.epoxy_resin", {type: "techreborn:chemical_reactor",
    time: 200,
    outputs: [
        {id: "jsonreg:epoxy_resin", count: 1},
        {id: "techreborn:cell", count: 1}
    ],
    power: 30,
    ingredients: [
        {item: "jsonreg:bisphenol_a", count: 1},
        {count: 1, components: {"techreborn:fluid": "jsonreg:epichlorohydrin"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});



// PBI 产线部分



// =================================================
// PBI 产线 (T3 终极塑料)
// =================================================

// --- 1. 硝基苯合成 ---
// 苯 + 硝酸 → 硝基苯 + 水
<recipetype:techreborn:large_chemical_reactor>.addJsonRecipe("oil.pbi.nitrobenzene", {
    type: "techreborn:large_chemical_reactor",
    time: 200,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:nitrobenzene"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "minecraft:water"}}
    ],
    power: 30,
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:benzene"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 1, components: {"techreborn:fluid": "jsonreg:nitric_acid"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// --- 2. 苯胺合成 ---
// 硝基苯 + 氢气 → 苯胺 + 水
<recipetype:techreborn:large_chemical_reactor>.addJsonRecipe("oil.pbi.aniline", {
    type: "techreborn:large_chemical_reactor",
    time: 200,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:aniline"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "minecraft:water"}}
    ],
    power: 30,
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:nitrobenzene"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 1, components: {"techreborn:fluid": "techreborn:hydrogen"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// --- 3. 联苯胺合成 (氧化偶联) ---
// 苯胺 + 氧气(压缩空气) → 联苯胺粉尘 + 水
<recipetype:techreborn:large_chemical_reactor>.addJsonRecipe("oil.pbi.benzidine", {
    type: "techreborn:large_chemical_reactor",
    time: 200,
    outputs: [
        {id: "jsonreg:benzidine_dust", count: 1},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "minecraft:water"}}
    ],
    power: 30,
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:aniline"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 1, components: {"techreborn:fluid": "techreborn:compressed_air"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// --- 4. 二硝基联苯胺 (联苯胺硝化) ---
// 联苯胺粉尘 + 硝酸 → 二硝基联苯胺粉尘 + 水
<recipetype:techreborn:large_chemical_reactor>.addJsonRecipe("oil.pbi.dinitrobenzidine", {
    type: "techreborn:large_chemical_reactor",
    time: 200,
    outputs: [
        {id: "jsonreg:dinitrobenzidine_dust", count: 1},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "minecraft:water"}}
    ],
    power: 30,
    ingredients: [
        {item: "jsonreg:benzidine_dust", count: 1},
        {count: 1, components: {"techreborn:fluid": "jsonreg:nitric_acid"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// --- 5. 联苯四胺 (还原) ---
// 二硝基联苯胺粉尘 + 氢气 → 联苯四胺粉尘 + 水
<recipetype:techreborn:large_chemical_reactor>.addJsonRecipe("oil.pbi.tetraaminobiphenyl", {
    type: "techreborn:large_chemical_reactor",
    time: 200,
    outputs: [
        {id: "jsonreg:tetraaminobiphenyl_dust", count: 1},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "minecraft:water"}}
    ],
    power: 30,
    ingredients: [
        {item: "jsonreg:dinitrobenzidine_dust", count: 1},
        {count: 1, components: {"techreborn:fluid": "techreborn:hydrogen"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// --- 6. 间苯二甲酸 (间二甲苯氧化) ---
// 间二甲苯 + 氧气 → 间苯二甲酸粉尘 + 水
<recipetype:techreborn:large_chemical_reactor>.addJsonRecipe("oil.pbi.isophthalic_acid", {
    type: "techreborn:large_chemical_reactor",
    time: 200,
    outputs: [
        {id: "jsonreg:isophthalic_acid_dust", count: 1},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "minecraft:water"}}
    ],
    power: 30,
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:xylene"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 1, components: {"techreborn:fluid": "techreborn:compressed_air"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// --- 7. PBI 缩聚 (工业高炉) ---
// 联苯四胺 + 间苯二甲酸 → PBI粉
<recipetype:techreborn:blast_furnace>.addJsonRecipe("oil.pbi.polymerize", {
    type: "techreborn:blast_furnace",
    time: 600,
    heat: 3000,
    power: 128,
    outputs: [
        {id: "jsonreg:pbi_dust", count: 1}
    ],
    ingredients: [
        {item: "jsonreg:tetraaminobiphenyl_dust", count: 1},
        {item: "jsonreg:isophthalic_acid_dust", count: 1},
    ]
});

// --- 8. PBI 板材压制 ---
<recipetype:techreborn:compressor>.addJsonRecipe("oil.pbi.pbi_plate", {
    type: "techreborn:compressor",
    time: 200,
    outputs: [
        {id: "jsonreg:pbi_plate", count: 1}
    ],
    power: 32,
    ingredients: [
        {item: "jsonreg:pbi_dust", count: 2}
    ]
});

//烧起来！
//配方燃料定义
// ========== OR 燃油发电机配方 (消耗 100mB, amount=8100) ==========
// 原油 (双 ID)
<recipetype:oritech:fuel_generator>.addJsonRecipe("oil.burn.orfuelgen/crude_oil_tr", {type: "oritech:fuel_generator", results: [], time: 3, fluidInput: {fluid: "techreborn:oil", amount: 8100}, ingredients: []});
<recipetype:oritech:fuel_generator>.addJsonRecipe("oil.burn.orfuelgen/crude_oil_or", {type: "oritech:fuel_generator", results: [], time: 3, fluidInput: {fluid: "oritech:still_oil", amount: 8100}, ingredients: []});
// 脱盐原油
<recipetype:oritech:fuel_generator>.addJsonRecipe("oil.burn.orfuelgen/desalted_crude", {type: "oritech:fuel_generator", results: [], time: 4, fluidInput: {fluid: "jsonreg:desalted_crude", amount: 8100}, ingredients: []});
// 常压渣油
<recipetype:oritech:fuel_generator>.addJsonRecipe("oil.burn.orfuelgen/atmospheric_residue", {type: "oritech:fuel_generator", results: [], time: 10, fluidInput: {fluid: "jsonreg:atmospheric_residue", amount: 8100}, ingredients: []});
// 减压柴油
<recipetype:oritech:fuel_generator>.addJsonRecipe("oil.burn.orfuelgen/vacuum_diesel", {type: "oritech:fuel_generator", results: [], time: 18, fluidInput: {fluid: "jsonreg:vacuum_diesel", amount: 8100}, ingredients: []});
// 减压渣油
<recipetype:oritech:fuel_generator>.addJsonRecipe("oil.burn.orfuelgen/vacuum_residue", {type: "oritech:fuel_generator", results: [], time: 6, fluidInput: {fluid: "jsonreg:vacuum_residue", amount: 8100}, ingredients: []});
// 焦化轻油
<recipetype:oritech:fuel_generator>.addJsonRecipe("oil.burn.orfuelgen/coker_light_oil", {type: "oritech:fuel_generator", results: [], time: 11, fluidInput: {fluid: "jsonreg:coker_light_oil", amount: 8100}, ingredients: []});
// 轻石脑油
<recipetype:oritech:fuel_generator>.addJsonRecipe("oil.burn.orfuelgen/light_naphtha", {type: "oritech:fuel_generator", results: [], time: 12, fluidInput: {fluid: "oritech:still_naphtha", amount: 8100}, ingredients: []});
// 重柴油
<recipetype:oritech:fuel_generator>.addJsonRecipe("oil.burn.orfuelgen/heavy_diesel", {type: "oritech:fuel_generator", results: [], time: 20, fluidInput: {fluid: "jsonreg:heavy_diesel", amount: 8100}, ingredients: []});
// 柴油
<recipetype:oritech:fuel_generator>.addJsonRecipe("oil.burn.orfuelgen/diesel", {type: "oritech:fuel_generator", results: [], time: 25, fluidInput: {fluid: "techreborn:diesel", amount: 8100}, ingredients: []});
// 超低硫柴油
<recipetype:oritech:fuel_generator>.addJsonRecipe("oil.burn.orfuelgen/ultra_low_sulfur_diesel", {type: "oritech:fuel_generator", results: [], time: 25, fluidInput: {fluid: "jsonreg:ultra_low_sulfur_diesel", amount: 8100}, ingredients: []});
// 硝基柴油
<recipetype:oritech:fuel_generator>.addJsonRecipe("oil.burn.orfuelgen/nitro_diesel", {type: "oritech:fuel_generator", results: [], time: 78, fluidInput: {fluid: "techreborn:nitro_diesel", amount: 8100}, ingredients: []});
// 硝基碳燃油
<recipetype:oritech:fuel_generator>.addJsonRecipe("oil.burn.orfuelgen/nitrocoal_fuel", {type: "oritech:fuel_generator", results: [], time: 117, fluidInput: {fluid: "techreborn:nitrocoal_fuel", amount: 8100}, ingredients: []});
// 汽油
<recipetype:oritech:fuel_generator>.addJsonRecipe("oil.burn.orfuelgen/gasoline", {type: "oritech:fuel_generator", results: [], time: 15, fluidInput: {fluid: "oil.burn.trgasoline", amount: 8100}, ingredients: []});
// 乙醇
<recipetype:oritech:fuel_generator>.addJsonRecipe("oil.burn.orfuelgen/ethanol", {type: "oritech:fuel_generator", results: [], time: 12, fluidInput: {fluid: "jsonreg:ethanol", amount: 8100}, ingredients: []});
// 硝酸乙酯
<recipetype:oritech:fuel_generator>.addJsonRecipe("oil.burn.orfuelgen/ethyl_nitrate", {type: "oritech:fuel_generator", results: [], time: 59, fluidInput: {fluid: "jsonreg:ethyl_nitrate", amount: 8100}, ingredients: []});
// 裂解汽油
<recipetype:oritech:fuel_generator>.addJsonRecipe("oil.burn.orfuelgen/pyrolysis_gasoline", {type: "oritech:fuel_generator", results: [], time: 16, fluidInput: {fluid: "jsonreg:pyrolysis_gasoline", amount: 8100}, ingredients: []});
// 苯
<recipetype:oritech:fuel_generator>.addJsonRecipe("oil.burn.orfuelgen/benzene", {type: "oritech:fuel_generator", results: [], time: 14, fluidInput: {fluid: "jsonreg:benzene", amount: 8100}, ingredients: []});
// 甲苯
<recipetype:oritech:fuel_generator>.addJsonRecipe("oil.burn.orfuelgen/toluene", {type: "oritech:fuel_generator", results: [], time: 13, fluidInput: {fluid: "jsonreg:toluene", amount: 8100}, ingredients: []});
// 二甲苯
<recipetype:oritech:fuel_generator>.addJsonRecipe("oil.burn.orfuelgen/xylene", {type: "oritech:fuel_generator", results: [], time: 13, fluidInput: {fluid: "jsonreg:xylene", amount: 8100}, ingredients: []});

// ========== TR 半流质发电机配方 ==========
// 原油
<recipetype:techreborn:semi_fluid_generator>.addJsonRecipe("oil.burn.trsemi_fluid/crude_oil_tr", {type: "techreborn:semi_fluid_generator", power: 16, fluid: "techreborn:oil"});
<recipetype:techreborn:semi_fluid_generator>.addJsonRecipe("oil.burn.trsemi_fluid/crude_oil_or", {type: "techreborn:semi_fluid_generator", power: 16, fluid: "oritech:still_oil"});
// 脱盐原油
<recipetype:techreborn:semi_fluid_generator>.addJsonRecipe("oil.burn.trsemi_fluid/desalted_crude", {type: "techreborn:semi_fluid_generator", power: 20, fluid: "jsonreg:desalted_crude"});
// 常压渣油
<recipetype:techreborn:semi_fluid_generator>.addJsonRecipe("oil.burn.trsemi_fluid/atmospheric_residue", {type: "techreborn:semi_fluid_generator", power: 50, fluid: "jsonreg:atmospheric_residue"});
// 减压渣油
<recipetype:techreborn:semi_fluid_generator>.addJsonRecipe("oil.burn.trsemi_fluid/vacuum_residue", {type: "techreborn:semi_fluid_generator", power: 30, fluid: "jsonreg:vacuum_residue"});
// 焦化轻油 (也可用柴油发电机，这里也放半流质备选)
<recipetype:techreborn:semi_fluid_generator>.addJsonRecipe("oil.burn.trsemi_fluid/coker_light_oil", {type: "techreborn:semi_fluid_generator", power: 55, fluid: "jsonreg:coker_light_oil"});
// 乙醇
<recipetype:techreborn:semi_fluid_generator>.addJsonRecipe("oil.burn.trsemi_fluid/ethanol", {type: "techreborn:semi_fluid_generator", power: 60, fluid: "jsonreg:ethanol"});

// ========== TR 柴油发电机配方 ==========
// 轻石脑油
<recipetype:techreborn:diesel_generator>.addJsonRecipe("oil.burn.trdiesel/light_naphtha", {type: "techreborn:diesel_generator", power: 60, fluid: "oritech:still_naphtha"});
// 重柴油
<recipetype:techreborn:diesel_generator>.addJsonRecipe("oil.burn.trdiesel/heavy_diesel", {type: "techreborn:diesel_generator", power: 100, fluid: "jsonreg:heavy_diesel"});
// 柴油
<recipetype:techreborn:diesel_generator>.addJsonRecipe("oil.burn.trdiesel/diesel", {type: "techreborn:diesel_generator", power: 128, fluid: "techreborn:diesel"});
// 超低硫柴油
<recipetype:techreborn:diesel_generator>.addJsonRecipe("oil.burn.trdiesel/ultra_low_sulfur_diesel", {type: "techreborn:diesel_generator", power: 130, fluid: "jsonreg:ultra_low_sulfur_diesel"});
// 硝基柴油
<recipetype:techreborn:diesel_generator>.addJsonRecipe("oil.burn.trdiesel/nitro_diesel", {type: "techreborn:diesel_generator", power: 400, fluid: "techreborn:nitro_diesel"});
// 硝基碳燃油
<recipetype:techreborn:diesel_generator>.addJsonRecipe("oil.burn.trdiesel/nitrocoal_fuel", {type: "techreborn:diesel_generator", power: 400, fluid: "techreborn:nitrocoal_fuel"});
// 汽油
<recipetype:techreborn:diesel_generator>.addJsonRecipe("oil.burn.trdiesel/gasoline", {type: "techreborn:diesel_generator", power: 75, fluid: "jsonreg:gasoline"});
// 硝酸乙酯
<recipetype:techreborn:diesel_generator>.addJsonRecipe("oil.burn.trdiesel/ethyl_nitrate", {type: "techreborn:diesel_generator", power: 300, fluid: "jsonreg:ethyl_nitrate"});
// 裂解汽油
<recipetype:techreborn:diesel_generator>.addJsonRecipe("oil.burn.trdiesel/pyrolysis_gasoline", {type: "techreborn:diesel_generator", power: 80, fluid: "jsonreg:pyrolysis_gasoline"});
// 苯
<recipetype:techreborn:diesel_generator>.addJsonRecipe("oil.burn.trdiesel/benzene", {type: "techreborn:diesel_generator", power: 70, fluid: "jsonreg:benzene"});
// 甲苯
<recipetype:techreborn:diesel_generator>.addJsonRecipe("oil.burn.trdiesel/toluene", {type: "techreborn:diesel_generator", power: 68, fluid: "jsonreg:toluene"});
// 二甲苯
<recipetype:techreborn:diesel_generator>.addJsonRecipe("oil.burn.trdiesel/xylene", {type: "techreborn:diesel_generator", power: 66, fluid: "jsonreg:xylene"});
// 减压柴油 (轻质柴油，放入柴油发电机)
<recipetype:techreborn:diesel_generator>.addJsonRecipe("oil.burn.trdiesel/vacuum_diesel", {type: "techreborn:diesel_generator", power: 90, fluid: "jsonreg:vacuum_diesel"});
// 焦化轻油 (也可用柴油发电机)
<recipetype:techreborn:diesel_generator>.addJsonRecipe("oil.burn.trdiesel/coker_light_oil", {type: "techreborn:diesel_generator", power: 55, fluid: "jsonreg:coker_light_oil"});

// ========== TR 燃气发电机配方 ==========
// 氢气
<recipetype:techreborn:gas_generator>.addJsonRecipe("oil.burn.trgas/hydrogen", {type: "techreborn:gas_generator", power: 15, fluid: "techreborn:hydrogen"});
// 甲烷
<recipetype:techreborn:gas_generator>.addJsonRecipe("oil.burn.trgas/methane", {type: "techreborn:gas_generator", power: 40, fluid: "techreborn:methane"});
// 燃料气
<recipetype:techreborn:gas_generator>.addJsonRecipe("oil.burn.trgas/fuel_gas", {type: "techreborn:gas_generator", power: 40, fluid: "jsonreg:fuel_gas"});
// 乙烯
<recipetype:techreborn:gas_generator>.addJsonRecipe("oil.burn.trgas/ethylene", {type: "techreborn:gas_generator", power: 50, fluid: "jsonreg:ethylene"});
// 丙烯
<recipetype:techreborn:gas_generator>.addJsonRecipe("oil.burn.trgas/propylene", {type: "techreborn:gas_generator", power: 48, fluid: "jsonreg:propylene"});
// 丁二烯
<recipetype:techreborn:gas_generator>.addJsonRecipe("oil.burn.trgas/butadiene", {type: "techreborn:gas_generator", power: 45, fluid: "jsonreg:butadiene"});
// 氨
<recipetype:techreborn:gas_generator>.addJsonRecipe("oil.burn.trgas/ammonia", {type: "techreborn:gas_generator", power: 20, fluid: "jsonreg:ammonia"});
// 焦化气
<recipetype:techreborn:gas_generator>.addJsonRecipe("oil.burn.trgas/coke_gas", {type: "techreborn:gas_generator", power: 35, fluid: "jsonreg:coke_gas"});
// ========== PBI 副产物燃烧配方 ==========

// --- 纯硝基苯 (nitrobenzene) ---
<recipetype:oritech:fuel_generator>.addJsonRecipe("oil.burn.orfuelgen/nitrobenzene", {type: "oritech:fuel_generator", results: [], time: 18, fluidInput: {fluid: "jsonreg:nitrobenzene", amount: 8100}, ingredients: []});
<recipetype:techreborn:diesel_generator>.addJsonRecipe("oil.burn.trdiesel/nitrobenzene", {type: "techreborn:diesel_generator", power: 90, fluid: "jsonreg:nitrobenzene"});
// --- 纯苯胺 (aniline) ---
<recipetype:oritech:fuel_generator>.addJsonRecipe("oil.burn.orfuelgen/aniline", {type: "oritech:fuel_generator", results: [], time: 16, fluidInput: {fluid: "jsonreg:aniline", amount: 8100}, ingredients: []});
<recipetype:techreborn:diesel_generator>.addJsonRecipe("oil.burn.trdiesel/aniline", {type: "techreborn:diesel_generator", power: 80, fluid: "jsonreg:aniline"});

//其他配方

//蒸馏海水出盐水，4:1
<recipetype:techreborn:distillation_tower>.addJsonRecipe("oil.process.tr.water_distill", {type: "techreborn:distillation_tower",
    time: 100,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:brine"}},
    ],
    power:32,
    ingredients:[
      {count: 5, components: {"techreborn:fluid": "minecraft:water"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});


//各大有机产物压板配方
<recipetype:techreborn:compressor>.addJsonRecipe("oil.other.eopxy_ingot", {type: "techreborn:compressor",
    time: 200,
    outputs: [
        {id: "jsonreg:epoxy_resin_ingot", count: 1}
    ],
    power: 32,
    ingredients: [
        {item: "jsonreg:epoxy_resin", count: 2}
    ]
});
<recipetype:techreborn:compressor>.addJsonRecipe("oil.other.eopxy_plate", {type: "techreborn:compressor",
    time: 200,
    outputs: [
        {id: "jsonreg:epoxy_resin_plate", count: 1}
    ],
    power: 10,
    ingredients: [
        {item: "jsonreg:epoxy_resin_ingot", count: 1}
    ]
});
<recipetype:techreborn:compressor>.addJsonRecipe("oil.other.polyethylene_ingot", {type: "techreborn:compressor",
    time: 200,
    outputs: [
        {id: "jsonreg:polyethylene_ingot", count: 1}
    ],
    power: 32,
    ingredients: [
        {item: "jsonreg:polyethylene_pellets", count: 2}
    ]
});
<recipetype:techreborn:compressor>.addJsonRecipe("oil.other.polyethylene_plate", {type: "techreborn:compressor",
    time: 200,
    outputs: [
        {id: "jsonreg:polyethylene_plate", count: 1}
    ],
    power: 10,
    ingredients: [
        {item: "jsonreg:polyethylene_ingot", count: 1}
    ]
});

// 十分科学的化学方程式
// H2S生成SO2 2H2S + 3O2 → 2SO2 + 2H2O，这里直接简化成两个亚硫酸了
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("oil.other.sulfurous_acid_from_h2s",{
  type:"techreborn:chemical_reactor",
  time:100,
  outputs:[
    {id: "techreborn:cell", count: 2, components: {"techreborn:fluid": "jsonreg:sulfurous_acid"}},
    {id: "techreborn:cell", count: 3}
  ],
  power:16,
  ingredients:[
    {count: 2, components: {"techreborn:fluid": "jsonreg:hydrogen_sulfide"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
    {count: 3, components: {"techreborn:fluid": "techreborn:compressed_air"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
  ]
});
//硫酸 2H2SO3+O2 == 2H2SO4
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("oil.other.sulfur_acid_from_h2so3",{
  type:"techreborn:chemical_reactor",
  time:100,
  outputs:[
    {id: "techreborn:cell", count: 2, components: {"techreborn:fluid": "oritech:still_sulfuric_acid"}},
    {id: "techreborn:cell", count: 1}
  ],
  power:16,
  ingredients:[
    {count: 2, components: {"techreborn:fluid": "jsonreg:sulfurous_acid"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
    {count: 1, components: {"techreborn:fluid": "techreborn:compressed_air"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
  ]
});
//二氧化硫的电解
<recipetype:techreborn:industrial_electrolyzer>.addJsonRecipe("oil.other.sulfur_from_so2",{
  type:"techreborn:industrial_electrolyzer",
  time:100,
  outputs:[
    {id: "techreborn:sulfur_dust", count:1},
    {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "techreborn:compressed_air"}}
  ],
  power:16,
  ingredients:[
    {count: 1, components: {"techreborn:fluid": "jsonreg:hydrogen_sulfide"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});
//化学反应釜 二氧化硫氧化成三氧化硫 2SO2+O2=2SO3
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("oil.other.so2_oxidation",{
  type:"techreborn:chemical_reactor",
  time:200,
  outputs:[
    {id: "techreborn:cell", count: 2, components: {"techreborn:fluid": "jsonreg:sulfur_trioxide"}},
    {id: "techreborn:cell", count: 1}
  ],
  power:16,
  ingredients:[
    {count: 2, components: {"techreborn:fluid": "jsonreg:sulfur_dioxide"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
    {count: 1, components: {"techreborn:fluid": "techreborn:compressed_air"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
  ]
});
//化反 三氧化硫变硫酸 SO3+H2O==H2SO4
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("oil.other.so3_to_h2so4",{
  type:"techreborn:chemical_reactor",
  time:200,
  outputs:[
    {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "oritech:still_sulfuric_acid"}},
    {id: "techreborn:cell", count: 1}
  ],
  power:16,
  ingredients:[
    {count: 1, components: {"techreborn:fluid": "jsonreg:sulfur_trioxide"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
    {count: 1, components: {"techreborn:fluid": "minecraft:water"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
  ]
});

//三大空气 缺一不可

//分馏
<recipetype:techreborn:distillation_tower>.addJsonRecipe("oil.process.tr.air_separation", {type: "techreborn:distillation_tower",
    time: 200,
    outputs: [
        {id: "techreborn:cell", count: 3, components: {"techreborn:fluid": "techreborn:nitrogen"}},
        {id: "techreborn:cell", count: 3, components: {"techreborn:fluid": "techreborn:compressed_air"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:argon"}}
    ],
    power: 32,
    ingredients: [
        {count: 3, components: {"techreborn:fluid": "jsonreg:low_oxygen_nitrogen"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 4, base: {item: "techreborn:cell"}, components: {"techreborn:fluid": "minecraft:empty"},  "fabric:type": "fabric:components"}
    ]
});
<recipetype:techreborn:distillation_tower>.addJsonRecipe("oil.process.tr.air_separation_nether", {type: "techreborn:distillation_tower",
    time: 200,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "techreborn:nitrogen"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:coke_gas"}},
        {id: "techreborn:cell", count: 4, components: {"techreborn:fluid": "jsonreg:sulfur_dioxide"}}
    ],
    power: 32,
    ingredients: [
        {count: 3, components: {"techreborn:fluid": "jsonreg:nether_air"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 3, base: {item: "techreborn:cell"}, components: {"techreborn:fluid": "minecraft:empty"},  "fabric:type": "fabric:components"}
    ]
});
<recipetype:techreborn:distillation_tower>.addJsonRecipe("oil.process.tr.air_separation_end", {type: "techreborn:distillation_tower",
    time: 200,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "techreborn:helium3"}},
        {id: "techreborn:cell", count: 3, components: {"techreborn:fluid": "techreborn:nitrogen_dioxide"}},
        {id: "techreborn:cell", count: 2, components: {"techreborn:fluid": "techreborn:helium"}}
    ],
    power: 32,
    ingredients: [
        {count: 3, components: {"techreborn:fluid": "jsonreg:end_air"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 3, base: {item: "techreborn:cell"}, components: {"techreborn:fluid": "minecraft:empty"},  "fabric:type": "fabric:components"}
    ]
});
<recipetype:techreborn:distillation_tower>.addJsonRecipe("oil.process.tr.air_separation_starlight", {type: "techreborn:distillation_tower",
    time: 200,
    outputs: [
        {id: "techreborn:cell", count: 3, components: {"techreborn:fluid": "techreborn:nitrogen"}},
        {id: "techreborn:cell", count: 3, components: {"techreborn:fluid": "techreborn:compressed_air"}},
        {id: "jsonreg:tiny_photon_dust", count: 1}
    ],
    power: 32,
    ingredients: [
        {count: 3, components: {"techreborn:fluid": "jsonreg:starlight_air"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 4, base: {item: "techreborn:cell"}, components: {"techreborn:fluid": "minecraft:empty"},  "fabric:type": "fabric:components"}
    ]
});
//制造
<recipetype:techreborn:compressor>.removeByName("techreborn:compressor/compressed_air_cell");
<recipetype:techreborn:compressor>.addJsonRecipe("oil.other.air_overworld",{
    type: "techreborn:compressor",
    power:16,
    time:100,
    ingredients: [
        {item:"techreborn:cell",count:2}
    ],
    outputs: [
        {id:"techreborn:cell",count:2,components:{"techreborn:fluid":"jsonreg:low_oxygen_nitrogen"}},
    ]
});
<recipetype:lychee:item_inside>.addJsonRecipe("oil.other.air_nether",{ 
    type: "lychee:item_inside",
    item_in: {"item":"techreborn:cell"},
    block_in: {"blocks":"minecraft:nether_portal"},
    post: [
      {"type":"drop_item",id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:nether_air"}}
    ]
});
<recipetype:lychee:item_inside>.addJsonRecipe("oil.other.air_end",{ 
    type: "lychee:item_inside",
    item_in: {"item":"techreborn:cell"},
    block_in: {"blocks":"minecraft:end_portal"},
    post: [
      {"type":"drop_item",id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:end_air"}}
    ]
});
<recipetype:lychee:item_inside>.addJsonRecipe("oil.other.air_starlight",{ 
    type: "lychee:item_inside",
    item_in: {"item":"techreborn:cell"},
    block_in: {"blocks":"eternal_starlight:starlight_portal"},
    post: [
      {"type":"drop_item",id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:starlight_air"}}
    ]
});
// 反向制造末地空气 & BOT末地气瓶
<recipetype:techreborn:large_chemical_reactor>.addJsonRecipe("oil.tr.largechemical.nonoseparation_end", {type: "techreborn:large_chemical_reactor",
    time: 200,
    outputs: [
        {id: "techreborn:cell", count: 3, components: {"techreborn:fluid": "jsonreg:end_air"}},
        {id: "techreborn:cell", count: 3}
    ],
    power: 32,
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "techreborn:helium3"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 3, components: {"techreborn:fluid": "techreborn:nitrogen_dioxide"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 2, components: {"techreborn:fluid": "techreborn:helium"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
    ]
});

// 3NO2+H2O=2HNO3 一氧化氮被我吃了
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("oil.other.nitric_acid",{ 
    type: "techreborn:chemical_reactor",
    time:80,
    power:16,
    outputs:[
        {id: "techreborn:cell", count: 2, components: {"techreborn:fluid": "jsonreg:nitric_acid"}},
        {id: "techreborn:cell", count: 2}
    ],
    ingredients:[
        {count: 3, components: {"techreborn:fluid": "techreborn:nitrogen_dioxide"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 1, components: {"techreborn:fluid": "minecraft:water"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});
//神秘化学，电解亚氯酸盐
<recipetype:techreborn:industrial_electrolyzer>.addJsonRecipe("oil.other.tr.electrolyze_chlorite", {type: "techreborn:industrial_electrolyzer",
    time: 200,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:chlorine"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "techreborn:sodium"}},
        {id: "techreborn:cell", count: 2, components: {"techreborn:fluid": "techreborn:compressed_air"}}
    ],
    power: 32,
    ingredients: [
        {count: 2, components: {"techreborn:fluid": "techreborn:chlorite"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 2, base: {item: "techreborn:cell"}, components: {"techreborn:fluid": "minecraft:empty"},  "fabric:type": "fabric:components"}
    ]
});

//油砂处理
<recipetype:techreborn:grinder>.addJsonRecipe("oil.other.tr.normalgrind_oilsand", {type: "techreborn:grinder",
    time: 80,
    outputs: [
        {id: "jsonreg:oil_sand_dust", count: 2}
    ],
    power: 8,
    ingredients: [
        {count: 1, item: "jsonreg:oil_sand_ore"}
    ]
});
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("oil.other.tr.industrialgrind_oilsand", {type: "techreborn:industrial_grinder",
    time: 80,
    outputs: [
        {id: "jsonreg:oil_sand_dust", count: 3}
    ],
    power: 8,
    fluid: {fluid: {fluid: "minecraft:water"}, amount: {value: 81000}}, 
    ingredients: [
        {count: 1, item: "jsonreg:oil_sand_ore"}
    ]
});
//工业离心，1->1B
<recipetype:techreborn:centrifuge>.addJsonRecipe("oil.other.tr.centrifuge_oilsand", {type: "techreborn:centrifuge",
    time: 80,
    outputs: [
        {id: "minecraft:sand", count: 8},
        {id: "techreborn:cell", count: 8, components: {"techreborn:fluid": "techreborn:oil"}}],
    power: 16,
    ingredients: [{count: 8, item: "jsonreg:oil_sand_dust"}]});
//小离心，1->0.5B
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("oil.other.or.centrifuge_oilsand_low", {type: "oritech:centrifuge_fluid",
    results: [{id: "minecraft:sand", count: 1}],
    fluidOutputs: [{fluid: "techreborn:oil", amount: 40005}],
    time: 80,
    ingredients: [{count: 1, item: "jsonreg:oil_sand_dust"}]
});

//正式的塑料片整合
<recipetype:oritech:centrifuge_fluid>.removeByName("oritech:centrifuge/fluid/plasticbio");
<recipetype:oritech:centrifuge_fluid>.removeByName("oritech:centrifuge/fluid/plasticoil");
<recipetype:oritech:centrifuge_fluid>.removeByName("oritech:centrifuge/fluid/plasticbiobetter");
<recipetype:oritech:centrifuge_fluid>.removeByName("oritech:centrifuge/fluid/plasticoilbetter");
<recipetype:oritech:centrifuge_fluid>.removeByName("oritech:centrifuge/fluid/naptharesin"); //OR作者把“石脑油”拼错了！

//盐矿石处理，只有小研磨
<recipetype:techreborn:grinder>.addJsonRecipe("oil.other.tr.normalgrind_salt", {type: "techreborn:grinder",
    time: 80,
    outputs: [
        {id: "jsonreg:salt_dust", count: 4}
    ],
    power: 8,
    ingredients: [
        {count: 1, item: "jsonreg:salt_ore"}
    ]
});
<recipetype:techreborn:grinder>.addJsonRecipe("oil.other.tr.normalgrind_rocksalt", {type: "techreborn:grinder",
    time: 80,
    outputs: [
        {id: "jsonreg:rock_salt_dust", count: 4}
    ],
    power: 8,
    ingredients: [
        {count: 1, item: "jsonreg:rock_salt_ore"}
    ]
});
//电解之
<recipetype:techreborn:industrial_electrolyzer>.addJsonRecipe("oil.other.tr.electrolyze_salt", {type: "techreborn:industrial_electrolyzer",
    time: 200,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:chlorine"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "techreborn:sodium"}}
    ],
    power: 32,
    ingredients: [
        {count: 1, item: "jsonreg:salt_dust"},
        {count: 2, base: {item: "techreborn:cell"}, components: {"techreborn:fluid": "minecraft:empty"},  "fabric:type": "fabric:components"}
    ]
});
<recipetype:techreborn:industrial_electrolyzer>.addJsonRecipe("oil.other.tr.electrolyze_rocksalt", {type: "techreborn:industrial_electrolyzer",
    time: 200,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:chlorine"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "techreborn:potassium"}}
    ],
    power: 32,
    ingredients: [
        {count: 1, item: "jsonreg:rock_salt_dust"},
        {count: 2, base: {item: "techreborn:cell"}, components: {"techreborn:fluid": "minecraft:empty"},  "fabric:type": "fabric:components"}
    ]
});

