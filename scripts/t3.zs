import crafttweaker.api.tag.MCTag;
import crafttweaker.api.recipe.type.Recipe;
//聚变堆
craftingTable.remove(<item:techreborn:fusion_control_computer>);
<recipetype:avaritia:extreme_crafting>.addJsonRecipe("t3.techreborn.fusion_contoller", {type: "avaritia:extreme_shaped", result: {id: "techreborn:fusion_control_computer", count: 1}, pattern: 
 [
 "         ", 
 "         ", 
 "H AAAAA H", 
 "HNFCECFNH", 
 "ECFD DFCE", 
 "HNFCECFNH", 
 "H AAAAA H", 
 "HHHFXFHHH"], 
 key: {N:{item:"techreborn:fusion_coil"},X:{item:"techreborn:computer_cube"},A: {item:"techreborn:industrial_machine_frame"},C:{item:"techreborn:energy_flow_chip"},D:{item:"techreborn:lapotronic_orb"},E:{item:"oritech:heisenberg_compensator"},H:{tag:"oritech:plating"},F:{item:"techreborn:iridium_alloy_plate"}}});
//T3马达
<recipetype:oritech:assembler>.addJsonRecipe("t3.or.t3coil", {type: "oritech:assembler",
    time: 80, results: [{id: "jsonreg:hv_voltage_coil", count: 3}],
    ingredients: [
        {item: "techreborn:insulated_hv_cable"},
        {item: "jsonreg:naquadah_rod"},
        {item: "techreborn:insulated_hv_cable"}
    ]
});
<recipetype:oritech:assembler>.addJsonRecipe("t3.or.t3motor", {type: "oritech:assembler",
    time: 80, results: [{id: "jsonreg:hv_electric_motor", count: 1}],
    ingredients: [
        {item: "jsonreg:duratium_rod"},
        {item: "techreborn:tungstensteel_ingot"},
        {item: "jsonreg:hv_voltage_coil"},
        {item: "jsonreg:hv_voltage_coil"}
    ]
});


//增产无尽催化
<recipetype:techreborn:implosion_compressor>.addJsonRecipe("t3.implosion_compressor/catalyst_produce", 
{type: "techreborn:implosion_compressor", time: 1000, 
outputs: [{id: "avaritia:infinity_catalyst", count: 3}, 
{id: "avaritia:neutron_pile", count: 4}], power: 30, 
ingredients: [{item: "avaritia:infinity_catalyst", count: 1}, {item: "avaritia:neutronium_ingot", count: 1}]});

//水晶矩阵锭
<recipetype:techreborn:fusion_reactor>.addJsonRecipe("t3.techreborn.fusion_reactor/crystal_matrix", 
{type: "techreborn:fusion_reactor", time: 1024, 
outputs: [{id: "avaritia:crystal_matrix_ingot", count: 2}], 
power: -2048, minSize: 1, 
ingredients: [{item:"avaritia:diamond_lattice",count:4}, {item:"affinity:synthetic_dragon_heart"}], startEnergy: 80000000});

//水晶矩阵简化钷
<recipetype:techreborn:fusion_reactor>.addJsonRecipe("t3.techreborn.fusion_reactor/prometheum", 
{type: "techreborn:fusion_reactor", time: 1024, 
outputs: [{id: "oritech:prometheum_ingot", count: 4}], 
power: -2048, minSize: 8, 
ingredients: [{item:"oritech:overcharged_crystal"}, {item:"avaritia:crystal_matrix_ingot"}], startEnergy: 60000000});

//过充水晶高效配方
<recipetype:techreborn:fusion_reactor>.addJsonRecipe("t3.techreborn.fusion_reactor/overcharged_crystal", 
{type: "techreborn:fusion_reactor", time: 512, 
outputs: [{id: "oritech:overcharged_crystal", count: 4}], 
power: -2048, minSize: 1, 
ingredients: [{item:"oritech:fluxite"}, {item:"oritech:energite_ingot"}], startEnergy: 60000000});

