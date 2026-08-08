import crafttweaker.api.tag.MCTag;
import crafttweaker.api.recipe.type.Recipe;
/*
<recipetype:avaritia:extreme_crafting>.addJsonRecipe("t2.", {type: "avaritia:extreme_shaped", result: {id: "", count: 1}, pattern: 
 [
 "         ", 
 "         ", 
 "         ", 
 "         ", 
 "         ", 
 "         ", 
 "         ", 
 "         "], 
 key: {A: { },}});

*/
//EBF线圈
<recipetype:oritech:assembler>.addJsonRecipe("t2.or.coil.cupronickel", {type: "oritech:assembler",
    time: 80, results: [{id: "techreborn:coil_cupronickel", count: 1}],
    ingredients: [
        {item: "techreborn:cupronickel_heating_coil"},
        {item: "techreborn:tin_plate"},
        {item: "techreborn:cupronickel_heating_coil"},
        {item: "techreborn:tin_plate"}
    ]
});
<recipetype:oritech:assembler>.addJsonRecipe("t2.or.coil.kanthal", {type: "oritech:assembler",
    time: 80, results: [{id: "techreborn:coil_kanthal", count: 1}],
    ingredients: [
        {item: "techreborn:kanthal_heating_coil"},
        {item: "techreborn:tin_plate"},
        {item: "techreborn:kanthal_heating_coil"},
        {item: "techreborn:tin_plate"}
    ]
});
<recipetype:oritech:assembler>.addJsonRecipe("t2.or.coil.nichrome", {type: "oritech:assembler",
    time: 80, results: [{id: "techreborn:coil_nichrome", count: 1}],
    ingredients: [
        {item: "techreborn:nichrome_heating_coil"},
        {item: "techreborn:tin_plate"},
        {item: "techreborn:nichrome_heating_coil"},
        {item: "techreborn:tin_plate"}
    ]
});
//铬锭
<recipetype:techreborn:blast_furnace>.removeByName("techreborn:blast_furnace/chrome_ingot");
<recipetype:techreborn:blast_furnace>.removeByName("techreborn:blast_furnace/chrome_ingot_from_small_dust");
<recipetype:techreborn:blast_furnace>.addJsonRecipe("t2.techreborn.blast_furnace/chrome_ingot", {type: "techreborn:blast_furnace", outputs: [{id: "techreborn:chrome_ingot", count: 1}], time: 800, heat: 1000, power: 128, ingredients: [{item: "techreborn:chrome_dust"}]});
<recipetype:techreborn:blast_furnace>.addJsonRecipe("t2.techreborn.blast_furnace/chrome_ingot_from_small_dust", {type: "techreborn:blast_furnace", outputs: [{id: "techreborn:chrome_ingot", count: 1}], time: 800, heat: 1000, power: 128, ingredients: [{count: 4, item: "techreborn:chrome_small_dust"}]});

//T2马达
<recipetype:oritech:assembler>.addJsonRecipe("t2.or.t2coil", {type: "oritech:assembler",
    time: 40, results: [{id: "jsonreg:mv_voltage_coil", count: 4}],
    ingredients: [
        {item: "techreborn:insulated_gold_cable"},
        {item: "jsonreg:aluminum_rod"},
        {item: "techreborn:insulated_gold_cable"}
    ]
});
//我不知道我在这里写钛会不会导致平衡问题 但是我先写着
<recipetype:oritech:assembler>.addJsonRecipe("t2.or.t2motor", {type: "oritech:assembler",
    time: 40, results: [{id: "jsonreg:mv_electric_motor", count: 1}],
    ingredients: [
        {item: "jsonreg:titanium_rod"},
        {item: "techreborn:aluminum_ingot"},
        {item: "jsonreg:mv_voltage_coil"},
        {item: "jsonreg:mv_voltage_coil"}
    ]
});


//工业高炉主机
craftingTable.removeByName("techreborn:crafting_table/machine/industrial_blast_furnace");
<recipetype:avaritia:extreme_crafting>.addJsonRecipe("t2.techreborn.ebf", {type: "avaritia:extreme_shaped", result: {id: "techreborn:industrial_blast_furnace", count: 1}, pattern: 
 [
 "         ", 
 "         ", 
 "  AABAA  ", 
 "  ACECA  ", 
 "  BEDEB  ", 
 "  ACECA  ", 
 "  AABAA  ", 
 "         "],
 key: {A: {item: "techreborn:invar_plate" }, B: {item:"oritech:plastic_sheet"}, C:{item:"techreborn:advanced_circuit"},D:{item:"techreborn:advanced_machine_frame"},E:{item:"techreborn:cupronickel_heating_coil"}}});

