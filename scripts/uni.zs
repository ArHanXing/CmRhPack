import crafttweaker.api.recipe.type.Recipe;
import crafttweaker.api.tag.MCTag;

//钢的配方，理论上ori的是下位，tr的是上位
<recipetype:oritech:foundry>.removeByName("oritech:foundry/alloy/steel");
<recipetype:oritech:foundry>.removeByName("oritech:foundry/alloy/biosteel");
<recipetype:techreborn:alloy_smelter>.removeByName("oritech:compat/techreborn/alloysmelter/biosteel");
<recipetype:techreborn:alloy_smelter>.addJsonRecipe("techreborn.alloy_smelter/steel_ingot_starter", {type: "techreborn:alloy_smelter", time: 800, outputs: [{id: "techreborn:steel_ingot", count: 1}], power: 6, ingredients: [{item: "techreborn:refined_iron_ingot", count: 2}, {tag: "c:dusts/coal"}]});
<recipetype:oritech:foundry>.addJsonRecipe("oritech.foundry/alloy/steel", {type: "oritech:foundry", fluidOutput: {fluid: "minecraft:empty", amount: 0}, results: [{id: "techreborn:steel_ingot", count: 1}], time: 400, fluidInput: {fluid: "minecraft:empty", amount: 0}, ingredients: [{tag: "c:ingots/iron"}, {tag: "c:dusts/coal"}]});
//ori的是20s, tr的是5s/4s, 那个byd合金炉40s
<recipetype:techreborn:blast_furnace>.removeByName("techreborn:blast_furnace/steel_ingot_from_refined_iron");
<recipetype:techreborn:blast_furnace>.removeByName("techreborn:blast_furnace/steel_ingot_from_refined_iron_and_carbon");
<recipetype:techreborn:blast_furnace>.addJsonRecipe("techreborn.blast_furnace/steel_ingot_from_refined_iron", {type: "techreborn:blast_furnace", outputs: [{id: "techreborn:steel_ingot", count: 1}, {id: "techreborn:dark_ashes_dust", count: 2}], time: 100, heat: 1000, power: 128, ingredients: [{item: "minecraft:iron_ingot"}, {tag: "c:dusts/coal", count: 1}]});
<recipetype:techreborn:blast_furnace>.addJsonRecipe("techreborn.blast_furnace/steel_ingot_from_refined_iron_and_carbon", {type: "techreborn:blast_furnace", outputs: [{id: "techreborn:steel_ingot", count: 1}, {id: "techreborn:cell", count: 2}], time: 80, heat: 750, power: 128, ingredients: [{item: "minecraft:iron_ingot"}, {count: 2, components: {"techreborn:fluid": "techreborn:carbon"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}]});

//顺带删掉别的几个合成配方，都给我上合金炉
craftingTable.removeByName("oritech:crafting/alloy/steel");
craftingTable.removeByName("oritech:crafting/alloy/electrum");
craftingTable.removeByName("oritech:crafting/alloy/adamant");
//ori琥珀金别用了
<recipetype:oritech:foundry>.removeByName("oritech:foundry/alloy/electrum");
<recipetype:techreborn:alloy_smelter>.removeByName("oritech:compat/techreborn/alloysmelter/oritech_electrum");

//机器核心修改
craftingTable.remove(<item:oritech:machine_core_1>);
craftingTable.remove(<item:oritech:machine_core_2>);
craftingTable.remove(<item:oritech:machine_core_3>);
craftingTable.remove(<item:oritech:machine_core_4>);
craftingTable.remove(<item:oritech:machine_core_5>);
craftingTable.remove(<item:oritech:machine_core_6>);
craftingTable.remove(<item:oritech:machine_core_7>);
craftingTable.addShaped("uni.oritech.crafting/core2", <item:oritech:machine_core_2>, [
    [<item:minecraft:iron_ingot>, <item:techreborn:nickel_ingot>,<item:minecraft:iron_ingot>],
    [<item:techreborn:refined_iron_ingot>, <item:minecraft:redstone>,<item:techreborn:refined_iron_ingot>],
    [<item:minecraft:iron_ingot>,<item:techreborn:refined_iron_ingot>,<item:minecraft:iron_ingot>]]);
//公式化套娃
craftingTable.addShaped("uni.oritech.crafting/core3", <item:oritech:machine_core_3>, [[<tag:item:c:carbon_fibre>, <tag:item:c:carbon_fibre>, <tag:item:c:carbon_fibre>], [<tag:item:c:carbon_fibre>, <item:oritech:machine_core_2>, <tag:item:c:carbon_fibre>], [<tag:item:c:carbon_fibre>, <tag:item:c:carbon_fibre>, <tag:item:c:carbon_fibre>]]);
craftingTable.addShaped("uni.oritech.crafting/core4", <item:oritech:machine_core_4>, [[<tag:item:oritech:plating>, <item:oritech:machine_core_3>, <tag:item:oritech:plating>], [<tag:item:oritech:plating>, <item:oritech:enderic_compound>, <tag:item:oritech:plating>], [<tag:item:oritech:plating>, <tag:item:oritech:plating>, <tag:item:oritech:plating>]]);
craftingTable.addShaped("uni.oritech.crafting/core5", <item:oritech:machine_core_5>, [[<item:oritech:adamant_ingot>, <item:oritech:machine_core_4>, <item:oritech:adamant_ingot>], [<item:oritech:adamant_ingot>, <item:oritech:advanced_computing_engine>, <item:oritech:adamant_ingot>], [<item:oritech:adamant_ingot>, <item:oritech:adamant_ingot>, <item:oritech:adamant_ingot>]]);
craftingTable.addShaped("uni.oritech.crafting/core6", <item:oritech:machine_core_6>, [[<item:oritech:duratium_ingot>, <item:oritech:machine_core_5>, <item:oritech:duratium_ingot>], [<item:oritech:duratium_ingot>, <item:oritech:dubios_container>, <item:oritech:duratium_ingot>], [<item:oritech:duratium_ingot>, <item:oritech:duratium_ingot>, <item:oritech:duratium_ingot>]]);
craftingTable.addShaped("uni.oritech.crafting/core7", <item:oritech:machine_core_7>, [[<item:oritech:prometheum_ingot>, <item:oritech:machine_core_6>, <item:oritech:prometheum_ingot>], [<item:oritech:prometheum_ingot>, <item:oritech:superconductor>, <item:oritech:prometheum_ingot>], [<item:oritech:prometheum_ingot>, <item:oritech:prometheum_ingot>, <item:oritech:prometheum_ingot>]]);

//统一为Ori硅
furnace.removeByName("refinedstorage:silicon");
<tag:item:c:silicon>.remove(<item:refinedstorage:silicon>);

//移除铸造的11超模配方
<recipetype:oritech:foundry>.removeByName("oritech:foundry/alloy/compat/techreborn/brass");
<recipetype:oritech:foundry>.removeByName("oritech:foundry/alloy/compat/techreborn/bronze");
<recipetype:oritech:foundry>.removeByName("oritech:foundry/alloy/compat/techreborn/invar");
<recipetype:oritech:foundry>.removeByName("oritech:foundry/alloy/netherite");

//移除错误配方
<recipetype:techreborn:distillation_tower>.removeByName("oritech:compat/techreborn/distillation/oil");
<recipetype:techreborn:industrial_electrolyzer>.removeByName("techreborn:industrial_electrolyzer/cell_7");
<recipetype:techreborn:industrial_electrolyzer>.addJsonRecipe("fix.techreborn.industrial_electrolyzer/cell_7", {type: "techreborn:industrial_electrolyzer", time: 1400, 
outputs: [
    {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "techreborn:carbon"}}
    ], power: 50, 
ingredients: [
    {item: "techreborn:coal_dust"}, 
    {base: {item: "techreborn:cell"}, "fabric:type": "fabric:components", components: {"techreborn:fluid": "minecraft:empty"}}]});

