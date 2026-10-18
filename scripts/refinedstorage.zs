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


// =====================================================================
// Cable Tiers —— 等级配方整合
// =====================================================================
// mod 自带 21 条升级配方（7 种设备 × elite / ultra / mega），用的是
// 铁块 / 钻石块 / 下界合金块 / 龙首 这类原版材料，与本包科技线完全脱节，
// 且升级代价反而低于 RS 原设备。这里把 21 条全部清退，换成统一阶梯：
//
//   普通(RS 原设备) → 精英 → 终极 → 超级
//     精英 = 原节点 + 1 高级处理器  + 4 精炼铁板
//     终极 = 精英节点 + 1 高级电路 + 1 昶铂板 + 4 铁杆
//     超级 = 终极节点 + 1 高级计算引擎 + 4 硅岩板
//
// 统一形制（四角 + 中心节点 + 下中特征件）：
//     P . P        R D R        P . P
//     . N .        . N .        . N .
//     P X P        R C R        P E P
//   P=精炼铁板  X=高级处理器  N=RS 原设备
//   R=铁杆      D=昶铂板      C=高级电路
//   P=硅岩板    E=高级计算引擎
//
// mod 自带的 384 条染色配方保持原样不动 —— 染色经济与等级经济分开。
// =====================================================================

// ---------- 清退 21 条原版升级配方（染色配方不动） ----------
// 精英（原本：4 铁块 + 4 原设备 + 1 高级处理器）
craftingTable.removeByName("cabletiers:elite_importer");
craftingTable.removeByName("cabletiers:elite_exporter");
craftingTable.removeByName("cabletiers:elite_constructor");
craftingTable.removeByName("cabletiers:elite_destructor");
craftingTable.removeByName("cabletiers:elite_disk_interface");
craftingTable.removeByName("cabletiers:elite_interface");
craftingTable.removeByName("cabletiers:elite_autocrafter");
// 终极（原本：4 钻石块 + 4 精英设备 + 1 高级处理器）
craftingTable.removeByName("cabletiers:ultra_importer");
craftingTable.removeByName("cabletiers:ultra_exporter");
craftingTable.removeByName("cabletiers:ultra_constructor");
craftingTable.removeByName("cabletiers:ultra_destructor");
craftingTable.removeByName("cabletiers:ultra_disk_interface");
craftingTable.removeByName("cabletiers:ultra_interface");
craftingTable.removeByName("cabletiers:ultra_autocrafter");
// 超级（原本：4 下界合金块 + 4 终极设备 + 1 龙首）
craftingTable.removeByName("cabletiers:mega_importer");
craftingTable.removeByName("cabletiers:mega_exporter");
craftingTable.removeByName("cabletiers:mega_constructor");
craftingTable.removeByName("cabletiers:mega_destructor");
craftingTable.removeByName("cabletiers:mega_disk_interface");
craftingTable.removeByName("cabletiers:mega_interface");
craftingTable.removeByName("cabletiers:mega_autocrafter");

// ---------- 精英：原节点 + 1 高级处理器 + 4 精炼铁板 ----------
craftingTable.addShaped("rs.cabletiers/elite_importer", <item:cabletiers:elite_importer>, [
    [<item:techreborn:refined_iron_plate>, <item:minecraft:air>, <item:techreborn:refined_iron_plate>],
    [<item:minecraft:air>, <item:refinedstorage:importer>, <item:minecraft:air>],
    [<item:techreborn:refined_iron_plate>, <item:refinedstorage:advanced_processor>, <item:techreborn:refined_iron_plate>]]);
craftingTable.addShaped("rs.cabletiers/elite_exporter", <item:cabletiers:elite_exporter>, [
    [<item:techreborn:refined_iron_plate>, <item:minecraft:air>, <item:techreborn:refined_iron_plate>],
    [<item:minecraft:air>, <item:refinedstorage:exporter>, <item:minecraft:air>],
    [<item:techreborn:refined_iron_plate>, <item:refinedstorage:advanced_processor>, <item:techreborn:refined_iron_plate>]]);
craftingTable.addShaped("rs.cabletiers/elite_constructor", <item:cabletiers:elite_constructor>, [
    [<item:techreborn:refined_iron_plate>, <item:minecraft:air>, <item:techreborn:refined_iron_plate>],
    [<item:minecraft:air>, <item:refinedstorage:constructor>, <item:minecraft:air>],
    [<item:techreborn:refined_iron_plate>, <item:refinedstorage:advanced_processor>, <item:techreborn:refined_iron_plate>]]);
