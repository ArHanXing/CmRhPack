import crafttweaker.api.tag.MCTag;
import crafttweaker.api.recipe.type.Recipe;

//手搓煤粉
craftingTable.addShapeless("t1.coal_dust_from_charcoal", <item:techreborn:coal_dust> *4, [<item:minecraft:charcoal>]);

//中子态素收集
<recipetype:avaritia:extreme_crafting>.remove(<item:avaritia:neutron_collector>);
<recipetype:botania:mana_infusion>.addJsonRecipe("t1.bot.manainfusion.holywood_bucket", {type: "botania:mana_infusion",
    input: {item: "earlystage:wooden_bucket"},
    output: {id: "jsonreg:holy_wooden_bucket"},
    mana: 2000
});
//基础机器外壳
craftingTable.remove(<item:techreborn:basic_machine_frame>);
<recipetype:oritech:assembler>.addJsonRecipe("t1.oritech.assembler/basic_machine_frame", 
{type: "oritech:assembler", 
fluidOutput: {fluid: "minecraft:empty", amount: 0}, 
results: [{id: "techreborn:basic_machine_frame", count: 1}], time: 20, 
fluidInput: {fluid: "minecraft:empty", amount: 0}, 
ingredients: [{item:"techreborn:refined_iron_ingot"}, {item:"techreborn:refined_iron_ingot"}, {item:"techreborn:refined_iron_ingot"}, {item: "minecraft:redstone"}]});

//删除ori的便宜碳纤维
<recipetype:oritech:centrifuge>.removeByName("oritech:centrifuge/carbon");
//精炼铁慢慢烧吧,jpg
furnace.remove(<item:techreborn:refined_iron_ingot>);
blastFurnace.remove(<item:techreborn:refined_iron_ingot>);
furnace.remove(<item:techreborn:refined_iron_plate>);
blastFurnace.remove(<item:techreborn:refined_iron_plate>);
blastFurnace.addRecipe("t1.blastfurnace.refined_iron_nugget", <item:techreborn:refined_iron_nugget>, <item:minecraft:iron_nugget>, 1.0, 200);
furnace.addRecipe("t1.furnace.refined_iron_nugget", <item:techreborn:refined_iron_nugget>, <item:minecraft:iron_nugget>, 1.0, 200);
//快速配方
<recipetype:oritech:foundry>.addJsonRecipe("t1.oritech.foundry/refined_iron", {type: "oritech:foundry", 
    fluidOutput: {fluid: "minecraft:empty", amount: 0}, 
    results: [{id: "techreborn:refined_iron_ingot", count: 2}], 
    time: 200, 
    fluidInput: {fluid: "minecraft:empty", amount: 0}, 
    ingredients: [{tag: "c:ingots/iron"}, {tag: "c:ingots/iron"}]});
<recipetype:techreborn:blast_furnace>.addJsonRecipe("t1.techreborn.blast_furnace/refined_irong", {type: "techreborn:blast_furnace", 
    outputs: [{id: "techreborn:refined_iron_ingot", count: 3}], 
    time: 100, heat: 750, power: 128, 
    ingredients: [{tag: "c:ingots/iron"}, {tag: "c:ingots/iron"}]});

//防护板
craftingTable.remove(<item:oritech:nickel_plating_block>);//镍强化护板
craftingTable.addShaped("t1.oritech.crafting/nickel_plating", <item:oritech:nickel_plating_block> * 2, 
    [[<item:techreborn:refined_iron_plate>, <tag:item:c:ingots/steel>, <item:techreborn:refined_iron_plate>], 
    [<tag:item:c:ingots/steel>, <tag:item:c:ingots/nickel>, <tag:item:c:ingots/steel>], 
    [<item:techreborn:refined_iron_plate>, <tag:item:c:ingots/steel>, <item:techreborn:refined_iron_plate>]]);