//统一Ori硫酸
<recipetype:techreborn:chemical_reactor>.removeByName("techreborn:chemical_reactor/sulfuric_acid");
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("uni.techreborn.chemical_reactor/sulfuric_acid", {type: "techreborn:chemical_reactor", 
    time: 1200, outputs: [
        {id: "techreborn:cell", count: 2, 
        components: {"techreborn:fluid": "oritech:still_sulfuric_acid"}}
        ], 
        power: 30, 
        ingredients: [
            {base: {item: "techreborn:cell"}, 
            components: {"techreborn:fluid": "techreborn:sulfur"}, 
            "fabric:type": "fabric:components"
            },
            {base: {item: "techreborn:cell"}, 
            "fabric:type": "fabric:components", 
            components: {"techreborn:fluid": "minecraft:water"}}]});
<recipetype:techreborn:industrial_electrolyzer>.removeByName("techreborn:industrial_electrolyzer/cell_18");
<recipetype:techreborn:industrial_electrolyzer>.addJsonRecipe("uni.techreborn.industrial_electrolyzer/cell_18", {type: "techreborn:industrial_electrolyzer", 
    time: 1400, outputs: [
        {id: "techreborn:cell", count: 2,
         components: {"techreborn:fluid": "techreborn:hydrogen"}},
        {id: "techreborn:cell", count: 1,
         components: {"techreborn:fluid": "techreborn:sulfur"}},
        {id: "techreborn:cell", count: 2,
         components: {"techreborn:fluid": "techreborn:compressed_air"}}],
        power: 100,
        ingredients: [
            {count: 5, 
            components: {"techreborn:fluid": "oritech:still_sulfuric_acid"}, 
            base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}]});