craftingTable.addShaped("rs.cabletiers/elite_destructor", <item:cabletiers:elite_destructor>, [
    [<item:techreborn:refined_iron_plate>, <item:minecraft:air>, <item:techreborn:refined_iron_plate>],
    [<item:minecraft:air>, <item:refinedstorage:destructor>, <item:minecraft:air>],
    [<item:techreborn:refined_iron_plate>, <item:refinedstorage:advanced_processor>, <item:techreborn:refined_iron_plate>]]);
craftingTable.addShaped("rs.cabletiers/elite_disk_interface", <item:cabletiers:elite_disk_interface>, [
    [<item:techreborn:refined_iron_plate>, <item:minecraft:air>, <item:techreborn:refined_iron_plate>],
    [<item:minecraft:air>, <item:refinedstorage:disk_interface>, <item:minecraft:air>],
    [<item:techreborn:refined_iron_plate>, <item:refinedstorage:advanced_processor>, <item:techreborn:refined_iron_plate>]]);
craftingTable.addShaped("rs.cabletiers/elite_interface", <item:cabletiers:elite_interface>, [
    [<item:techreborn:refined_iron_plate>, <item:minecraft:air>, <item:techreborn:refined_iron_plate>],
    [<item:minecraft:air>, <item:refinedstorage:interface>, <item:minecraft:air>],
    [<item:techreborn:refined_iron_plate>, <item:refinedstorage:advanced_processor>, <item:techreborn:refined_iron_plate>]]);
craftingTable.addShaped("rs.cabletiers/elite_autocrafter", <item:cabletiers:elite_autocrafter>, [
    [<item:techreborn:refined_iron_plate>, <item:minecraft:air>, <item:techreborn:refined_iron_plate>],
    [<item:minecraft:air>, <item:refinedstorage:autocrafter>, <item:minecraft:air>],
    [<item:techreborn:refined_iron_plate>, <item:refinedstorage:advanced_processor>, <item:techreborn:refined_iron_plate>]]);

// ---------- 终极：精英节点 + 1 高级电路 + 1 昶铂板 + 4 铁杆 ----------
craftingTable.addShaped("rs.cabletiers/ultra_importer", <item:cabletiers:ultra_importer>, [
    [<item:jsonreg:iron_rod>, <item:jsonreg:duratium_plate>, <item:jsonreg:iron_rod>],
    [<item:minecraft:air>, <item:cabletiers:elite_importer>, <item:minecraft:air>],
    [<item:jsonreg:iron_rod>, <item:techreborn:advanced_circuit>, <item:jsonreg:iron_rod>]]);
craftingTable.addShaped("rs.cabletiers/ultra_exporter", <item:cabletiers:ultra_exporter>, [
    [<item:jsonreg:iron_rod>, <item:jsonreg:duratium_plate>, <item:jsonreg:iron_rod>],
    [<item:minecraft:air>, <item:cabletiers:elite_exporter>, <item:minecraft:air>],
    [<item:jsonreg:iron_rod>, <item:techreborn:advanced_circuit>, <item:jsonreg:iron_rod>]]);
craftingTable.addShaped("rs.cabletiers/ultra_constructor", <item:cabletiers:ultra_constructor>, [
    [<item:jsonreg:iron_rod>, <item:jsonreg:duratium_plate>, <item:jsonreg:iron_rod>],
    [<item:minecraft:air>, <item:cabletiers:elite_constructor>, <item:minecraft:air>],
    [<item:jsonreg:iron_rod>, <item:techreborn:advanced_circuit>, <item:jsonreg:iron_rod>]]);
craftingTable.addShaped("rs.cabletiers/ultra_destructor", <item:cabletiers:ultra_destructor>, [
    [<item:jsonreg:iron_rod>, <item:jsonreg:duratium_plate>, <item:jsonreg:iron_rod>],
    [<item:minecraft:air>, <item:cabletiers:elite_destructor>, <item:minecraft:air>],
    [<item:jsonreg:iron_rod>, <item:techreborn:advanced_circuit>, <item:jsonreg:iron_rod>]]);
craftingTable.addShaped("rs.cabletiers/ultra_disk_interface", <item:cabletiers:ultra_disk_interface>, [
    [<item:jsonreg:iron_rod>, <item:jsonreg:duratium_plate>, <item:jsonreg:iron_rod>],
    [<item:minecraft:air>, <item:cabletiers:elite_disk_interface>, <item:minecraft:air>],
    [<item:jsonreg:iron_rod>, <item:techreborn:advanced_circuit>, <item:jsonreg:iron_rod>]]);
