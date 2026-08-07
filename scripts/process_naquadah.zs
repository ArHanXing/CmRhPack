import crafttweaker.api.tag.MCTag;
import crafttweaker.api.ingredient.type.IIngredientEmpty;
import crafttweaker.api.ingredient.IIngredient;

<recipetype:techreborn:industrial_grinder>.addJsonRecipe("nqdh.1.crushed", {type: "techreborn:industrial_grinder",
        outputs: [{id: "jsonreg:crushed_naquadah_ore", count: 1}, {id: "jsonreg:tiny_naquadah_dust", count: 2}, {id: "oritech:small_gold_dust", count: 2}], 
        time: 200, 
        fluid: {fluid: {fluid: "minecraft:water"}, amount: {value: 81000}}, 
        power: 64, 
        ingredients: [{item:"jsonreg:raw_naquadah",count:1}]
    });
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("nqdh.1.crushed.sodium_persulfate", {type: "techreborn:industrial_grinder",
        outputs: [{id: "jsonreg:crushed_naquadah_ore", count: 2}], 
        time: 200, 
        fluid: {fluid: {fluid: "techreborn:sodium_persulfate"}, amount: {value: 81000}}, 
        power: 64, 
        ingredients: [{item:"jsonreg:raw_naquadah",count:1}]
    });

<recipetype:techreborn:centrifuge>.addJsonRecipe("nqdh.2.centrifuge", {type: "techreborn:centrifuge",
    time: 160,
    outputs: [
        {id: "jsonreg:impure_enriched_naquadah_dust", count: 1},
        {id: "jsonreg:naquadah_dust", count: 4}
    ],
    power: 64,
    ingredients: [{count: 2, item: "jsonreg:crushed_naquadah_ore"}]});

<recipetype:oritech:refinery>.addJsonRecipe("nqdh.3.refinery", {type: "oritech:refinery",
    results: [],
    fluidOutputs: [
        {fluid: "jsonreg:impure_enriched_naquadah_solution", amount: 162000}
    ],
    time: 160,
    fluidInput: {fluid: "oritech:still_sulfuric_acid",amount: 162000},
    ingredients: [{item:"jsonreg:impure_enriched_naquadah_dust",count:10}]
});