//无尽奇点
<recipetype:techreborn:fusion_reactor>.addJsonRecipe("t3.techreborn.fusion_reactor/inf_singularity/cu-dr", 
{type: "techreborn:fusion_reactor", time: 2048, 
outputs: [{id: "avaritia:infinity_singularity", count: 8}], 
power: -2048, minSize: 8, 
ingredients: [{item:"avaritia:copper_singularity"}, {item:"avaritia:netherite_singularity"}], startEnergy: 300000000});
<recipetype:techreborn:fusion_reactor>.addJsonRecipe("t3.techreborn.fusion_reactor/inf_singularity/am-fe", 
{type: "techreborn:fusion_reactor", time: 2048, 
outputs: [{id: "avaritia:infinity_singularity", count: 4}], 
power: -2048, minSize: 8, 
ingredients: [{item:"avaritia:amethyst_singularity"}, {item:"avaritia:iron_singularity"}], startEnergy: 300000000});
<recipetype:techreborn:fusion_reactor>.addJsonRecipe("t3.techreborn.fusion_reactor/inf_singularity/au-rd", 
{type: "techreborn:fusion_reactor", time: 2048, 
outputs: [{id: "avaritia:infinity_singularity", count: 4}], 
power: -2048, minSize: 8, 
ingredients: [{item:"avaritia:gold_singularity"}, {item:"avaritia:redstone_singularity"}], startEnergy: 300000000});
<recipetype:techreborn:fusion_reactor>.addJsonRecipe("t3.techreborn.fusion_reactor/inf_singularity/lp-em", 
{type: "techreborn:fusion_reactor", time: 2048, 
outputs: [{id: "avaritia:infinity_singularity", count: 4}], 
power: -2048, minSize: 8, 
ingredients: [{item:"avaritia:lapis_singularity"}, {item:"avaritia:emerald_singularity"}], startEnergy: 300000000});
<recipetype:techreborn:fusion_reactor>.addJsonRecipe("t3.techreborn.fusion_reactor/inf_singularity/di-qu", 
{type: "techreborn:fusion_reactor", time: 2048, 
outputs: [{id: "avaritia:infinity_singularity", count: 4}], 
power: -2048, minSize: 8, 
ingredients: [{item:"avaritia:diamond_singularity"}, {item:"avaritia:quartz_singularity"}], startEnergy: 300000000});

//催化剂其他成分
//终望珍珠
<recipetype:oritech:atomic_forge>.addJsonRecipe("t3.oritech.atomicforge/endest_pearl", {type: "oritech:atomic_forge", 
    fluidOutput: {fluid: "minecraft:empty", amount: 0}, results: [{id: "avaritia:endest_pearl" ,count: 1}], 
    time: 60, 
    fluidInput: {fluid: "minecraft:empty", amount: 0}, ingredients: [{item: "minecraft:ender_pearl"}, {item: "avaritia:neutronium_ingot"}, {item: "oritech:uranium_dust"}]});
//超级煲
<recipetype:techreborn:fusion_reactor>.addJsonRecipe("t3.techreborn.fusion_reactor/ultimate_stew", 
{type: "techreborn:fusion_reactor", time: 1024, 
outputs: [{id: "avaritia:ultimate_stew", count: 32}], 
power: -2048, minSize: 1, 
ingredients: [{item:"avaritia:infinity_singularity"}, {tag:"c:crops"}], startEnergy: 30000000});
//寰宇肉丸
<recipetype:techreborn:fusion_reactor>.addJsonRecipe("t3.techreborn.fusion_reactor/cosmic_meatballs", 
{type: "techreborn:fusion_reactor", time: 1024, 
outputs: [{id: "avaritia:cosmic_meatballs", count: 32}], 
power: -2048, minSize: 1, 
ingredients: [{item:"avaritia:infinity_singularity"}, {tag:"minecraft:meat"}], startEnergy: 30000000});

//无尽素掺杂核弹
craftingTable.removeByName("oritech:crafting/nukebetter");
craftingTable.addShaped("t3.oritech.crafting/inf_nuke", <item:oritech:nuke>, [
    [<item:oritech:heisenberg_compensator>, <item:avaritia:crystal_matrix_ingot>, <item:oritech:heisenberg_compensator>], 
    [<item:oritech:prometheum_ingot>, <item:avaritia:infinity_catalyst>, <item:techreborn:iridium_neutron_reflector>], 
    [<item:oritech:plutonium_pellet>, <item:avaritia:crystal_matrix_ingot>, <item:oritech:plutonium_pellet>]]);

//无尽锭
<recipetype:techreborn:implosion_compressor>.addJsonRecipe("t3.implosion_compressor/infinity_ingot", 
{type: "techreborn:implosion_compressor", time: 1000, 
outputs: [{id: "avaritia:infinity_ingot", count: 1}, {id: "techreborn:uu_matter", count: 4}], power: 600, 
ingredients: [{item: "oritech:nuke", count: 1}, {item: "avaritia:neutronium_ingot", count: 2}]});