craftingTable.addShaped("rs.cabletiers/ultra_interface", <item:cabletiers:ultra_interface>, [
    [<item:jsonreg:iron_rod>, <item:jsonreg:duratium_plate>, <item:jsonreg:iron_rod>],
    [<item:minecraft:air>, <item:cabletiers:elite_interface>, <item:minecraft:air>],
    [<item:jsonreg:iron_rod>, <item:techreborn:advanced_circuit>, <item:jsonreg:iron_rod>]]);
craftingTable.addShaped("rs.cabletiers/ultra_autocrafter", <item:cabletiers:ultra_autocrafter>, [
    [<item:jsonreg:iron_rod>, <item:jsonreg:duratium_plate>, <item:jsonreg:iron_rod>],
    [<item:minecraft:air>, <item:cabletiers:elite_autocrafter>, <item:minecraft:air>],
    [<item:jsonreg:iron_rod>, <item:techreborn:advanced_circuit>, <item:jsonreg:iron_rod>]]);

// ---------- 超级：终极节点 + 1 高级计算引擎 + 4 硅岩板 ----------
craftingTable.addShaped("rs.cabletiers/mega_importer", <item:cabletiers:mega_importer>, [
    [<item:jsonreg:naquadah_plate>, <item:minecraft:air>, <item:jsonreg:naquadah_plate>],
    [<item:minecraft:air>, <item:cabletiers:ultra_importer>, <item:minecraft:air>],
    [<item:jsonreg:naquadah_plate>, <item:oritech:advanced_computing_engine>, <item:jsonreg:naquadah_plate>]]);
craftingTable.addShaped("rs.cabletiers/mega_exporter", <item:cabletiers:mega_exporter>, [
    [<item:jsonreg:naquadah_plate>, <item:minecraft:air>, <item:jsonreg:naquadah_plate>],
    [<item:minecraft:air>, <item:cabletiers:ultra_exporter>, <item:minecraft:air>],
    [<item:jsonreg:naquadah_plate>, <item:oritech:advanced_computing_engine>, <item:jsonreg:naquadah_plate>]]);
craftingTable.addShaped("rs.cabletiers/mega_constructor", <item:cabletiers:mega_constructor>, [
    [<item:jsonreg:naquadah_plate>, <item:minecraft:air>, <item:jsonreg:naquadah_plate>],
    [<item:minecraft:air>, <item:cabletiers:ultra_constructor>, <item:minecraft:air>],
    [<item:jsonreg:naquadah_plate>, <item:oritech:advanced_computing_engine>, <item:jsonreg:naquadah_plate>]]);
craftingTable.addShaped("rs.cabletiers/mega_destructor", <item:cabletiers:mega_destructor>, [
    [<item:jsonreg:naquadah_plate>, <item:minecraft:air>, <item:jsonreg:naquadah_plate>],
    [<item:minecraft:air>, <item:cabletiers:ultra_destructor>, <item:minecraft:air>],
    [<item:jsonreg:naquadah_plate>, <item:oritech:advanced_computing_engine>, <item:jsonreg:naquadah_plate>]]);
craftingTable.addShaped("rs.cabletiers/mega_disk_interface", <item:cabletiers:mega_disk_interface>, [
    [<item:jsonreg:naquadah_plate>, <item:minecraft:air>, <item:jsonreg:naquadah_plate>],
    [<item:minecraft:air>, <item:cabletiers:ultra_disk_interface>, <item:minecraft:air>],
    [<item:jsonreg:naquadah_plate>, <item:oritech:advanced_computing_engine>, <item:jsonreg:naquadah_plate>]]);
craftingTable.addShaped("rs.cabletiers/mega_interface", <item:cabletiers:mega_interface>, [
    [<item:jsonreg:naquadah_plate>, <item:minecraft:air>, <item:jsonreg:naquadah_plate>],
    [<item:minecraft:air>, <item:cabletiers:ultra_interface>, <item:minecraft:air>],
    [<item:jsonreg:naquadah_plate>, <item:oritech:advanced_computing_engine>, <item:jsonreg:naquadah_plate>]]);
craftingTable.addShaped("rs.cabletiers/mega_autocrafter", <item:cabletiers:mega_autocrafter>, [
    [<item:jsonreg:naquadah_plate>, <item:minecraft:air>, <item:jsonreg:naquadah_plate>],
    [<item:minecraft:air>, <item:cabletiers:ultra_autocrafter>, <item:minecraft:air>],
    [<item:jsonreg:naquadah_plate>, <item:oritech:advanced_computing_engine>, <item:jsonreg:naquadah_plate>]]);