<recipetype:techreborn:centrifuge>.addJsonRecipe("nqdh.4.centrifuge", {type: "techreborn:centrifuge",
    time: 400,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:enriched_naquadah_solution"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:waste_enriched_naquadah_solution"}}
    ],
    power: 64,
    ingredients: [
        {count: 2, components: {"techreborn:fluid": "jsonreg:impure_enriched_naquadah_solution"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

<recipetype:oritech:refinery>.addJsonRecipe("nqdh.5a.refinery2", {type: "oritech:refinery",
    results: [{id: "techreborn:cell", count: 1}],
    fluidOutputs: [
        {fluid: "jsonreg:acidic_enriched_naquadah_solution", amount: 243000}
    ],
    time: 100,
    fluidInput: {fluid: "oritech:still_sulfuric_acid",amount: 162000},
    ingredients: [{count: 1, components: {"techreborn:fluid": "jsonreg:enriched_naquadah_solution"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}]
});

<recipetype:techreborn:centrifuge>.addJsonRecipe("nqdh.5b.centrifuge2", {type: "techreborn:centrifuge",
    time: 800,
    outputs: [
        {id: "techreborn:cell", count: 4, components: {"techreborn:fluid": "jsonreg:waste_enriched_naquadah_solution"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:fluorine"}},
        {id: "jsonreg:enriched_naquadah_sulfate_dust", count:6},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "oritech:still_sulfuric_acid"}}
    ],
    power: 64,
    ingredients: [
        {count: 6, components: {"techreborn:fluid": "jsonreg:acidic_enriched_naquadah_solution"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

<recipetype:techreborn:blast_furnace>.addJsonRecipe("nqdh.6.ebf", {type: "techreborn:blast_furnace",
    outputs: [
        {id: "jsonreg:hot_enriched_naquadah_ingot", count: 3},
        {id: "techreborn:cell", count: 6, components: {"techreborn:fluid": "oritech:still_sulfuric_acid"}}
    ],
    time: 1000,
    heat: 2000,
    power: 128,
    ingredients: [
        {item: "jsonreg:enriched_naquadah_sulfate_dust", count: 3},
        {count: 6, components: {"techreborn:fluid": "techreborn:hydrogen"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
        ]
});

<recipetype:techreborn:vacuum_freezer>.addJsonRecipe("nqdh.7.freeze", {type: "techreborn:vacuum_freezer",
    time: 400,
    outputs: [
        {id: "jsonreg:enriched_naquadah_ingot", count: 1}
    ],
    power: 64,
    ingredients: [
        {item: "jsonreg:hot_enriched_naquadah_ingot"}
    ]
});

<recipetype:techreborn:distillation_tower>.addJsonRecipe("nqdh.re.waste_enriched_naquadah_solution", {type: "techreborn:distillation_tower",
    time: 300,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:enriched_naquadah_solution"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "oritech:still_sulfuric_acid"}},
        {id: "techreborn:cell", count: 4}
    ],
    power: 32,
    ingredients: [
        {count: 6, components: {"techreborn:fluid": "jsonreg:waste_enriched_naquadah_solution"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// 超能硅岩
// ========== 阶段一：控爆粉碎 — 工业磨粉机 (HV, 氩气保护) ==========
/*
//他妈的这个东西就是跑不起来，但是下面那个可以，世界未解之谜
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("nqdria.1.grinder", {
    type: "techreborn:industrial_grinder",
    outputs: [
        {id: "jsonreg:crushed_naquadria_ore", count: 10}
    ],
    time: 400,
    fluid: {fluid: {fluid: "jsonreg:argon"}, amount: {value: 81000}},
    power: 32,
    ingredients: [
        {item: "jsonreg:raw_naquadria", count: 10}
    ]
});*/
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("wtf", {type: "techreborn:industrial_grinder",
        outputs: [{id: "jsonreg:crushed_naquadria_ore", count: 10}, {id: "jsonreg:naquadah_dust", count: 8}, {id: "oritech:gold_dust", count: 3}], 
        time: 200, 
        fluid: {fluid: {fluid: "jsonreg:argon"}, amount: {value: 81000}}, 
        power: 64, 
        ingredients: [{item:"jsonreg:raw_naquadria",count:10}]
    });
// ========== 阶段二：重液浮选 — 离心机 (EV, 氟碳流体) ==========
<recipetype:techreborn:centrifuge>.addJsonRecipe("nqdria.2.centrifuge", {
    type: "techreborn:centrifuge",
    time: 300,
    outputs: [
        {id: "jsonreg:refined_crushed_naquadria_ore", count: 10},
        {id: "jsonreg:depleted_uranium_slag", count: 20},
        {id: "techreborn:cell", count: 2}
    ],
    power: 64,
    ingredients: [
        {item: "jsonreg:crushed_naquadria_ore", count: 10},
        {count: 2, components: {"techreborn:fluid": "jsonreg:fluorocarbon_heavy_liquid"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// ========== 阶段三：氢氟酸浸出 — 精炼机 (IV) ==========
<recipetype:oritech:refinery>.addJsonRecipe("nqdria.3.refinery", {
    type: "oritech:refinery",
    results: [],
    fluidOutputs: [
        {fluid: "jsonreg:crude_naquadria_acid_solution", amount: 648000},
        {fluid: "jsonreg:insoluble_slurry", amount: 162000}
    ],
    time: 600,
    fluidInput: {fluid: "jsonreg:hydrofluoric_acid", amount: 810000},
    ingredients: [
        {item: "jsonreg:refined_crushed_naquadria_ore", count: 10}
    ]
});

// ========== 阶段四a：第一级离心 (EV) ==========
<recipetype:techreborn:centrifuge>.addJsonRecipe("nqdria.4a.centrifuge", {
    type: "techreborn:centrifuge",
    time: 300,
    outputs: [
        {id: "techreborn:cell", count: 5, components: {"techreborn:fluid": "jsonreg:rich_naquadria_acid_solution"}},
        {id: "techreborn:cell", count: 2, components: {"techreborn:fluid": "jsonreg:gallium_germanium_fluoride_mixture"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:hydrofluoric_acid"}}
    ],
    power: 64,
    ingredients: [
        {count: 8, components: {"techreborn:fluid": "jsonreg:crude_naquadria_acid_solution"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// ========== 阶段四b：第二级离心 (IV) ==========
<recipetype:techreborn:centrifuge>.addJsonRecipe("nqdria.4b.centrifuge", {
    type: "techreborn:centrifuge",
    time: 350,
    outputs: [
        {id: "techreborn:cell", count: 3, components: {"techreborn:fluid": "jsonreg:high_purity_naquadria_acid_solution"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:polonium_radium_fluoride"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:thorium_concentrate"}}
    ],
    power: 64,
    ingredients: [
        {count: 5, components: {"techreborn:fluid": "jsonreg:rich_naquadria_acid_solution"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// ========== 阶段四c：第三级离心 (LuV) ==========
<recipetype:techreborn:centrifuge>.addJsonRecipe("nqdria.4c.centrifuge", {
    type: "techreborn:centrifuge",
    time: 400,
    outputs: [
        {id: "techreborn:cell", count: 2, components: {"techreborn:fluid": "jsonreg:purified_naquadria_acid_solution"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:lawrencium_actinide_tailings"}}
    ],
    power: 64,
    ingredients: [
        {count: 3, components: {"techreborn:fluid": "jsonreg:high_purity_naquadria_acid_solution"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// ========== 阶段五：沉淀转化 — 精炼机 (LuV, 氨水) ==========
<recipetype:oritech:refinery>.addJsonRecipe("nqdria.5.refinery", {
    type: "oritech:refinery",
    results: [
        {id: "jsonreg:naquadria_hydroxide_precipitate", count: 1}
    ],
    fluidOutputs: [
        {fluid: "jsonreg:ammonium_fluoride_waste", amount: 243000}
    ],
    time: 500,
    fluidInput: {fluid: "jsonreg:purified_naquadria_acid_solution", amount: 162000},
    ingredients: [
        {count: 4, components: {"techreborn:fluid": "jsonreg:ammonia_solution"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// ========== 阶段六：煅烧脱氨 — 工业高炉 (HV, 低氧) ==========
<recipetype:techreborn:blast_furnace>.addJsonRecipe("nqdria.6.blast_furnace", {
    type: "techreborn:blast_furnace",
    time: 800,
    heat: 600,
    power: 128,
    outputs: [
        {id: "jsonreg:naquadria_oxide_dust", count: 1},
        {id: "techreborn:cell", count: 2, components: {"techreborn:fluid": "jsonreg:steam_ammonia_mixture"}}
    ],
    ingredients: [
        {item: "jsonreg:naquadria_hydroxide_precipitate", count: 1},
        {count: 2, components: {"techreborn:fluid": "jsonreg:low_oxygen_nitrogen"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// ========== 阶段七：金属热还原 — 工业高炉 (LuV, 钙蒸气) ==========
<recipetype:techreborn:blast_furnace>.addJsonRecipe("nqdria.7.blast_furnace", {
    type: "techreborn:blast_furnace",
    time: 1200,
    heat: 2400,
    power: 128,
    outputs: [
        {id: "jsonreg:sponge_naquadria", count: 1},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {item: "jsonreg:naquadria_oxide_dust", count: 1},
        {count: 1, components: {"techreborn:fluid": "jsonreg:argon"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// ========== 阶段八：真空升华精炼 — 蒸馏塔 (ZPM) ==========
<recipetype:techreborn:distillation_tower>.addJsonRecipe("nqdria.8.distillation", {
    type: "techreborn:distillation_tower",
    time: 2400,
    power: 128,
    outputs: [
        {id: "jsonreg:flawless_naquadria_gem", count: 1},
        {id: "jsonreg:sublimation_residue", count: 1}
    ],
    ingredients: [
        {item: "jsonreg:sponge_naquadria", count: 1}
    ]
});

// ========== 阶段九a：晶体磨粉 — 工业磨粉机 ==========
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("nqdria.9a.grinder", {
    type: "techreborn:industrial_grinder",
    time: 200,
    power: 16,
    outputs: [
        {id: "jsonreg:naquadria_dust", count: 1}
    ],
    fluid: {fluid: {fluid: "jsonreg:argon"}, amount: {value: 81000}},
    ingredients: [
        {item: "jsonreg:flawless_naquadria_gem", count: 1}
    ]
});

<recipetype:techreborn:blast_furnace>.addJsonRecipe("nqdria.final.ebf", {type: "techreborn:blast_furnace",
    outputs: [
        {id: "jsonreg:hot_naquadria_ingot", count: 1},
        {id: "techreborn:cell", count: 2}
    ],
    time: 1000,
    heat: 2000,
    power: 128,
    ingredients: [
        {item: "jsonreg:naquadria_dust", count: 1},
        {count: 2, components: {"techreborn:fluid": "jsonreg:argon"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
        ]
});

<recipetype:techreborn:vacuum_freezer>.addJsonRecipe("nqdria.final.freeze", {type: "techreborn:vacuum_freezer",
    time: 400,
    outputs: [
        {id: "jsonreg:naquadria_ingot", count: 1}
    ],
    power: 64,
    ingredients: [
        {item: "jsonreg:hot_naquadria_ingot"}
    ]
});

//修复一些东西
//离心水蒸气-氨气，出蒸汽和氨气 2:1
<recipetype:techreborn:centrifuge>.addJsonRecipe("nqdria.misc.steam_ammonia_centrifuge", {type: "techreborn:centrifuge",
    time: 200,
    outputs: [
        {id: "techreborn:cell", count: 2, components: {"techreborn:fluid": "oritech:still_steam"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:ammonia"}}
    ],
    power: 64,
    ingredients: [
        {count: 3, components: {"techreborn:fluid": "jsonreg:steam_ammonia_mixture"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});
//氨水来源
//直接合成，哈哈哈
//电解氟化铵废液
<recipetype:techreborn:industrial_electrolyzer>.addJsonRecipe("nqdria.misc.nh3cl", {
    type: "techreborn:industrial_electrolyzer",
    time:200,
    power:32,
    ingredients: [
        {count: 2, components: {"techreborn:fluid": "jsonreg:ammonium_fluoride_waste"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ],
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:ammonia"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:chlorine"}}
    ]
});

//副产物
//不溶浆料蒸馏出氢氟酸和不溶残渣
<recipetype:techreborn:distillation_tower>.addJsonRecipe("nqdria.misc.insoluble_residue_distillation", {
    type: "techreborn:distillation_tower",
    time:200,
    power:64,
    ingredients: [
        {count: 3, components: {"techreborn:fluid": "jsonreg:insoluble_slurry"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ],
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:hydrofluoric_acid"}},
        {id: "jsonreg:insoluble_residue", count:1},
        {id: "techreborn:cell", count:2}
    ]
});
//不溶残渣离心，微量Ir粉
<recipetype:techreborn:centrifuge>.addJsonRecipe("nqdria.misc.insoluble_residue_centrifuge", {
    type: "techreborn:centrifuge",
    time: 80,
    outputs: [
        {id: "techreborn:iridium_nugget"},
    ],
    power: 32,
    ingredients: [
        {count: 6, item: "jsonreg:insoluble_residue"}
    ]
});
//氢氟酸 H+F==HF
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("nqdria.misc.hf",{ 
    type: "techreborn:chemical_reactor",
    time:20,
    power:8,
    outputs:[
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:hydrofluoric_acid"}}
    ],
    ingredients:[
        {count: 1, components: {"techreborn:fluid": "jsonreg:fluorine"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 1, components: {"techreborn:fluid": "techreborn:hydrogen"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

//贫铀合金板
<recipetype:techreborn:blast_furnace>.addJsonRecipe("nqdria.misc.depleted_uranium_dense_plate.ebf", {type: "techreborn:blast_furnace",
    outputs: [
        {id: "jsonreg:depleted_uranium_dense_plate", count: 1}
    ],
    time: 800,
    heat: 2400,
    power: 128,
    ingredients: [
        {item: "techreborn:titanium_plate", count: 1},
        {item:"jsonreg:depleted_uranium_slag", count: 1}
    ]
});

//电解GaGeF2
<recipetype:techreborn:industrial_electrolyzer>.addJsonRecipe("nqdria.misc.gagef2mixture", {
    type: "techreborn:industrial_electrolyzer",
    time:200,
    power:32,
    ingredients: [
        {item: "techreborn:cell", count: 2, components: {"techreborn:fluid": "jsonreg:gallium_germanium_fluoride_mixture"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ],
    outputs: [
        {count: 2, id:"techreborn:cell", components: {"techreborn:fluid": "jsonreg:hydrofluoric_acid"}},
        {count: 1, id:"jsonreg:gallium_dust"},
        {count: 1, id:"jsonreg:germanium_dust"}
    ]
});

//锗掺杂
<recipetype:oritech:atomic_forge>.addJsonRecipe("nqdria.msic.germanium_wafer", {type: "oritech:atomic_forge",
    time: 5,
    results: [
        {id: "jsonreg:germanium_wafer", count: 2}
    ],
    ingredients: [
        {item: "jsonreg:germanium_dust"},
        {item: "oritech:silicon_wafer"},
        {item: "oritech:silicon_wafer"}
    ]
});
<recipetype:oritech:atomic_forge>.addJsonRecipe("nqdria.msic.germanium_wafer_advcomp_alt_wip", {type: "oritech:atomic_forge",
    time: 5,
    results: [
        {id: "oritech:advanced_computing_engine", count: 2}
    ],
    ingredients: [
        {item: "oritech:processing_unit"},
        {item: "jsonreg:germanium_wafer"},
        {item: "jsonreg:germanium_wafer"}
    ]
});

//镓冷却剂
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("nqdria.misc.gallium_coolant",{ 
    type: "techreborn:chemical_reactor",
    time:20,
    power:8,
    outputs:[
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:gallium_coolant"}}
    ],
    ingredients:[
        {count: 1, item: "jsonreg:gallium_dust"},
        {count: 1, components: {"techreborn:fluid": "minecraft:water"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});
//TODO 目前这个东西不知道干什么

//氟碳重液
// ========== 1. 四氟乙烯 (TFE) ==========
// 乙烯 + 氟气 → 四氟乙烯
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("nqdria.fluocarbon.tfe", {
    type: "techreborn:chemical_reactor",
    time: 300,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:tetrafluoroethylene"}}
    ],
    power: 64,
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:ethylene"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 1, components: {"techreborn:fluid": "jsonreg:fluorine"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// ========== 2. 全氟碳齐聚 (得到混合物) ==========
// 四氟乙烯在高压下齐聚，产生不同链长的全氟碳
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("nqdria.fluocarbon.oligomerization", {
    type: "techreborn:chemical_reactor",
    time: 400,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:perfluorocarbon_mix"}}
    ],
    power: 128,
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:tetrafluoroethylene"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 1, components: {"techreborn:fluid": "techreborn:nitrogen"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"} // 惰性保护气
    ]
});

// ========== 3. 氟碳重液分馏 ==========
<recipetype:techreborn:distillation_tower>.addJsonRecipe("nqdria.fluocarbon.heavy_liquid", {
    type: "techreborn:distillation_tower",
    time: 400,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:fluorocarbon_heavy_liquid"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:perfluoro_light_oil"}},
        {id: "techreborn:cell", count: 1} // 空单元回收
    ],
    power: 64,
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:perfluorocarbon_mix"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 2, item: "techreborn:cell"}
    ]
});