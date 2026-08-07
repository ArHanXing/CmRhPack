import crafttweaker.api.tag.MCTag;
import crafttweaker.api.recipe.type.Recipe;

//RS部分

//处理器
furnace.removeByName("refinedstorage:basic_processor");
furnace.removeByName("refinedstorage:improved_processor");
furnace.removeByName("refinedstorage:advanced_processor");
<recipetype:oritech:assembler>.addJsonRecipe("t1.ori.assembler/rs.basic_processor", 
    {type: "oritech:assembler", 
    fluidOutput: {fluid: "minecraft:empty", amount: 0}, 
    results: [{id: "refinedstorage:basic_processor", count: 4}], time: 30, 
    fluidInput: {fluid: "minecraft:empty", amount: 0}, 
    ingredients: [
        {item:"oritech:processing_unit"},
        {item:"refinedstorage:raw_basic_processor"},
        {item:"refinedstorage:raw_basic_processor"},
        {item: "minecraft:redstone"}
    ]});
<recipetype:oritech:assembler>.addJsonRecipe("t1.ori.assembler/rs.improved_processor", 
    {type: "oritech:assembler", 
    fluidOutput: {fluid: "minecraft:empty", amount: 0}, 
    results: [{id: "refinedstorage:improved_processor", count: 4}], time: 40, 
    fluidInput: {fluid: "minecraft:empty", amount: 0}, 
    ingredients: [
        {item:"oritech:processing_unit"},
        {item:"refinedstorage:raw_improved_processor"},
        {item:"refinedstorage:raw_improved_processor"},
        {item: "minecraft:redstone"}
    ]});
<recipetype:oritech:assembler>.addJsonRecipe("t1.ori.assembler/rs.advanced_processor", 
    {type: "oritech:assembler", 
    fluidOutput: {fluid: "minecraft:empty", amount: 0}, 
    results: [{id: "refinedstorage:advanced_processor", count: 4}], time: 50, 
    fluidInput: {fluid: "minecraft:empty", amount: 0}, 
    ingredients: [
        {item:"oritech:processing_unit"},
        {item:"refinedstorage:raw_advanced_processor"},
        {item:"refinedstorage:raw_advanced_processor"},
        {item: "minecraft:redstone"}
    ]});

//富集石英铁铜
craftingTable.removeByName("refinedstorage:quartz_enriched_copper");
craftingTable.removeByName("refinedstorage:quartz_enriched_iron");
<recipetype:techreborn:alloy_smelter>.addJsonRecipe("rs.techreborn.alloy_smelter/quartz_enriched_copper", 
    {type: "techreborn:alloy_smelter", time: 80, 
    outputs: [{id: "refinedstorage:quartz_enriched_copper", count: 2}], power: 12, 
    ingredients: [{item: "minecraft:copper_ingot"}, {tag: "c:gems/quartz"}]});
<recipetype:techreborn:alloy_smelter>.addJsonRecipe("rs.techreborn.alloy_smelter/quartz_enriched_iron", 
    {type: "techreborn:alloy_smelter", time: 80, 
    outputs: [{id: "refinedstorage:quartz_enriched_iron", count: 2}], power: 12, 
    ingredients: [{item: "minecraft:iron_ingot"}, {tag: "c:gems/quartz"}]});