craftingTable.remove(<item:oritech:iron_plating_block>);//铁强化护板
craftingTable.addShaped("t1.oritech.crafting/iron_plating", <item:oritech:iron_plating_block> * 2, 
    [[<item:techreborn:refined_iron_plate>, <tag:item:c:ingots/steel>, <item:techreborn:refined_iron_plate>], 
    [<tag:item:c:ingots/steel>, <tag:item:c:ingots/iron>, <tag:item:c:ingots/steel>], 
    [<item:techreborn:refined_iron_plate>, <tag:item:c:ingots/steel>, <item:techreborn:refined_iron_plate>]]);
craftingTable.remove(<item:oritech:machine_plating_block>);//铜强化护板
craftingTable.addShaped("t1.oritech.crafting/copper_plating", <item:oritech:machine_plating_block> * 2, 
    [[<item:techreborn:refined_iron_plate>, <tag:item:c:ingots/steel>, <item:techreborn:refined_iron_plate>], 
    [<tag:item:c:ingots/steel>, <item:minecraft:copper_ingot>, <tag:item:c:ingots/steel>], 
    [<item:techreborn:refined_iron_plate>, <tag:item:c:ingots/steel>, <item:techreborn:refined_iron_plate>]]);

//铸造器
craftingTable.remove(<item:oritech:foundry_block>);
craftingTable.addShaped("t1.oritech.crafting/foundry", <item:oritech:foundry_block>, [
    [<item:techreborn:brass_plate>, <tag:item:c:ingots/copper>, <item:techreborn:brass_plate>], 
    [<tag:item:c:ingots/copper>, <item:oritech:motor>, <tag:item:c:ingots/copper>], 
    [<tag:item:c:ingots/electrum>, <item:techreborn:basic_machine_frame>, <tag:item:c:ingots/electrum>]]);

//母岩的简单配方
<recipetype:oritech:assembler>.remove(<item:minecraft:budding_amethyst>);
<recipetype:lychee:block_interacting>.addJsonRecipe("t1.lychee.budding_amethyst",{
  "type": "lychee:block_interacting",
  "item_in": "oritech:enderic_compound",
  "block_in": "minecraft:amethyst_block",
  "post": [
    "place minecraft:budding_amethyst"
  ]
});

//橡胶板
<recipetype:techreborn:compressor>.addJsonRecipe("t1.tr.rubber_plate", {type: "techreborn:compressor",
    time: 60,
    outputs: [{id: "jsonreg:rubber_plate", count: 1}],
    power: 16,
    ingredients: [{item: "techreborn:rubber"}]
});
//T1马达
<recipetype:oritech:assembler>.removeByName("oritech:assembler/motor");
<recipetype:oritech:assembler>.removeByName("oritech:assembler/magnet");
<recipetype:oritech:assembler>.addJsonRecipe("t1.or.magnet", {type: "oritech:assembler",
    time: 40, results: [{id: "oritech:magnetic_coil", count: 4}],
    ingredients: [
        {item: "techreborn:copper_cable"},
        {item: "jsonreg:steel_rod"},
        {item: "techreborn:copper_cable"}
    ]
});
<recipetype:oritech:assembler>.addJsonRecipe("t1.or.t1motor", {type: "oritech:assembler",
    time: 40, results: [{id: "oritech:motor", count: 2}],
    ingredients: [
        {item: "jsonreg:copper_rod"},
        {item: "techreborn:steel_ingot"},
        {item: "oritech:magnetic_coil"},
        {item: "oritech:magnetic_coil"}
    ]
});

//碳棒（网）的更难合成
<recipetype:oritech:assembler>.addJsonRecipe("t1.oritech.assembler/carbon_fibre_strands", 
{type: "oritech:assembler", fluidOutput: {fluid: "minecraft:empty", amount: 0}, results: [{id: "oritech:carbon_fibre_strands", count: 4}], 
time: 100, fluidInput: {fluid: "minecraft:empty", amount: 0}, 
ingredients: [{item: "techreborn:carbon_fiber"}, {item: "techreborn:carbon_fiber"}, {item: "techreborn:refined_iron_plate"}, {item: "techreborn:carbon_fiber"}]});