//终望珍珠循环中子素
<recipetype:techreborn:implosion_compressor>.addJsonRecipe("t3.implosion_compressor/endest_neutron_produce", 
{type: "techreborn:implosion_compressor", time: 200, 
outputs: [{id: "avaritia:neutronium_ingot", count: 2}, {id: "avaritia:endest_pearl", count: 2}], power: 120, 
ingredients: [{item: "avaritia:neutron_nugget",count:4}, {item: "avaritia:endest_pearl", count: 2}]});

//t3末地烛
craftingTable.remove(<item:justarod:advanced_electric_rod>);
<recipetype:oritech:assembler>.addJsonRecipe("t3.oritech.assembler/jart3rod", 
    {type: "oritech:assembler", fluidOutput: {fluid: "minecraft:empty", amount: 0}, results: [{id: "justarod:advanced_electric_rod"}], 
    time: 120, fluidInput: {fluid: "minecraft:empty", amount: 0}, 
    ingredients: [{item: "justarod:basic_electric_rod"}, {item: "techreborn:industrial_circuit"}, {item: "affinity:stabilized_artifact_blade"}, {item: "techreborn:lapotron_crystal"}]});
  
//无尽末地烛
craftingTable.remove(<item:justarod:industrial_electric_rod>);
<recipetype:avaritia:extreme_crafting>.addJsonRecipe("t3.industrial_electric_rod", {type: "avaritia:extreme_shaped", result: {id: "justarod:industrial_electric_rod", count: 1}, pattern: 
 [
 "    A    ", 
 "    A    ", 
 "    K    ", 
 "   BAB   ", 
 "  CCDCC  ", 
 "UUIIDIIOO", 
 "  BXBXB  ", 
 "   NJN   "], 
 key: {K:{item:"justarod:advanced_electric_rod"},J:{item:"minecraft:dragon_egg"}, A: {item: "avaritia:neutronium_ingot"}, 
        B: {item: "oritech:super_ai_chip"}, C: {item: "oritech:prometheum_ingot"}, D: {item: "avaritia:infinity_ingot"}, 
        I: {item: "techreborn:lapotron_crystal"}, N: {item: "justarod:golden_leaves"}, X: {item: "justarod:bremelanotide"},
        U:{item:"eternal_starlight:tenacious_vine"},O:{item:"affinity:affinitea"}}});

//猫猫锭
<recipetype:techreborn:fusion_reactor>.addJsonRecipe("t3.techreborn.fusion_reactor/neko_ingot", 
    {type: "techreborn:fusion_reactor", time: 512, 
    outputs: [{id: "toneko:neko_ingot", count: 1}], 
    power: -2048, minSize: 1, 
    ingredients: [{item:"toneko:neko_potion"}, {item:"eternal_starlight:deepsilver_ingot"}], startEnergy: 60000000});

//龙素循环
//龙息
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("t3.tr.chemical/dragon_breath", {type: "techreborn:chemical_reactor", time: 400, 
    outputs: [{id: "minecraft:dragon_breath", count: 2}], power: 80, 
    ingredients: [{item: "affinity:wise_wisp_mist"}, {item:"minecraft:dragon_egg"}]});
//龙之凝物
<recipetype:techreborn:fusion_reactor>.addJsonRecipe("t3.techreborn.fusion_reactor/dragon_drop", 
    {type: "techreborn:fusion_reactor", time: 1024, 
    outputs: [{id: "affinity:dragon_drop", count: 1}], 
    power: 1024, minSize: 1, 
    ingredients: [{item:"minecraft:nether_star"}, {item:"minecraft:dragon_breath"}], startEnergy: 6000000});
//龙心制蛋
<recipetype:oritech:atomic_forge>.addJsonRecipe("t3.oritech.atomicforge/dragon_egg", {type: "oritech:atomic_forge", 
    fluidOutput: {fluid: "minecraft:empty", amount: 0}, results: [{id: "minecraft:dragon_egg", count: 2}], time: 200, 
    fluidInput: {fluid: "minecraft:empty", amount: 0}, ingredients: [{item: "affinity:synthetic_dragon_heart"}, {item: "oritech:heisenberg_compensator"}, {item: "avaritia:neutronium_ingot"}]});
//友好的龙心
<recipetype:techreborn:blast_furnace>.addJsonRecipe("t3.techreborn.blast_furnace/dragon_egg", {type: "techreborn:blast_furnace", 
    outputs: [{id: "affinity:synthetic_dragon_heart", count: 1},{id:"avaritia:infinity_catalyst"}], time: 600, heat: 3500, power: 256, ingredients: [{item:"minecraft:dragon_egg"}, {item:"avaritia:infinity_catalyst"}]});