//机械外壳
craftingTable.removeByName("refinedstorage:machine_casing");
<recipetype:lychee:block_interacting>.addJsonRecipe("rs.lychee.machine_casing",{
  "type": "lychee:block_interacting",
  "item_in": "refinedstorage:quartz_enriched_iron",
  "block_in": "techreborn:basic_machine_frame",
  "post": [
    "place refinedstorage:machine_casing"
  ]
});
<recipetype:techreborn:assembling_machine>.addJsonRecipe("rs.tr.assmebler/t2_machine_casing", {type: "techreborn:assembling_machine",
    time: 80,
    outputs: [
        {id: "refinedstorage:machine_casing", count: 1}
    ],
    power: 32,
    ingredients: [
        {item: "techreborn:basic_machine_frame", count: 1},
        {item: "refinedstorage:quartz_enriched_iron", count: 2}
    ]
});
//创造电源和范围升级
<recipetype:avaritia:extreme_crafting>.addJsonRecipe("t1.rs.creative_controller", 
{type: "avaritia:extreme_shaped", result: {id: "refinedstorage:creative_controller", count: 1}, pattern: [
    "IIQQ QQII", 
    "I Q   Q I", 
    "I  R R  I", 
    "X R P R X", 
    "I  PEP  I", 
    "X R P R X", 
    "I  RQR  I", 
    "I   Q   I", 
    "IIIXIXIII"],
 key: {P: {item:"transmog:void_fragment"},E: {item: "oritech:laser_arm_block"}, R: {item: "techreborn:lithium_ion_battery"}, Q: {item: "oritech:flux_gate"}, X: {item: "avaritia:diamond_lattice"}, I: {item: "refinedstorage:machine_casing"}}});

craftingTable.addShaped("rs.creative_range_upgrade", <item:refinedstorage:creative_range_upgrade>, 
    [[<item:transmog:void_fragment>, <item:oritech:plastic_sheet>, <item:transmog:void_fragment>], 
    [<item:oritech:plastic_sheet>, <item:refinedstorage:creative_controller>, <item:oritech:plastic_sheet>], 
    [<item:transmog:void_fragment>, <item:oritech:laser_arm_block>, <item:transmog:void_fragment>]]);

craftingTable.addShaped("rs.interdimensional", <item:interdimensionalwirelesstransmitter:interdimensional_wireless_transmitter>, 
    [[<item:transmog:void_fragment>, <item:jsonreg:gravi_star>, <item:transmog:void_fragment>], 
    [<item:minecraft:air>, <item:refinedstorage:creative_range_upgrade>, <item:minecraft:air>], 
    [<item:transmog:void_fragment>, <item:refinedstorage:wireless_transmitter>, <item:transmog:void_fragment>]]);


//更加便宜的RS线缆和样板
craftingTable.remove(<item:refinedstorage:cable>);
craftingTable.remove(<item:refinedstorage:pattern>);
craftingTable.remove(<item:refinedstorage:external_storage>);
craftingTable.addShaped("rs.refinedstorage.morecable", <item:refinedstorage:cable> * 16, [
    [<item:refinedstorage:quartz_enriched_copper>, <item:refinedstorage:quartz_enriched_copper>, <item:refinedstorage:quartz_enriched_copper>], 
    [<tag:item:c:glass_blocks>, <tag:item:c:dusts/redstone>, <tag:item:c:glass_blocks>], 
    [<item:refinedstorage:quartz_enriched_copper>, <item:refinedstorage:quartz_enriched_copper>, <item:refinedstorage:quartz_enriched_copper>]]);
craftingTable.addShaped("rs.refinedstorage.morepattern", <item:refinedstorage:pattern> * 16, [
    [<tag:item:c:glass_blocks>, <tag:item:c:dusts/redstone>, <tag:item:c:glass_blocks>], 
    [<tag:item:c:dusts/redstone>, <tag:item:c:glass_blocks>, <tag:item:c:dusts/redstone>], 
    [<item:refinedstorage:quartz_enriched_iron>, <item:refinedstorage:quartz_enriched_iron>, <item:refinedstorage:quartz_enriched_iron>]]);
craftingTable.addShaped("rs.refinedstorage.external_storage", <item:refinedstorage:external_storage>, [
    [<item:refinedstorage:construction_core>, <item:minecraft:air>, <item:refinedstorage:destruction_core>], 
    [<item:minecraft:air>, <item:refinedstorage:cable>, <item:minecraft:air>], 
    [<item:minecraft:air>, <item:refinedstorage:improved_processor>, <item:minecraft:air>]]);