craftingTable.remove(<item:techreborn:carbon_mesh>);
<recipetype:oritech:assembler>.addJsonRecipe("t1.oritech.assembler/carbon_mesh", 
{type: "oritech:assembler", fluidOutput: {fluid: "minecraft:empty", amount: 0}, results: [{id: "techreborn:carbon_mesh", count: 2}], 
time: 60, fluidInput: {fluid: "minecraft:empty", amount: 0}, 
ingredients: [{item: "oritech:iron_dust"}, {item: "oritech:carbon_fibre_strands"}, {item: "techreborn:refined_iron_plate"}, {item: "oritech:carbon_fibre_strands"}]});

//高级合金锭固定为(Cu₃Zn)(Fe₃Ni)(AgAu)也就是青铜x殷钢x琥珀金
craftingTable.remove(<item:techreborn:mixed_metal_ingot>);
craftingTable.addShaped("t1.techreborn.crafting/mixed_metal", <item:techreborn:mixed_metal_ingot> * 2, 
    [[<item:techreborn:bronze_ingot>, <item:techreborn:bronze_ingot>, <item:techreborn:bronze_ingot>], 
    [<item:techreborn:invar_ingot>, <item:techreborn:invar_ingot>, <item:techreborn:invar_ingot>], 
    [<item:techreborn:electrum_ingot>,<item:techreborn:electrum_ingot>, <item:techreborn:electrum_ingot>]]);

//高级tr壳子
craftingTable.remove(<item:techreborn:advanced_machine_frame>);
<recipetype:oritech:assembler>.addJsonRecipe("t1.oritech.assembler/advanced_machine_frame", 
{type: "oritech:assembler", fluidOutput: {fluid: "minecraft:empty", amount: 0}, results: [{id: "techreborn:advanced_machine_frame", count: 2}], 
time: 80, fluidInput: {fluid: "minecraft:empty", amount: 0}, 
ingredients: [{item: "techreborn:advanced_alloy_plate"}, {item: "techreborn:carbon_plate"}, {item: "techreborn:basic_machine_frame"}, {item: "oritech:plastic_sheet"}]});

//一级贴片电路元件
function _smd_assembler(nm as string, i1 as string, i2 as string, i3 as string, rslt as string) as void{
    <recipetype:oritech:assembler>.addJsonRecipe(nm, {type: "oritech:assembler",
    results: [{id: rslt, count: 2}], 
    time: 80,
    ingredients: [
        {item: i1},
        {item: i2},
        {item: i3}
    ]});
}
_smd_assembler("t1.ori.assembler/capacitor","jsonreg:iron_rod","techreborn:iron_plate","jsonreg:polyethylene_plate","jsonreg:smd_capacitor");
_smd_assembler("t1.ori.assembler/diode","techreborn:copper_cable","minecraft:glass","techreborn:tin_ingot","jsonreg:smd_diode");
_smd_assembler("t1.ori.assembler/inductor","techreborn:copper_cable","techreborn:steel_ingot","jsonreg:polyethylene_ingot","jsonreg:smd_inductor");
_smd_assembler("t1.ori.assembler/resistor","techreborn:sap","minecraft:paper","techreborn:coal_dust","jsonreg:smd_resistor");
_smd_assembler("t1.ori.assembler/transistor","techreborn:tin_cable","techreborn:silicon_plate","jsonreg:polyethylene_ingot","jsonreg:smd_transistor");
// T1 处理器
<recipetype:oritech:assembler>.removeByName("oritech:assembler/processingunit");
//高级电路板，及其SoC配方
craftingTable.remove(<item:techreborn:advanced_circuit>);
<recipetype:techreborn:assembling_machine>.removeByName("techreborn:assembling_machine/advanced_circuit");
<recipetype:oritech:assembler>.addJsonRecipe("t1.oritech.assembler/advanced_circuit", 
    {type: "oritech:assembler", fluidOutput: {fluid: "minecraft:empty", amount: 0}, results: [{id: "techreborn:advanced_circuit", count: 2}], 
    time: 80, fluidInput: {fluid: "minecraft:empty", amount: 0}, 
    ingredients: [
        {item: "techreborn:electrum_plate"},
        {item: "techreborn:electronic_circuit"},
        {item: "techreborn:electronic_circuit"},
        {item: "oritech:flux_gate"}
    ]});
