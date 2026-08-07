注：Oritech 的流体单位均为 81000 为 1000mB.
注意：工业磨粉机的流体输入格式很特别。
注意：TR机器配方中描述流体单元，输入中的方法和输出的方法中不一样。
- 输入中的方法： {count: 16, components: {"techreborn:fluid": "命名空间:你的流体"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
- 输出中的方法： {id: "techreborn:cell", count: 15, components: {"techreborn:fluid": "oritech:still_sulfuric_acid"}},

# 工业磨粉机 TR
```
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("oritech:compat/techreborn/industrial_grinder/nickel", {type: "techreborn:industrial_grinder",
        outputs: [{id: "techreborn:nickel_dust", count: 1}, {id: "oritech:small_nickel_dust", count: 3}, {id: "oritech:small_platinum_dust", count: 2}], 
        time: 200, 
        fluid: {fluid: {fluid: "minecraft:water"}, amount: {value: 81000}}, 
        power: 5, 
        ingredients: [{tag: "c:raw_materials/nickel"}]
    });

  <recipetype:techreborn:industrial_grinder>.addJsonRecipe("techreborn:industrial_grinder/diamond_small_dust_from_heart_of_the_sea_with_water", {type: "techreborn:industrial_grinder", outputs: [{id: "techreborn:diamond_small_dust", count: 3}, {id: "techreborn:titanium_small_dust", count: 3}, {id: "techreborn:platinum_small_dust", count: 2}, {id: "techreborn:iridium_nugget", count: 3}], time: 100, fluid: {fluid: {fluid: "minecraft:water"}, amount: {value: 81000}}, power: 64, ingredients: [{item: "minecraft:heart_of_the_sea"}]});
```

# 工业离心机 TR
```
<recipetype:techreborn:centrifuge>.addJsonRecipe("techreborn:centrifuge/basalt_dust", {type: "techreborn:centrifuge",
    time: 2040,
    outputs: [
        {id: "techreborn:peridot_dust", count: 1},
        {id: "techreborn:calcite_dust", count: 3},
        {id: "techreborn:flint_dust", count: 8},
        {id: "techreborn:dark_ashes_dust", count: 4}],
    power: 10,
    ingredients: [{count: 16, item: "techreborn:basalt_dust"}]});
```

# 精炼机 OR
```
<recipetype:oritech:refinery>.addJsonRecipe("oritech:refinery/siliconwashing", {type: "oritech:refinery",
    results: [{id: "oritech:silicon", count: 4}],
    fluidOutputs: [
        {fluid: "oritech:still_steam", amount: 4000},
        {fluid: "oritech:still_sulfuric_acid", amount: 8100},
        {fluid: "oritech:still_sheol_fire", amount: 16200}
    ],
    time: 160,
    fluidInput: {fluid: "oritech:still_silicon_wash",amount: 8100}, // 100 mB
    ingredients: [{tag: "minecraft:sand"}]
});
```

# 蒸馏塔 TR
```
<recipetype:techreborn:distillation_tower>.addJsonRecipe("crafttweaker:uni.techreborn.distillation_tower/cell", {type: "techreborn:distillation_tower",
    time: 400,
    outputs: [
        {id: "techreborn:cell", count: 16, components: {"techreborn:fluid": "techreborn:diesel"}},
        {id: "techreborn:cell", count: 15, components: {"techreborn:fluid": "oritech:still_sulfuric_acid"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "techreborn:glyceryl"}}],
    power: 20,
    ingredients: [
        {count: 16, components: {"techreborn:fluid": "minecraft:empty"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 16, components: {"techreborn:fluid": "techreborn:oil"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
        ]
});
```

# 电高 TR
```
<recipetype:techreborn:blast_furnace>.addJsonRecipe("techreborn:blast_furnace/silicon_cell", {type: "techreborn:blast_furnace",
    outputs: [
        {id: "techreborn:cell", count: 2, components: {"techreborn:fluid": "techreborn:silicon"}},
        {id: "techreborn:cell", count: 2, components: {"techreborn:fluid": "techreborn:compressed_air"}}
    ],
    time: 1000,
    heat: 1500,
    power: 128,
    ingredients: [
        {item: "techreborn:quartz_dust", count: 2},
        {count: 4, components: {"techreborn:fluid": "techreborn:carbon"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
        ]
});
```

# 冰箱 TR
```
<recipetype:techreborn:vacuum_freezer>.addJsonRecipe("techreborn:vacuum_freezer/tungstensteel_ingot", {type: "techreborn:vacuum_freezer",
    time: 440,
    outputs: [
        {id: "techreborn:tungstensteel_ingot", count: 1}
    ],
    power: 60,
    ingredients: [
        {item: "techreborn:hot_tungstensteel_ingot"}
    ]
});
```

# 化学反应釜 TR
```
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("techreborn:chemical_reactor/glowstone", {type: "techreborn:chemical_reactor",
    time: 400,
    outputs: [
        {id: "minecraft:glowstone", count: 1}
    ],
    power: 30,
    ingredients: [
        {tag: "c:small_dusts/glowstone", count: 6},
        {item: "minecraft:sea_lantern"}
    ]
});
 ```

# 工业电解 TR
```
<recipetype:techreborn:industrial_electrolyzer>.addJsonRecipe("techreborn:industrial_electrolyzer/aluminum_dust", {type: "techreborn:industrial_electrolyzer",
    time: 2000,
    outputs: [
        {id: "techreborn:aluminum_dust", count: 8},
        {id: "techreborn:titanium_small_dust", count: 2},
        {id: "techreborn:cell", count: 5, components: {"techreborn:fluid": "techreborn:hydrogen"}},
        {id: "techreborn:cell", count: 3, components: {"techreborn:fluid": "techreborn:compressed_air"}}
    ],
    power: 60,
    ingredients: [
        {item: "techreborn:bauxite_dust", count: 12},
        {count: 8, components: {"techreborn:fluid": "minecraft:empty"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});
```

# 小离心 OR
```
//带流体
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("crafttweaker:t2.oritech.centrifuge/uu", {type: "oritech:centrifuge_fluid",
    results: [{id: "techreborn:uu_matter", count: 4}],
    fluidOutputs: [{fluid: "oritech:still_mineral_slurry", amount: 20250}],
    time: 800,
    fluidInput: {fluid: "oritech:still_strange_matter", amount: 80500},
    ingredients: [{tag: "minecraft:sand"}]
});

//不带流体
<recipetype:oritech:centrifuge>.addJsonRecipe("oritech:centrifuge/redstoneuran", {type: "oritech:centrifuge",
    time: 100,
    results: [{id: "oritech:small_uranium_dust", count: 1}],
    ingredients: [{tag: "c:dusts/redstone"}]
});
```
# 组装机 OR
```
<recipetype:oritech:assembler>.addJsonRecipe("t1.oritech.assembler/carbon_fibre_strands", 
    {type: "oritech:assembler", fluidOutput: {fluid: "minecraft:empty", amount: 0}, 
    results: [{id: "oritech:carbon_fibre_strands", count: 4}], 
    time: 100, fluidInput: {fluid: "minecraft:empty", amount: 0}, 
    ingredients: [
        {item: "techreborn:carbon_fiber"},
        {item: "techreborn:carbon_fiber"},
        {item: "techreborn:refined_iron_plate"},
        {item: "techreborn:carbon_fiber"}
    ]});
```
# 聚爆 TR
```
<recipetype:techreborn:implosion_compressor>.addJsonRecipe("crafttweaker:t3.implosion_compressor/infinity_ingot", {type: "techreborn:implosion_compressor",
    time: 1000,
    outputs: [
        {id: "avaritia:infinity_ingot", count: 1},
        {id: "techreborn:uu_matter", count: 4}
    ],
    power: 600,
    ingredients: [
        {item: "oritech:nuke"},
        {count: 2, item: "avaritia:neutronium_ingot"}
    ]
});
```

# 装配 TR
```
<recipetype:techreborn:assembling_machine>.addJsonRecipe("techreborn:assembling_machine/advanced_circuit", {type: "techreborn:assembling_machine",
    time: 200,
    outputs: [
        {id: "techreborn:advanced_circuit", count: 1}
    ],
    power: 20,
    ingredients: [
        {tag: "c:plates/silicon"},
        {tag: "c:plates/electrum", count: 2}
    ]
});
```

# 魔力灌注 BOT
```
<recipetype:botania:mana_infusion>.addJsonRecipe("botania:mana_infusion/acacia_leaves_dupe", {type: "botania:mana_infusion",
    input: {item: "minecraft:acacia_leaves"},
    output: {id: "minecraft:acacia_leaves", count: 2},
    catalyst: {block: "botania:conjuration_catalyst", type: "botania:block"},
    mana: 2000
});
```

# 合金炉 TR
```
<recipetype:techreborn:alloy_smelter>.addJsonRecipe("crafttweaker:techreborn.alloy_smelter/steel_ingot_starter", {type: "techreborn:alloy_smelter", 
    time: 800,
    outputs: [{id: "techreborn:steel_ingot", count: 1}],
    power: 6,
    ingredients: [{item: "techreborn:refined_iron_ingot", count: 2}, {tag: "c:dusts/coal"}]
});
```

# 原子锻炉 OR
```
<recipetype:oritech:atomic_forge>.addJsonRecipe("oritech:atomicforge/wafer", {type: "oritech:atomic_forge",
    time: 5,
    results: [
        {id: "oritech:silicon_wafer", count: 1}
    ],
    ingredients: [
        {tag: "c:carbon_fibre"},
        {tag: "c:silicon"},
        {tag: "c:silicon"}
    ]
});
```

# 合金炉 ETS
```
<recipetype:eternal_starlight:alloy>.addJsonRecipe("eternal_starlight:unrealium", {type: "eternal_starlight:alloy",
    burn_time: 400,
    results: [{amount: 1, item: {id: "eternal_starlight:unrealium_ingot", count: 1}}],
    ingredients: [
        {tag: "c:ingots/deepsilver"},
        {tag: "c:ingots/golem_steel"},
        {tag: "c:gems/malarite"},
        {item: "eternal_starlight:soul_dew"}
    ]
});
```

# 压缩机/卷板机 TR
```
<recipetype:techreborn:compressor>.addJsonRecipe("techreborn:compressor/zinc_plate_from_block", {type: "techreborn:compressor",
    time: 300,
    outputs: [{id: "techreborn:zinc_plate", count: 9}],
    power: 10,
    ingredients: [{tag: "c:storage_blocks/zinc"}]
});
```

# 小磨粉 TR
```
<recipetype:techreborn:grinder>.addJsonRecipe("techreborn:grinder/zinc_dust_from_block", {type: "techreborn:grinder", time: 1500, outputs: [{id: "techreborn:zinc_dust", count: 9}], power: 5, ingredients: [{tag: "c:storage_blocks/zinc"}]});
```

# 强化组装 AFF
请用数据包