//修复因为便携罐子的合成问题
craftingTable.removeByName("oritech:crafting/exoboostedelytraalt");
craftingTable.removeByName("oritech:crafting/exojetpack");
craftingTable.addShaped("fix.oritech.crafting/exoboostedelytraalt", <item:oritech:jetpack_exo_elytra>, [
    [<item:oritech:ion_thruster>, <item:oritech:ion_thruster>, <item:oritech:ion_thruster>], 
    [<item:oritech:ion_thruster>, <item:oritech:jetpack_elytra>, <item:oritech:ion_thruster>], 
    [<item:techreborn:basic_tank_unit>, <item:oritech:exo_chestplate>, <item:techreborn:basic_tank_unit>]]);
craftingTable.addShaped("fix.oritech.crafting/exojetpack", <item:oritech:exo_jetpack>, [
    [<item:oritech:ion_thruster>, <item:oritech:ion_thruster>, <item:oritech:ion_thruster>], 
    [<item:oritech:ion_thruster>, <item:oritech:exo_chestplate>, <item:oritech:ion_thruster>], 
    [<item:techreborn:basic_tank_unit>, <item:oritech:jetpack>, <item:techreborn:basic_tank_unit>]]);

//硅变为单元
<recipetype:techreborn:alloy_smelter>.addJsonRecipe("uni.silicon2cell", {type: "techreborn:alloy_smelter", 
    time: 80,
    outputs: [{id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "techreborn:silicon"}}],
    power: 6,
    ingredients: [{item: "oritech:silicon", count: 1}, {item: "techreborn:cell", count: 1}]
});

//导线问题
/*
铜：3出6，组装机配方1出4 / 橡胶
金：3出4，组装机配方2出4 / 聚乙烯
银：3出4，没有组装机批处理 / 环氧树脂
*/
<recipetype:oritech:assembler>.addJsonRecipe("uni.insulated.copper_batch", {type: "oritech:assembler",
    time: 40, results: [{id: "techreborn:insulated_copper_cable", count: 4}],
    ingredients: [
        {item: "minecraft:copper_ingot"},
        {item: "jsonreg:rubber_plate"},
        {item: "jsonreg:rubber_plate"}
    ]
});
<recipetype:oritech:assembler>.addJsonRecipe("uni.insulated.gold_batch", {type: "oritech:assembler",
    time: 40, results: [{id: "techreborn:insulated_gold_cable", count: 4}],
    ingredients: [
        {item: "minecraft:gold_ingot"},
        {item: "jsonreg:polyethylene_plate"},
        {item: "jsonreg:polyethylene_plate"},
        {item: "minecraft:gold_ingot"}
    ]
});
<recipetype:oritech:assembler>.addJsonRecipe("uni.insulated.silver", {type: "oritech:assembler",
    time: 40, results: [{id: "techreborn:insulated_hv_cable", count: 1}],
    ingredients: [
        {item: "techreborn:hv_cable"},
        {item: "jsonreg:polyethylene_plate"},
        {item: "jsonreg:epoxy_resin_plate"},
        {item: "jsonreg:epoxy_resin_plate"}
    ]
});

//碳粉！tmd碳粉！改为TR的
<recipetype:oritech:pulverizer>.removeByName("oritech:pulverizer/coal");
<recipetype:oritech:pulverizer>.addJsonRecipe("uni.oritech.pulverizer/coal", {type: "oritech:pulverizer", time: 100, results: [{id: "techreborn:coal_dust", count: 1}], ingredients: [{tag: "minecraft:coals"}]});
<recipetype:oritech:grinder>.removeByName("oritech:grinder/coal");
<recipetype:oritech:grinder>.addJsonRecipe("uni.oritech.grinder/coal", {type: "oritech:grinder", time: 40, results: [{id: "techreborn:coal_dust", count: 1}], ingredients: [{tag: "minecraft:coals"}]});