<recipetype:oritech:assembler>.addJsonRecipe("t1.oritech.assembler/advanced_circuit/soc", 
    {type: "oritech:assembler", fluidOutput: {fluid: "minecraft:empty", amount: 0}, results: [{id: "techreborn:advanced_circuit", count: 8}], 
    time: 80, fluidInput: {fluid: "minecraft:empty", amount: 0}, 
    ingredients: [
        {item: "techreborn:electrum_plate"},
        {item: "oritech:advanced_computing_engine"},
        {item: "oritech:advanced_computing_engine"},
        {item: "oritech:plastic_sheet"}
    ]});

//普通电路板的SoC配方
<recipetype:oritech:assembler>.addJsonRecipe("t1.oritech.assembler/electronic_circuit/soc", 
{type: "oritech:assembler", fluidOutput: {fluid: "minecraft:empty", amount: 0}, results: [{id: "techreborn:electronic_circuit", count: 8}], 
time: 80, fluidInput: {fluid: "minecraft:empty", amount: 0}, 
ingredients: [{item: "techreborn:refined_iron_plate"}, {item: "oritech:processing_unit"}, {item: "oritech:processing_unit"}, {item: "minecraft:redstone"}]});

//无尽箱
craftingTable.addShaped("t1.infchest", <item:avaritia:infinity_chest>, [
    [<item:minecraft:air>, <item:minecraft:barrel>, <item:minecraft:air>], 
    [<item:minecraft:air>, <item:techreborn:basic_machine_frame>, <item:minecraft:air>], 
    [<item:techreborn:steel_plate>, <item:techreborn:basic_storage_unit>, <item:techreborn:steel_plate>]]);

//T1末地烛
craftingTable.remove(<item:justarod:redstone_rod>);
craftingTable.addShaped("t1.jar.redstone_rod", <item:justarod:redstone_rod>, [
    [<item:minecraft:air>, <item:techreborn:rubber>, <item:minecraft:air>], 
    [<item:minecraft:redstone>, <item:minecraft:end_rod>, <item:minecraft:redstone>], 
    [<item:techreborn:steel_plate>, <item:oritech:processing_unit>, <item:techreborn:steel_plate>]]);

//ori更新了，小小兼容
craftingTable.remove(<item:oritech:polymer_resin>);

//风电和它的转子
<recipetype:techreborn:assembling_machine>.removeByName("techreborn:assembling_machine/wind_mill");
//铁粉...
<recipetype:techreborn:grinder>.addJsonRecipe("t1.tr.grinder.iron_dust", {type: "techreborn:grinder",
    time: 20,
    outputs: [{id: "oritech:iron_dust", count: 1}],
    power: 5,
    ingredients: [{tag: "c:ingots/iron"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("t1.tr.grinder.copper_dust", {type: "techreborn:grinder",
    time: 20,
    outputs: [{id: "oritech:copper_dust", count: 1}],
    power: 5,
    ingredients: [{tag: "c:ingots/copper"}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("t1.tr.grinder.gold_dust", {type: "techreborn:grinder",
    time: 20,
    outputs: [{id: "oritech:gold_dust", count: 1}],
    power: 5,
    ingredients: [{tag: "c:ingots/gold"}]
});

// 硅 板
<recipetype:techreborn:compressor>.addJsonRecipe("t1.techreborn.compressor/silicon_plate", {type: "techreborn:compressor",
    time: 300,
    outputs: [{id: "techreborn:silicon_plate", count: 1}],
    power: 10,
    ingredients: [{item:"oritech:silicon"}]
});