//铝制钻石研磨头，卡一下磨粉和虚采的阶段
craftingTable.removeByName("techreborn:crafting_table/parts/diamond_grinding_head");
craftingTable.addShaped("t2.techreborn/crafting_table/parts/diamond_grinding_head", <item:techreborn:diamond_grinding_head> * 3, [
    [<item:techreborn:aluminum_plate>, <tag:item:c:ingots/steel>, <item:techreborn:aluminum_plate>], 
    [<tag:item:c:ingots/steel>, <item:jsonreg:silicon_carbide_dust>, <tag:item:c:ingots/steel>], 
    [<item:techreborn:aluminum_plate>, <tag:item:c:ingots/steel>, <item:techreborn:aluminum_plate>]]);
<recipetype:techreborn:blast_furnace>.addJsonRecipe("t2.techreborn.blast_furnace/silicon_carbide_dust", {type: "techreborn:blast_furnace", 
    outputs: [
        {id: "jsonreg:silicon_carbide_dust", count: 1},
        {id: "techreborn:cell", count: 2}
    ],
    time: 600, heat: 1000, power: 128,
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "techreborn:silicon"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 1, components: {"techreborn:fluid": "techreborn:carbon"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});


//昶铂需要电高 2100K
<recipetype:techreborn:alloy_smelter>.removeByName("oritech:compat/techreborn/alloysmelter/duratium");
<recipetype:oritech:foundry>.removeByName("oritech:foundry/alloy/duratium");
<recipetype:oritech:atomic_forge>.removeByName("oritech:atomicforge/duratium");
<recipetype:techreborn:blast_furnace>.addJsonRecipe("t2.techreborn.blast_furnace/duratium_ingot", {type: "techreborn:blast_furnace", 
outputs: [{id: "oritech:duratium_ingot", count: 1}], time: 1200, heat: 2000, power: 128, ingredients: [{tag: "c:ingots/platinum"}, {item:"minecraft:netherite_ingot"}]});

//虚空碎片
<recipetype:techreborn:blast_furnace>.addJsonRecipe("t2.techreborn.blast_furnace/void_fragment", {type: "techreborn:blast_furnace", 
outputs: [{id: "transmog:void_fragment", count: 1}], time: 600, heat: 1500, power: 128, ingredients: [{item:"techreborn:ender_pearl_dust"}, {item:"minecraft:echo_shard"}]});

//原子锻炉
craftingTable.removeByName("oritech:crafting/atomicforge");
<recipetype:avaritia:extreme_crafting>.addJsonRecipe("t2.oritech.atomic_forge", {type: "avaritia:extreme_shaped", result: {id: "oritech:atomic_forge_block", count: 1}, pattern: 
 [
 "         ", 
 "         ", 
 "  AA AA  ", 
 "  EBCBE  ", 
 "EEDCDCDEE", 
 "   ACA   ", 
 "         ", 
 "         "], 
 key: {A:{item:"oritech:duratium_ingot"},B:{item:"oritech:flux_gate"},C:{item:"techreborn:advanced_machine_frame"},D:{item:"oritech:enderic_compound"},E:{item:"oritech:plastic_sheet"}}});

//堕落智能
<recipetype:oritech:atomic_forge>.addJsonRecipe("t2.oritech.atomicforge/unholy_intelligence", {type: "oritech:atomic_forge", 
    fluidOutput: {fluid: "minecraft:empty", amount: 0}, results: [{id: "oritech:unholy_intelligence", count: 1}], 
    time: 60, fluidInput: {fluid: "minecraft:empty", amount: 0}, 
    ingredients: [{item: "oritech:dubios_container"}, {item: "oritech:biomass_block"}, {item: "oritech:duratium_ingot"}]});
<recipetype:oritech:atomic_forge>.addJsonRecipe("t2.oritech.atomicforge/unholy_intelligence_from_advc", {type: "oritech:atomic_forge", 
    fluidOutput: {fluid: "minecraft:empty", amount: 0}, results: [{id: "oritech:unholy_intelligence", count: 1}], 
    time: 60, fluidInput: {fluid: "minecraft:empty", amount: 0}, 
    ingredients: [{item: "oritech:dubios_container"}, {item: "oritech:advanced_computing_engine"}, {item: "oritech:advanced_computing_engine"}]});

//基岩钻机
craftingTable.remove(<item:oritech:deep_drill_block>);
<recipetype:avaritia:extreme_crafting>.addJsonRecipe("t2.oritech.deep_drill", {type: "avaritia:extreme_shaped", result: {id: "oritech:deep_drill_block", count: 2}, pattern: 
 [
 "         ", 
 "         ", 
 " E     E ", 
 " E     E ", 
 " E FCF E ", 
 " EDC CDE ", 
 "HDABCBADH", 
 " AHGGGHA "], 
 key: {A: {item:"techreborn:steel_plate"},B:{item:"oritech:duratium_block"},C:{item:"techreborn:advanced_machine_frame"},D:{item:"techreborn:advanced_alloy_plate"},E:{item:"oritech:motor"},F:{item:"oritech:heisenberg_compensator"},G:{item:"techreborn:diamond_grinding_head"},H:{tag:"oritech:plating"}}});


//过充水晶
craftingTable.removeByName("oritech:motor/overchargedcrystal");
craftingTable.removeByName("oritech:particle/overcharged_crystal");//变成了2kJ，但是必须对撞
<recipetype:oritech:particle_collision>.addJsonRecipe("t2.oritech.particle/overcharged_crystal", {type: "oritech:particle_collision", 
fluidOutput: {fluid: "minecraft:empty", amount: 0}, results: [{id: "oritech:overcharged_crystal", count: 1}], time: 2000, 
fluidInput: {fluid: "minecraft:empty", amount: 0}, ingredients: [{item: "oritech:fluxite"}, {item: "oritech:energite_dust"}]});

//粒子加速器的便宜配方
craftingTable.addShaped("t2.oritech.crafting/particlecontroller_alt", <item:oritech:accelerator_controller>, [
    [<tag:item:oritech:plating>, <item:oritech:duratium_ingot>, <tag:item:oritech:plating>], 
    [<item:oritech:advanced_computing_engine>, <item:minecraft:dropper>, <item:oritech:advanced_computing_engine>], 
    [<item:oritech:flux_gate>, <item:oritech:accelerator_motor>, <item:oritech:flux_gate>]]);
//钷
<recipetype:oritech:atomic_forge>.removeByName("oritech:atomicforge/prometheum");
<recipetype:oritech:particle_collision>.addJsonRecipe("t2.oritech.particle/prometheum", {type: "oritech:particle_collision", 
fluidOutput: {fluid: "minecraft:empty", amount: 0}, results: [{id: "oritech:prometheum_ingot", count: 1}], time: 2500, 
fluidInput: {fluid: "minecraft:empty", amount: 0}, ingredients: [{item: "oritech:overcharged_crystal"}, {item: "oritech:heisenberg_compensator"}]});

//ai芯片，t3电路
<recipetype:oritech:atomic_forge>.removeByName("oritech:atomicforge/aicomputer");
<recipetype:oritech:atomic_forge>.addJsonRecipe("t2.oritech.atomicforge/aicomputer", {type: "oritech:atomic_forge", 
fluidOutput: {fluid: "minecraft:empty", amount: 0}, results: [{id: "oritech:super_ai_chip", count: 2}], time: 100, 
fluidInput: {fluid: "minecraft:empty", amount: 0}, ingredients: [{item: "oritech:prometheum_ingot"}, {item: "oritech:heisenberg_compensator"}, {item: "oritech:advanced_computing_engine"}]});
//t3 soc
<recipetype:techreborn:assembling_machine>.removeByName("techreborn:assembling_machine/industrial_circuit");
<recipetype:oritech:assembler>.addJsonRecipe("t2.oritech.assembler/industrial_circuit/soc", 
{type: "oritech:assembler", fluidOutput: {fluid: "minecraft:empty", amount: 0}, results: [{id: "techreborn:industrial_circuit", count: 8}], 
time: 80, fluidInput: {fluid: "minecraft:empty", amount: 0}, 
ingredients: [{item: "techreborn:platinum_plate"}, {item: "techreborn:platinum_plate"}, {item: "oritech:super_ai_chip"}, {item: "oritech:flux_gate"}]});

//工业框架
craftingTable.removeByName("techreborn:crafting_table/machine_block/industrial_machine_frame");
craftingTable.removeByName("techreborn:crafting_table/machine_block/industrial_machine_casing_alt");
<recipetype:oritech:assembler>.addJsonRecipe("t2.oritech.assembler/industrial_machine_frame", 
{type: "oritech:assembler", fluidOutput: {fluid: "minecraft:empty", amount: 0}, results: [{id: "techreborn:industrial_machine_frame", count: 2}], 
time: 60, fluidInput: {fluid: "minecraft:empty", amount: 0}, 
ingredients: [{item: "techreborn:advanced_machine_frame"}, {item: "techreborn:iridium_alloy_plate"}, {item: "techreborn:advanced_circuit"}, {item: "oritech:flux_gate"}]});
  
//uu物质
craftingTable.removeByName("techreborn:crafting_table/machine/recycler");
<recipetype:techreborn:blast_furnace>.addJsonRecipe("t2.techreborn.blast_furnace/scrap", {type: "techreborn:blast_furnace", 
outputs: [{id: "techreborn:scrap", count: 64}], time: 10, heat: 3000, power: 128, ingredients: [{item:"avaritia:neutron_pile"}]});
<recipetype:techreborn:blast_furnace>.addJsonRecipe("t2.techreborn.blast_furnace/scrap_box", {type: "techreborn:blast_furnace", 
outputs: [{id: "techreborn:scrap_box", count: 64}], time: 10, heat: 3000, power: 128, ingredients: [{item:"avaritia:neutron_nugget"}]});
craftingTable.removeByName("techreborn:crafting_table/machine/matter_fabricator");
<recipetype:avaritia:extreme_crafting>.addJsonRecipe("t2.techreborn.matter_fabricator", {type: "avaritia:extreme_shaped", result: {id: "techreborn:matter_fabricator", count: 1}, pattern: 
 [
 "         ", 
 "         ", 
 "         ", 
 "H  FDF  H", 
 "ECF B FCE", 
 "H EAAAE H", 
 "H  CBC  H", 
 "HHHFXFHHH"], 
 key: {X:{item:"techreborn:computer_cube"},A: {item:"techreborn:industrial_machine_frame"},B:{item:"techreborn:extractor"},C:{item:"techreborn:energy_flow_chip"},D:{item:"techreborn:lapotronic_orb"},E:{item:"oritech:heisenberg_compensator"},H:{tag:"oritech:plating"},F:{item:"techreborn:titanium_plate"}}});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("t2.oritech.centrifuge/uu", {type: "oritech:centrifuge_fluid", 
    fluidOutput: {fluid: "minecraft:empty", amount: 0}, 
    results: [{id: "techreborn:uu_matter", count: 4}], 
    time: 800, 
    fluidInput: {fluid: "oritech:still_strange_matter", amount: 81000}, 
    ingredients: [{item: "jsonreg:naquadah_rod",count: 1}]});
//便宜的红石水晶
<recipetype:techreborn:chemical_reactor>.removeByName("techreborn:chemical_reactor/synthetic_redstone_crystal");
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("t2.techreborn.chemical_reactor/synthetic_redstone_crystal", {type: "techreborn:chemical_reactor", 
  time: 1200, outputs: [{id: "techreborn:synthetic_redstone_crystal", count: 1}], power: 50, 
  ingredients: [{item: "minecraft:redstone", count: 16}, {item: "minecraft:diamond"}]});

//T2末地烛
craftingTable.remove(<item:justarod:basic_electric_rod>);
<recipetype:oritech:assembler>.addJsonRecipe("t2.oritech.assembler/jart2rod", 
{type: "oritech:assembler", fluidOutput: {fluid: "minecraft:empty", amount: 0}, results: [{id: "justarod:basic_electric_rod"}], 
time: 60, fluidInput: {fluid: "minecraft:empty", amount: 0}, 
ingredients: [{item: "justarod:redstone_rod"}, {item: "oritech:advanced_computing_engine"}, {item: "affinity:fairly_attuned_amethyst_shard"}, {item: "techreborn:lithium_ion_battery"}]});

//纳米剑配方easier
craftingTable.remove(<item:techreborn:nanosaber>);
craftingTable.addShaped("t2.techreborn.crafting_table/tool/nanosaber", <item:techreborn:nanosaber>, [
    [<tag:item:c:plates/diamond>, <item:techreborn:carbon_plate>, <item:minecraft:air>], 
    [<tag:item:c:plates/diamond>, <item:techreborn:carbon_plate>, <item:minecraft:air>], 
    [<item:techreborn:glowstone_small_dust>, <item:techreborn:energy_crystal>, <item:techreborn:glowstone_small_dust>]]);

//便宜的兰波顿
craftingTable.remove(<item:techreborn:lapotron_crystal>);
<recipetype:oritech:assembler>.addJsonRecipe("t2.oritech.assembler/lapotron", 
{type: "oritech:assembler", fluidOutput: {fluid: "minecraft:empty", amount: 0}, results: [{id: "techreborn:lapotron_crystal"}], 
time: 60, fluidInput: {fluid: "minecraft:empty", amount: 0}, 
ingredients: [{item: "techreborn:lazurite_plate"}, {item: "techreborn:industrial_circuit"}, {item: "techreborn:lazurite_plate"}, {item: "techreborn:energy_crystal"}]});

//创造能源
<recipetype:avaritia:extreme_crafting>.addJsonRecipe("t2.oritech/creative_storage", {type: "avaritia:extreme_shaped", result: {id: "oritech:creative_storage_block", count: 1}, pattern: 
 [
 "PP  O  PP", 
 "P   Z   P", 
 "   Z Z   ", 
 "  X E X  ", 
 "OX BAB XO", 
 "  X A X  ", 
 "   D D   ", 
 "P   D   P", 
 "PP  O  PP"], 
 key: {A: {item:"oritech:machine_core_7"},E:{item:"techreborn:lapotronic_orbpack"},B:{item:"techreborn:iridium_reinforced_tungstensteel_storage_block"},X:{item:"techreborn:superconductor"},
       D: {item:"oritech:dubios_container"},Z:{item:"oritech:large_storage_block"},P:{item:"oritech:carbon_plating_block"},O:{item:"transmog:void_fragment"}}});

//T3电路第二配方
//移除磷粉配方
craftingTable.remove(<item:techreborn:phosphorous_dust>);
<recipetype:techreborn:scrapbox>.remove(<item:techreborn:phosphorous_dust>);
craftingTable.remove(<item:techreborn:phosphorous_small_dust>);
<recipetype:techreborn:scrapbox>.remove(<item:techreborn:phosphorous_small_dust>);

//电路基板配方
<recipetype:oritech:atomic_forge>.addJsonRecipe("t2.oritech.atomicforge/aicomputer_alt", {type: "oritech:atomic_forge", 
    fluidOutput: {fluid: "minecraft:empty", amount: 0}, results: [{id: "oritech:super_ai_chip", count: 1}], time: 240, 
    fluidInput: {fluid: "minecraft:empty", amount: 0}, ingredients: [{item: "techreborn:phosphorous_dust"}, {item: "oritech:heisenberg_compensator"}, {item: "oritech:advanced_computing_engine"}]});
<recipetype:oritech:atomic_forge>.addJsonRecipe("t2.oritech.atomicforge/aicomputer_printboard", {type: "oritech:atomic_forge", 
    fluidOutput: {fluid: "minecraft:empty", amount: 0}, results: [{id: "techreborn:phosphorous_dust", count: 4}], time: 100, 
    fluidInput: {fluid: "minecraft:empty", amount: 0}, ingredients: [{item: "oritech:prometheum_ingot"}, {item: "minecraft:netherite_scrap"}, {item: "techreborn:bronze_plate"}]});

//创造存储
<recipetype:avaritia:extreme_crafting>.addJsonRecipe("t2.rs/creative_storage/item", {type: "avaritia:extreme_shaped", result: {id: "refinedstorage:creative_storage_block", count: 1}, pattern: 
 [
 "PP  O  PP", 
 "P       P", 
 "    X    ", 
 "  X E X  ", 
 "OXE A EXO", 
 "  X E X  ", 
 "    X    ", 
 "P       P", 
 "PP  O  PP"], 
 key: {A: {item:"techreborn:quantum_storage_unit"},E:{item:"techreborn:data_storage_core"},X:{item:"techreborn:superconductor"},
       P:{item:"oritech:carbon_plating_block"},O:{item:"transmog:void_fragment"}}});
<recipetype:avaritia:extreme_crafting>.addJsonRecipe("t2.rs/creative_storage/fluid", {type: "avaritia:extreme_shaped", result: {id: "refinedstorage:creative_fluid_storage_block", count: 1}, pattern: 
 [
 "PP  O  PP", 
 "P       P", 
 "    X    ", 
 "  X E X  ", 
 "OXE A EXO", 
 "  X E X  ", 
 "    X    ", 
 "P       P", 
 "PP  O  PP"], 
 key: {A: {item:"techreborn:quantum_tank_unit"},E:{item:"techreborn:data_storage_core"},X:{item:"techreborn:superconductor"},
       P:{item:"oritech:carbon_plating_block"},O:{item:"transmog:void_fragment"}}});

//避雷针
<recipetype:avaritia:extreme_crafting>.addJsonRecipe("t2.techreborn.lightning_rod", {type: "avaritia:extreme_shaped",
result: {id: "techreborn:lightning_rod", count: 1}, pattern: 
 [
 "    H    ", 
 "    H    ", 
 "  BAHAB  ", 
 "  ACECA  ", 
 "   EDE   ", 
 "  ACECA  ", 
 "  BA AB  ", 
 "         "],
 key: {H:{item: "techreborn:copper_cable"},A: {item: "jsonreg:naquadah_plate" }, B: {item:"jsonreg:epoxy_resin_plate"}, C:{item:"techreborn:advanced_circuit"},D:{item:"techreborn:advanced_machine_frame"},E:{item:"techreborn:energy_flow_chip"}}});


//核电，轻而易举啊！（Ori）
/*
[18:18:04.146][INFO][CraftTweaker-Commands]: Recipe type: '<recipetype:oritech:reactor>'
  <recipetype:oritech:reactor>.addJsonRecipe("oritech:reactorgen/pellet", {type: "oritech:reactor", time: 4000, results: [], ingredients: [{item: "oritech:uranium_pellet"}]});
  <recipetype:oritech:reactor>.addJsonRecipe("oritech:reactorgen/plutoniumpellet", {type: "oritech:reactor", time: 40000, results: [], ingredients: [{item: "oritech:plutonium_pellet"}]});
  <recipetype:oritech:reactor>.addJsonRecipe("oritech:reactorgen/smallpellet", {type: "oritech:reactor", time: 400, results: [], ingredients: [{item: "oritech:small_uranium_pellet"}]});
  <recipetype:oritech:reactor>.addJsonRecipe("oritech:reactorgen/smallplutoniumpellet", {type: "oritech:reactor", time: 4000, results: [], ingredients: [{item: "oritech:small_plutonium_pellet"}]});
*/
<recipetype:oritech:reactor>.removeAll();
//铀 T1 原版铀*0.5
//钍/MOX T2 原版铀*3
//超能硅岩 T3 原版钚*1.5
function _reactor(_recipe as string, _id as string, _time as int) as void { 
    <recipetype:oritech:reactor>.addJsonRecipe(_recipe, {type: "oritech:reactor", time: _time, results: [], ingredients: [{item: _id}]});
}

_reactor("t2.ori.reactor.uranium", "jsonreg:uranium_fuel_rod", 2000);
_reactor("t2.ori.reactor.uraniumx2", "jsonreg:dual_uranium_fuel_rod", 5000);
_reactor("t2.ori.reactor.thorium", "jsonreg:thorium_fuel_rod", 12000);
_reactor("t2.ori.reactor.thoriumx2", "jsonreg:dual_thorium_fuel_rod", 25000);
_reactor("t2.ori.reactor.mox", "jsonreg:mox_fuel_rod",16000);
_reactor("t2.ori.reactor.moxx2", "jsonreg:dual_mox_fuel_rod", 33000);
_reactor("t2.ori.reactor.nqdria", "jsonreg:naquadria_fuel_rod", 60000);
_reactor("t2.ori.reactor.nqdriamx2", "jsonreg:dual_naquadria_fuel_rod", 130000);

//燃料棒制作
<recipetype:techreborn:assembling_machine>.addJsonRecipe("t2.tr.assembling.empty_fuel_rod", {type: "techreborn:assembling_machine",
    time: 200,
    outputs: [
        {id: "jsonreg:fuel_rod", count: 4}
    ],
    power: 20,
    ingredients: [
        {item: "jsonreg:duratium_plate", count: 1},
        {item: "techreborn:lead_plate", count: 1}
    ]
});

//装填
function _fuelrod(_recipe as string, _idfrom as string, _idto as string) as string {
<recipetype:techreborn:assembling_machine>.addJsonRecipe(_recipe, {type: "techreborn:assembling_machine",
    time: 80,
    outputs: [
        {id: _idto, count: 1}
    ],
    power: 32,
    ingredients: [
        {item: "jsonreg:fuel_rod", count: 1},
        {item: _idfrom, count: 1}
    ]
});
}

_fuelrod("t2.tr.assembling.fuelrod.uranium", "oritech:uranium_dust", "jsonreg:uranium_fuel_rod");
_fuelrod("t2.tr.assembling.fuelrod.mox", "oritech:plutonium_dust", "jsonreg:mox_fuel_rod");
_fuelrod("t2.tr.assembling.fuelrod.thorium", "jsonreg:thorium_dust", "jsonreg:thorium_fuel_rod");
_fuelrod("t2.tr.assembling.fuelrod.nqdria", "jsonreg:naquadria_dust", "jsonreg:naquadria_fuel_rod");
//cb板
<recipetype:techreborn:compressor>.addJsonRecipe("t2.tr.duratium_plate", {type: "techreborn:compressor",
    time: 600,
    outputs: [{id: "jsonreg:duratium_plate", count: 1}],
    power: 16,
    ingredients: [{item: "oritech:duratium_ingot"}]
});

// ============================================================
// T2 金红石 → 钛 科学处理线（氯化法）
// ============================================================

// 1. 磨矿: 虚空石金红石矿 → 金红石粉（TiO2 精矿）
<recipetype:techreborn:grinder>.addJsonRecipe("t2.tr.grinder.rutile_dust_from_ore", {type: "techreborn:grinder",
    time: 100,
    outputs: [
        {id: "jsonreg:rutile_dust", count: 2}
    ],
    power: 32,
    ingredients: [
        {item: "jsonreg:voidstone_rutile_ore"}
    ]
});

// 1b. 工业磨粉（水洗磨矿，带副产）: 1 矿石 → 2 金红石粉 + 铁杂质 + 伴生 malarite + 脉石
<recipetype:techreborn:industrial_grinder>.addJsonRecipe("t2.tr.industrial_grinder.rutile_dust_from_ore", {type: "techreborn:industrial_grinder",
    time: 200,
    outputs: [
        {id: "jsonreg:rutile_dust", count: 2},
        {id: "oritech:iron_dust", count: 1},
        {id: "eternal_starlight:malarite", count: 1},
        {id: "eternal_starlight:cobbled_voidstone", count: 1}
    ],
    fluid: {fluid: {fluid: "minecraft:water"}, amount: {value: 81000}},
    power: 64,
    ingredients: [
        {item: "jsonreg:voidstone_rutile_ore", count: 1}
    ]
});

// 2. 加碳氯化（改为了大化反）
<recipetype:techreborn:large_chemical_reactor>.addJsonRecipe("t2.tr.largechemreactor.chlorinate_rutile", {type: "techreborn:large_chemical_reactor",
    time: 400,
    power: 256,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:titanium_tetrachloride"}},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {item: "jsonreg:rutile_dust", count: 1},
        {item: "techreborn:coal_dust", count: 1},
        {count: 2, components: {"techreborn:fluid": "jsonreg:chlorine"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// 3. Hunter 钠还原（化反, 1A MV）: TiCl4 + 4Na → Ti + 4NaCl
<recipetype:techreborn:large_chemical_reactor>.addJsonRecipe("t2.tr.largechemreactor.hunter_reduction", {type: "techreborn:large_chemical_reactor",
    time: 400,
    outputs: [
        {id: "techreborn:titanium_dust", count: 1},
        {id: "jsonreg:salt_dust", count: 4},
        {id: "techreborn:cell", count: 5}
    ],
    power: 128,
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:titanium_tetrachloride"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 4, components: {"techreborn:fluid": "techreborn:sodium"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});
