/*CraftTweaker GUI generated script
  Not intended for manual editing
  Changes will be overridden when exporting again*/

import crafttweaker.api.ingredient.type.IIngredientEmpty;
import crafttweaker.api.ingredient.IIngredient;

<recipetype:minecraft:crafting>.removeByName("minecraft:crafting_table");
craftingTable.addShaped("ctgui/new/minecraft/crafting_table", <item:minecraft:crafting_table>, [
    [<tag:item:c:stripped_woods>, <tag:item:c:stripped_woods>],
    [<item:minecraft:flint>, <item:farmersdelight:flint_knife>]]);

<recipetype:minecraft:crafting>.removeByName("minecraft:furnace");
craftingTable.addShaped("ctgui/new/minecraft/furnace", <item:minecraft:furnace>, [
    [<tag:item:minecraft:stone_crafting_materials>, IIngredientEmpty.getInstance(), <tag:item:minecraft:stone_crafting_materials>],
    [<tag:item:minecraft:stone_crafting_materials>, <item:minecraft:flint>, <tag:item:minecraft:stone_crafting_materials>],
    [<tag:item:minecraft:stone_crafting_materials>, <tag:item:minecraft:stone_crafting_materials>, <tag:item:minecraft:stone_crafting_materials>]]);

<recipetype:minecraft:crafting>.removeByName("techreborn:crafting_table/machine/iron_alloy_furnace");
craftingTable.addShaped("ctgui/new/techreborn/crafting_table/machine/iron_alloy_furnace", <item:techreborn:iron_alloy_furnace>, [
    [IIngredientEmpty.getInstance(), <item:techreborn:refined_iron_ingot>, IIngredientEmpty.getInstance()],
    [IIngredientEmpty.getInstance(), <item:techreborn:iron_furnace>, IIngredientEmpty.getInstance()],
    [<item:techreborn:refined_iron_ingot>, <item:minecraft:smooth_stone>, <item:techreborn:refined_iron_ingot>]]);

<recipetype:minecraft:blasting>.removeByName("oritech:plastic_sheet_from_blasting_polymer_resin");

<recipetype:minecraft:smelting>.removeByName("oritech:plastic_sheet_from_smelting_polymer_resin");

<recipetype:minecraft:crafting>.removeByName("oritech:crafting/refinerymodule");

<recipetype:minecraft:crafting>.removeByName("advanced_reborn:crafting/cardboard_box");

<recipetype:minecraft:crafting>.removeByName("advanced_reborn:crafting/cardboard_box3");

<recipetype:minecraft:crafting>.removeByName("advanced_reborn:crafting/cardboard_box2");

<recipetype:minecraft:crafting>.removeByName("advanced_reborn:crafting/cardboard_box4");

<recipetype:minecraft:crafting>.removeByName("techreborn:crafting_table/machine/adjustable_su");
craftingTable.addShaped("ctgui/new/techreborn/crafting_table/machine/adjustable_su", <item:techreborn:adjustable_su>, [
    [<item:techreborn:lapotronic_orb>, <item:techreborn:obsidian_plate>, <item:techreborn:lapotronic_orb>],
    [<item:techreborn:red_garnet_plate>, <item:techreborn:energy_crystal>, <item:techreborn:yellow_garnet_plate>],
    [<item:techreborn:lapotronic_orb>, <item:techreborn:obsidian_plate>, <item:techreborn:lapotronic_orb>]]);

<recipetype:minecraft:crafting>.removeByName("transmog:void_fragment");

<recipetype:minecraft:crafting>.removeByName("interdimensionalwirelesstransmitter:interdimensional_wireless_transmitter");

craftingTable.addShaped("ctgui/new/crafting/blank_mob_capture_card", <item:easy_mob_farm:blank_mob_capture_card>, [
    [<item:advanced_reborn:cardboard_sheet>],
    [<item:transmog:void_fragment>],
    [<item:advanced_reborn:cardboard_sheet>]]);

<recipetype:minecraft:crafting>.removeByName("oritech:crafting/particlecontroller");

craftingTable.addShaped("ctgui/new/oritech/crafting/particlemotor", <item:oritech:accelerator_motor> * 4, [
    [IIngredientEmpty.getInstance(), <item:oritech:superconductor>, IIngredientEmpty.getInstance()],
    [<tag:item:c:ingots/electrum>, <item:oritech:superconductor>, <tag:item:c:ingots/electrum>],
    [<item:oritech:ion_thruster>, <item:oritech:duratium_ingot>, <item:oritech:ion_thruster>]]);

<recipetype:minecraft:crafting>.removeByName("oritech:crafting/particlemotor");

<recipetype:minecraft:crafting>.removeByName("techreborn:crafting_table/cable/superconductor_cable");
craftingTable.addShaped("ctgui/new/techreborn/crafting_table/cable/superconductor_cable", <item:techreborn:superconductor_cable> * 6, [
    [<item:techreborn:advanced_machine_frame>, <item:techreborn:energy_flow_chip>, <item:techreborn:advanced_machine_frame>],
    [<item:techreborn:superconductor>, <item:techreborn:superconductor>, <item:techreborn:superconductor>],
    [<item:techreborn:advanced_machine_frame>, <item:techreborn:energy_flow_chip>, <item:techreborn:advanced_machine_frame>]]);

craftingTable.addShapeless("ctgui/new/crafting/crystal_matrix_ingot_split", <item:avaritia:crystal_matrix_ingot> * 9, [<item:avaritia:crystal_matrix_block>]);

craftingTable.addShapeless("ctgui/new/crafting/neutron_split", <item:avaritia:neutronium_ingot> * 9, [<item:avaritia:neutronium_block>]);

<recipetype:minecraft:crafting>.removeByName("avaritia:crystal_matrix_ingot");

<recipetype:minecraft:crafting>.removeByName("oritech:motor/dubios");
craftingTable.addShaped("ctgui/new/oritech/motor/dubios", <item:oritech:dubios_container>, [
    [IIngredientEmpty.getInstance(), <tag:item:c:plates/plastic>, IIngredientEmpty.getInstance()],
    [<item:oritech:enderic_compound>, <item:oritech:adamant_ingot>, <item:oritech:enderic_compound>],
    [<item:techreborn:iron_plate>, <item:oritech:adamant_ingot>, <item:techreborn:iron_plate>]]);

<recipetype:minecraft:crafting>.removeByName("techreborn:crafting_table/ingot/iridium_alloy_ingot");
craftingTable.addShaped("ctgui/new/techreborn/crafting_table/ingot/iridium_alloy_ingot", <item:techreborn:iridium_alloy_ingot>, [
    [<tag:item:c:plates/iridium>, <item:techreborn:advanced_alloy_plate>, <tag:item:c:plates/iridium>],
    [<item:techreborn:advanced_alloy_plate>, <item:techreborn:titanium_plate>, <item:techreborn:advanced_alloy_plate>],
    [<tag:item:c:plates/iridium>, <item:techreborn:advanced_alloy_plate>, <tag:item:c:plates/iridium>]]);

<recipetype:minecraft:crafting>.removeByName("oritech:crafting/centrifuge");

<recipetype:minecraft:crafting>.removeByName("toneko:neko_aggregator");

<recipetype:minecraft:crafting>.removeByName("techreborn:crafting_table/machine/wind_mill_alt");

<recipetype:minecraft:crafting>.removeByName("techreborn:crafting_table/machine/wind_mill");

craftingTable.addShapeless("ctgui/new/crafting/wind_mill", <item:techreborn:wind_mill>, [<item:techreborn:solid_fuel_generator>, <item:jsonreg:rotor>, <item:techreborn:invar_plate>]);

craftingTable.addShaped("ctgui/new/crafting/naquadah_dust", <item:jsonreg:naquadah_dust>, [
    [<item:jsonreg:tiny_naquadah_dust>, <item:jsonreg:tiny_naquadah_dust>, <item:jsonreg:tiny_naquadah_dust>],
    [<item:jsonreg:tiny_naquadah_dust>, <item:jsonreg:tiny_naquadah_dust>, <item:jsonreg:tiny_naquadah_dust>],
    [<item:jsonreg:tiny_naquadah_dust>, <item:jsonreg:tiny_naquadah_dust>, <item:jsonreg:tiny_naquadah_dust>]]);

<recipetype:minecraft:crafting>.removeByName("oritech:crafting/biogen");
craftingTable.addShaped("ctgui/new/oritech/crafting/biogen", <item:oritech:bio_generator_block>, [
    [<item:techreborn:steel_plate>, <item:techreborn:invar_plate>, <item:techreborn:steel_plate>],
    [<item:techreborn:invar_plate>, <item:minecraft:bucket>, <item:techreborn:invar_plate>],
    [<item:oritech:magnetic_coil>, <item:oritech:basic_generator_block>, <item:oritech:magnetic_coil>]]);

<recipetype:minecraft:crafting>.removeByName("oritech:crafting/solar");
craftingTable.addShaped("ctgui/new/oritech/crafting/solar", <item:oritech:big_solar_panel_block>, [
    [<item:techreborn:silicon_plate>, <item:techreborn:silicon_plate>, <item:techreborn:silicon_plate>],
    [<item:oritech:framed_energy_pipe>, <item:oritech:motor>, <item:oritech:framed_energy_pipe>],
    [<item:techreborn:lithium_ion_battery>, <item:oritech:basic_generator_block>, <item:techreborn:lithium_ion_battery>]]);

<recipetype:minecraft:crafting>.removeByName("techreborn:crafting_table/machine/lightning_rod");

craftingTable.addShapeless("ctgui/new/crafting/dual_naquadria_fuel_rod", <item:jsonreg:dual_naquadria_fuel_rod>, [<item:jsonreg:naquadria_fuel_rod>, <item:jsonreg:naquadria_fuel_rod>]);

craftingTable.addShapeless("ctgui/new/crafting/dual_uranium_fuel_rod", <item:jsonreg:dual_uranium_fuel_rod>, [<item:jsonreg:uranium_fuel_rod>, <item:jsonreg:uranium_fuel_rod>]);

craftingTable.addShapeless("ctgui/new/crafting/dual_mox_fuel_rod", <item:jsonreg:dual_mox_fuel_rod>, [<item:jsonreg:mox_fuel_rod>, <item:jsonreg:mox_fuel_rod>]);

craftingTable.addShapeless("ctgui/new/crafting/dual_thorium_fuel_rod", <item:jsonreg:dual_thorium_fuel_rod>, [<item:jsonreg:thorium_fuel_rod>, <item:jsonreg:thorium_fuel_rod>]);

<recipetype:minecraft:crafting>.removeByName("oritech:crafting/refinery");
craftingTable.addShaped("ctgui/new/oritech/crafting/refinery", <item:oritech:refinery_block>, [
    [IIngredientEmpty.getInstance(), <item:oritech:motor>, IIngredientEmpty.getInstance()],
    [<item:oritech:refinery_module_block>, <item:techreborn:solid_fuel_generator>, <item:oritech:refinery_module_block>],
    [<item:techreborn:steel_plate>, <item:techreborn:basic_machine_frame>, <item:techreborn:steel_plate>]]);

<recipetype:minecraft:crafting>.removeByName("techreborn:crafting_table/machine/chemical_reactor");
craftingTable.addShaped("ctgui/new/techreborn/crafting_table/machine/chemical_reactor", <item:techreborn:chemical_reactor>, [
    [<tag:item:c:plates/invar>, <item:jsonreg:lv_robot_arm>, <tag:item:c:plates/invar>],
    [<item:techreborn:electronic_circuit>, <item:jsonreg:lv_conveyor_module>, <item:techreborn:electronic_circuit>],
    [<tag:item:c:plates/invar>, <item:techreborn:extractor>, <tag:item:c:plates/invar>]]);

<recipetype:minecraft:crafting>.removeByName("techreborn:crafting_table/machine/compressor");
craftingTable.addShaped("ctgui/new/techreborn/crafting_table/machine/compressor", <item:techreborn:compressor>, [
    [IIngredientEmpty.getInstance(), <item:techreborn:refined_iron_ingot>, IIngredientEmpty.getInstance()],
    [<item:oritech:motor>, <item:techreborn:electronic_circuit>, <item:oritech:motor>],
    [<item:techreborn:refined_iron_ingot>, <item:techreborn:basic_machine_frame>, <item:techreborn:refined_iron_ingot>]]);

<recipetype:minecraft:crafting>.removeByName("techreborn:crafting_table/machine/canning_machine");
craftingTable.addShaped("ctgui/new/techreborn/crafting_table/machine/canning_machine_0", <item:techreborn:solid_canning_machine>, [
    [<item:jsonreg:lv_robot_arm>, <item:techreborn:electronic_circuit>, <item:jsonreg:lv_robot_arm>],
    [IIngredientEmpty.getInstance(), <item:techreborn:basic_machine_frame>, IIngredientEmpty.getInstance()],
    [<tag:item:c:ingots/tin>, <item:oritech:motor>, <tag:item:c:ingots/tin>]]);

craftingTable.addShaped("ctgui/new/crafting/neutron_collector_fuck", <item:avaritia:neutron_collector>, [
    [IIngredientEmpty.getInstance(), <item:jsonreg:holy_wooden_bucket>, IIngredientEmpty.getInstance()],
    [<item:oritech:motor>, <item:techreborn:basic_machine_frame>, <item:oritech:motor>],
    [<item:techreborn:refined_iron_ingot>, IIngredientEmpty.getInstance(), <item:techreborn:refined_iron_ingot>]]);

<recipetype:minecraft:crafting>.removeByName("techreborn:crafting_table/machine/extractor");
craftingTable.addShaped("ctgui/new/techreborn/crafting_table/machine/extractor_0", <item:techreborn:extractor>, [
    [IIngredientEmpty.getInstance(), <item:techreborn:basic_machine_frame>, IIngredientEmpty.getInstance()],
    [<item:techreborn:treetap>, <item:techreborn:electronic_circuit>, <item:techreborn:treetap>],
    [<item:techreborn:refined_iron_ingot>, <item:oritech:motor>, <item:techreborn:refined_iron_ingot>]]);

<recipetype:minecraft:crafting>.removeByName("oritech:crafting/refinerymodulealt");
craftingTable.addShaped("ctgui/new/oritech/crafting/refinerymodulealt_0", <item:oritech:refinery_module_block>, [
    [<item:techreborn:invar_ingot>, <item:techreborn:reinforced_glass>, <item:techreborn:invar_ingot>],
    [<item:techreborn:reinforced_glass>, <item:oritech:metal_beam_block>, <item:techreborn:reinforced_glass>],
    [<item:oritech:silicon>, <item:techreborn:basic_tank_unit>, <item:oritech:silicon>]]);

<recipetype:minecraft:crafting>.removeByName("techreborn:crafting_table/machine/grinder");
craftingTable.addShaped("ctgui/new/techreborn/crafting_table/machine/grinder", <item:techreborn:grinder>, [
    [<item:oritech:motor>, <item:techreborn:basic_machine_frame>, <item:oritech:motor>],
    [<item:jsonreg:steel_rod>, <item:techreborn:electronic_circuit>, <item:jsonreg:steel_rod>],
    [IIngredientEmpty.getInstance(), <item:jsonreg:steel_rod>, IIngredientEmpty.getInstance()]]);

<recipetype:minecraft:crafting>.removeByName("techreborn:crafting_table/machine/wire_mill");
craftingTable.addShaped("ctgui/new/techreborn/crafting_table/machine/wire_mill", <item:techreborn:wire_mill>, [
    [<tag:item:c:plates/brass>, <item:techreborn:extractor>, <tag:item:c:plates/brass>],
    [<item:techreborn:electronic_circuit>, <item:techreborn:basic_machine_frame>, <item:techreborn:electronic_circuit>],
    [<item:oritech:motor>, IIngredientEmpty.getInstance(), <item:oritech:motor>]]);

craftingTable.addShaped("ctgui/new/crafting/refined_iron_rod", <item:jsonreg:refined_iron_rod>, [
    [<item:techreborn:refined_iron_ingot>],
    [<item:techreborn:refined_iron_ingot>]]);

craftingTable.addShaped("ctgui/new/crafting/iron_rod", <item:jsonreg:iron_rod>, [
    [<item:minecraft:iron_ingot>],
    [<item:minecraft:iron_ingot>]]);

craftingTable.addShaped("ctgui/new/crafting/bronze_rod", <item:jsonreg:bronze_rod>, [
    [<item:techreborn:bronze_ingot>],
    [<item:techreborn:bronze_ingot>]]);

<recipetype:minecraft:crafting>.removeByName("oritech:steel_blockblock");

craftingTable.addShaped("ctgui/new/crafting/steel_rod", <item:jsonreg:steel_rod>, [
    [<item:techreborn:steel_ingot>],
    [<item:techreborn:steel_ingot>]]);

craftingTable.addShaped("ctgui/new/crafting/invar_rod", <item:jsonreg:invar_rod>, [
    [<item:techreborn:invar_ingot>],
    [<item:techreborn:invar_ingot>]]);

craftingTable.addShaped("ctgui/new/crafting/copper_rod", <item:jsonreg:copper_rod>, [
    [<item:minecraft:copper_ingot>],
    [<item:minecraft:copper_ingot>]]);

<recipetype:minecraft:crafting>.removeByName("oritech:crafting/magnet");
craftingTable.addShaped("ctgui/new/oritech/crafting/magnet", <item:oritech:magnetic_coil> * 3, [
    [<tag:item:c:ingots/nickel>, <item:jsonreg:copper_rod>, <tag:item:c:ingots/nickel>],
    [<tag:item:c:ingots/steel>, <item:jsonreg:copper_rod>, <tag:item:c:ingots/steel>],
    [<tag:item:c:ingots/nickel>, <item:jsonreg:copper_rod>, <tag:item:c:ingots/nickel>]]);

craftingTable.addShaped("ctgui/new/crafting/small_photon_dust", <item:jsonreg:small_photon_dust>, [
    [<item:jsonreg:tiny_photon_dust>, <item:jsonreg:tiny_photon_dust>],
    [<item:jsonreg:tiny_photon_dust>, <item:jsonreg:tiny_photon_dust>]]);

craftingTable.addShaped("ctgui/new/crafting/photon_dust", <item:jsonreg:photon_dust>, [
    [<item:jsonreg:small_photon_dust>, <item:jsonreg:small_photon_dust>],
    [<item:jsonreg:small_photon_dust>, <item:jsonreg:small_photon_dust>]]);

<recipetype:minecraft:crafting>.removeByName("oritech:crafting/lavagen");
craftingTable.addShaped("ctgui/new/oritech/crafting/lavagen", <item:oritech:lava_generator_block>, [
    [<item:techreborn:steel_plate>, <item:techreborn:electronic_circuit>, <item:techreborn:steel_plate>],
    [<item:techreborn:electrum_plate>, <item:techreborn:basic_tank_unit>, <item:techreborn:electrum_plate>],
    [<item:oritech:magnetic_coil>, <item:oritech:basic_generator_block>, <item:oritech:magnetic_coil>]]);

<recipetype:minecraft:crafting>.removeByName("oritech:crafting/fuelgen");
craftingTable.addShaped("ctgui/new/oritech/crafting/fuelgen", <item:oritech:fuel_generator_block>, [
    [<item:techreborn:tungstensteel_plate>, <item:jsonreg:duratium_plate>, <item:techreborn:tungstensteel_plate>],
    [<item:techreborn:steel_plate>, <item:oritech:advanced_computing_engine>, <item:techreborn:steel_plate>],
    [<item:oritech:basic_generator_block>, <item:jsonreg:rotor>, <item:oritech:basic_generator_block>]]);

<recipetype:minecraft:crafting>.removeByName("techreborn:crafting_table/machine/diesel_generator");

<recipetype:minecraft:crafting>.removeByName("techreborn:crafting_table/machine/diesel_generator_alt");
craftingTable.addShaped("ctgui/new/techreborn/crafting_table/machine/diesel_generator", <item:techreborn:diesel_generator>, [
    [<tag:item:c:plates/aluminum>, <item:jsonreg:rotor>, <tag:item:c:plates/aluminum>],
    [<item:techreborn:steel_plate>, <item:techreborn:basic_tank_unit>, <item:techreborn:steel_plate>],
    [<item:oritech:processing_unit>, <item:techreborn:solid_fuel_generator>, <item:oritech:processing_unit>]]);

<recipetype:minecraft:crafting>.removeByName("techreborn:crafting_table/machine/semi_fluid_generator_alt");

<recipetype:minecraft:crafting>.removeByName("techreborn:crafting_table/machine/semi_fluid_generator");
craftingTable.addShaped("ctgui/new/techreborn/crafting_table/machine/semi_fluid_generator", <item:techreborn:semi_fluid_generator>, [
    [<tag:item:c:plates/iron>, <item:jsonreg:rotor>, <tag:item:c:plates/iron>],
    [<tag:item:c:plates/iron>, <item:techreborn:reinforced_glass>, <tag:item:c:plates/iron>],
    [<item:techreborn:electronic_circuit>, <item:techreborn:solid_fuel_generator>, <item:techreborn:electronic_circuit>]]);

<recipetype:minecraft:crafting>.removeByName("techreborn:crafting_table/machine/gas_turbine");

<recipetype:minecraft:crafting>.removeByName("techreborn:crafting_table/machine/gas_turbine_alt");
craftingTable.addShaped("ctgui/new/techreborn/crafting_table/machine/gas_turbine", <item:techreborn:gas_turbine>, [
    [<tag:item:c:plates/aluminum>, <item:oritech:processing_unit>, <tag:item:c:plates/aluminum>],
    [<item:techreborn:wind_mill>, <item:techreborn:reinforced_glass>, <item:techreborn:wind_mill>],
    [<tag:item:c:plates/aluminum>, <item:oritech:processing_unit>, <tag:item:c:plates/aluminum>]]);

craftingTable.addShaped("ctgui/new/crafting/lv_electric_piston", <item:jsonreg:lv_electric_piston>, [
    [<item:techreborn:steel_plate>, <item:techreborn:steel_plate>, <item:techreborn:steel_plate>],
    [<item:techreborn:insulated_copper_cable>, <item:jsonreg:steel_rod>, <item:jsonreg:steel_rod>],
    [<item:techreborn:insulated_copper_cable>, <item:oritech:motor>, <item:jsonreg:steel_rod>]]);

craftingTable.addShaped("ctgui/new/crafting/lv_conveyor_module", <item:jsonreg:lv_conveyor_module>, [
    [<item:jsonreg:rubber_plate>, <item:jsonreg:rubber_plate>, <item:jsonreg:rubber_plate>],
    [<item:oritech:motor>, <item:techreborn:insulated_copper_cable>, <item:oritech:motor>],
    [<item:jsonreg:rubber_plate>, <item:jsonreg:rubber_plate>, <item:jsonreg:rubber_plate>]]);

craftingTable.addShaped("ctgui/new/crafting/lv_robot_arm", <item:jsonreg:lv_robot_arm>, [
    [<item:techreborn:insulated_copper_cable>, <item:techreborn:insulated_copper_cable>, <item:techreborn:insulated_copper_cable>],
    [<item:oritech:motor>, <item:jsonreg:steel_rod>, <item:oritech:motor>],
    [<item:jsonreg:lv_electric_piston>, <item:techreborn:electronic_circuit>, <item:jsonreg:steel_rod>]]);

<recipetype:minecraft:crafting>.removeByName("techreborn:crafting_table/cable/insulated_copper_cable_shapeless");

<recipetype:minecraft:crafting>.removeByName("techreborn:crafting_table/cable/insulated_copper_cable_alt");

<recipetype:minecraft:crafting>.removeByName("techreborn:crafting_table/cable/insulated_copper_cable");

craftingTable.addShaped("ctgui/new/crafting/copper_cable_insulate", <item:techreborn:insulated_copper_cable>, [
    [<item:jsonreg:rubber_plate>, <item:techreborn:copper_cable>]]);

<recipetype:minecraft:crafting>.removeByName("techreborn:crafting_table/cable/insulated_gold_cable_shapeless");
craftingTable.addShapeless("ctgui/new/techreborn/crafting_table/cable/insulated_gold_cable", <item:techreborn:insulated_gold_cable>, [<item:techreborn:gold_cable>, <item:jsonreg:rubber_plate>, <item:jsonreg:rubber_plate>]);

<recipetype:minecraft:crafting>.removeByName("techreborn:crafting_table/cable/insulated_gold_cable");

<recipetype:minecraft:crafting>.removeByName("techreborn:crafting_table/cable/insulated_hv_cable_shapeless");

<recipetype:minecraft:crafting>.removeByName("techreborn:crafting_table/cable/insulated_hv_cable");

<recipetype:minecraft:crafting>.removeByName("techreborn:crafting_table/cable/gold_cable");
craftingTable.addShaped("ctgui/new/techreborn/crafting_table/cable/gold_cable", <item:techreborn:gold_cable> * 4, [
    [<tag:item:c:ingots/gold>, <tag:item:c:ingots/gold>, <tag:item:c:ingots/gold>]]);

<recipetype:minecraft:crafting>.removeByName("techreborn:crafting_table/cable/hv_cable");
craftingTable.addShaped("ctgui/new/techreborn/crafting_table/cable/hv_cable", <item:techreborn:hv_cable> * 4, [
    [<item:techreborn:silver_ingot>, <item:techreborn:silver_ingot>, <item:techreborn:silver_ingot>]]);

<recipetype:minecraft:crafting>.removeByName("oritech:crafting/augment/applicator");
craftingTable.addShaped("ctgui/new/oritech/crafting/augment/applicator", <item:oritech:augment_application_block>, [
    [<item:oritech:dubios_container>, <tag:item:c:carbon_fibre>, <item:oritech:dubios_container>],
    [<item:jsonreg:mv_sensor>, <item:jsonreg:mv_robot_arm>, <item:jsonreg:mv_emitter>],
    [<tag:item:oritech:plating>, <tag:item:oritech:plating>, <tag:item:oritech:plating>]]);

<recipetype:minecraft:crafting>.removeByName("infinite_pie:infinite_pi");

<recipetype:minecraft:crafting>.removeByName("techreborn:crafting_table/machine_block/advanced_machine_casing_alt");

<recipetype:minecraft:crafting>.removeByName("oritech:crafting/crusher");
craftingTable.addShaped("ctgui/new/oritech/crafting/crusher", <item:oritech:fragment_forge_block>, [
    [<item:jsonreg:mv_conveyor_module>, <item:jsonreg:mv_robot_arm>, <item:jsonreg:mv_conveyor_module>],
    [<item:oritech:plastic_sheet>, <item:oritech:flux_gate>, <item:oritech:plastic_sheet>],
    [<item:jsonreg:mv_electric_motor>, <item:techreborn:advanced_machine_casing>, <item:jsonreg:mv_electric_motor>]]);

craftingTable.addShaped("ctgui/new/crafting/mv_electric_piston", <item:jsonreg:mv_electric_piston>, [
    [<item:techreborn:aluminum_plate>, <item:techreborn:aluminum_plate>, <item:techreborn:aluminum_plate>],
    [<item:techreborn:insulated_gold_cable>, <item:jsonreg:aluminum_rod>, <item:jsonreg:aluminum_rod>],
    [<item:techreborn:insulated_gold_cable>, <item:jsonreg:mv_electric_motor>, <item:jsonreg:aluminum_rod>]]);

craftingTable.addShaped("ctgui/new/crafting/mv_robot_arm", <item:jsonreg:mv_robot_arm>, [
    [<item:techreborn:insulated_gold_cable>, <item:techreborn:insulated_gold_cable>, <item:techreborn:insulated_gold_cable>],
    [<item:jsonreg:mv_electric_motor>, <item:jsonreg:aluminum_rod>, <item:jsonreg:mv_electric_motor>],
    [<item:jsonreg:mv_electric_piston>, <item:techreborn:advanced_circuit>, <item:jsonreg:aluminum_rod>]]);

craftingTable.addShaped("ctgui/new/crafting/mv_conveyor_module", <item:jsonreg:mv_conveyor_module>, [
    [<item:jsonreg:polyethylene_plate>, <item:jsonreg:polyethylene_plate>, <item:jsonreg:polyethylene_plate>],
    [<item:jsonreg:mv_electric_motor>, <item:techreborn:insulated_gold_cable>, <item:jsonreg:mv_electric_motor>],
    [<item:jsonreg:polyethylene_plate>, <item:jsonreg:polyethylene_plate>, <item:jsonreg:polyethylene_plate>]]);

craftingTable.addShaped("ctgui/new/crafting/mv_sensor", <item:jsonreg:mv_sensor>, [
    [<item:techreborn:aluminum_plate>, IIngredientEmpty.getInstance(), <tag:item:c:gems/quartz>],
    [<item:techreborn:aluminum_plate>, <item:jsonreg:electrum_rod>, IIngredientEmpty.getInstance()],
    [<item:techreborn:advanced_circuit>, <item:techreborn:aluminum_plate>, <item:techreborn:aluminum_plate>]]);

craftingTable.addShaped("ctgui/new/crafting/mv_emitter", <item:jsonreg:mv_emitter>, [
    [<item:techreborn:insulated_gold_cable>, <item:jsonreg:electrum_rod>, <item:techreborn:advanced_circuit>],
    [<item:jsonreg:electrum_rod>, <item:minecraft:emerald>, <item:jsonreg:electrum_rod>],
    [<item:techreborn:advanced_circuit>, <item:jsonreg:electrum_rod>, <item:techreborn:insulated_gold_cable>]]);

craftingTable.addShaped("ctgui/new/crafting/hv_electric_piston", <item:jsonreg:hv_electric_piston>, [
    [<item:jsonreg:naquadah_plate>, <item:jsonreg:naquadah_plate>, <item:jsonreg:naquadah_plate>],
    [<item:techreborn:insulated_hv_cable>, <item:jsonreg:naquadah_rod>, <item:jsonreg:naquadah_rod>],
    [<item:techreborn:insulated_hv_cable>, <item:jsonreg:hv_electric_motor>, <item:jsonreg:duratium_rod>]]);

craftingTable.addShaped("ctgui/new/crafting/hv_robot_arm", <item:jsonreg:hv_robot_arm>, [
    [<item:techreborn:insulated_hv_cable>, <item:techreborn:insulated_hv_cable>, <item:techreborn:insulated_hv_cable>],
    [<item:jsonreg:hv_electric_motor>, <item:jsonreg:duratium_rod>, <item:jsonreg:hv_electric_motor>],
    [<item:jsonreg:hv_electric_piston>, <item:techreborn:industrial_circuit>, <item:jsonreg:naquadah_rod>]]);

craftingTable.addShaped("ctgui/new/crafting/hv_conveyor_module", <item:jsonreg:hv_conveyor_module>, [
    [<item:jsonreg:pbi_plate>, <item:jsonreg:pbi_plate>, <item:jsonreg:pbi_plate>],
    [<item:jsonreg:hv_electric_motor>, <item:techreborn:insulated_hv_cable>, <item:jsonreg:hv_electric_motor>],
    [<item:jsonreg:pbi_plate>, <item:jsonreg:pbi_plate>, <item:jsonreg:pbi_plate>]]);

<recipetype:minecraft:crafting>.removeByName("oritech:crafting/handdrill");
craftingTable.addShaped("ctgui/new/oritech/crafting/handdrill", <item:oritech:hand_drill>, [
    [IIngredientEmpty.getInstance(), <item:jsonreg:mv_robot_arm>, IIngredientEmpty.getInstance()],
    [<item:oritech:enderic_lens>, <item:oritech:adamant_ingot>, <item:oritech:enderic_lens>],
    [<item:jsonreg:mv_electric_motor>, <item:techreborn:steel_plate>, <item:techreborn:steel_plate>]]);

<recipetype:minecraft:crafting>.removeByName("oritech:crafting/chainsaw");
craftingTable.addShaped("ctgui/new/oritech/crafting/chainsaw", <item:oritech:chainsaw>, [
    [IIngredientEmpty.getInstance(), <item:oritech:enderic_lens>, <item:jsonreg:mv_robot_arm>],
    [IIngredientEmpty.getInstance(), <item:oritech:adamant_ingot>, IIngredientEmpty.getInstance()],
    [<item:jsonreg:mv_electric_motor>, <item:techreborn:steel_plate>, <item:jsonreg:steel_rod>]]);

<recipetype:minecraft:crafting>.removeByName("oritech:crafting/reactorvent");
craftingTable.addShaped("ctgui/new/oritech/crafting/reactorvent", <item:oritech:reactor_vent>, [
    [IIngredientEmpty.getInstance(), <item:techreborn:carbon_plate>, IIngredientEmpty.getInstance()],
    [<item:techreborn:lead_plate>, <item:jsonreg:mv_electric_piston>, <item:techreborn:lead_plate>],
    [IIngredientEmpty.getInstance(), <item:techreborn:carbon_plate>, IIngredientEmpty.getInstance()]]);

<recipetype:minecraft:crafting>.removeByName("oritech:crafting/_hunter");
craftingTable.addShaped("ctgui/new/oritech/crafting/machine_hunter", <item:oritech:machine_hunter_addon>, [
    [IIngredientEmpty.getInstance(), <item:jsonreg:mv_sensor>, IIngredientEmpty.getInstance()],
    [<item:oritech:plastic_sheet>, <tag:item:minecraft:swords>, <item:oritech:plastic_sheet>],
    [<item:jsonreg:mv_electric_motor>, <item:oritech:plastic_sheet>, <item:jsonreg:mv_electric_motor>]]);

<recipetype:minecraft:crafting>.removeByName("oritech:crafting/addon/cropfilter");
craftingTable.addShaped("ctgui/new/oritech/crafting/addon/cropfilter", <item:oritech:crop_filter_addon>, [
    [IIngredientEmpty.getInstance(), <item:jsonreg:mv_robot_arm>, IIngredientEmpty.getInstance()],
    [<item:techreborn:carbon_plate>, <item:jsonreg:mv_sensor>, <item:techreborn:carbon_plate>],
    [<item:jsonreg:mv_electric_motor>, <tag:item:oritech:plating>, <item:jsonreg:mv_electric_motor>]]);

<recipetype:minecraft:crafting>.removeByName("oritech:crafting/cooler");
craftingTable.addShaped("ctgui/new/oritech/crafting/cooler", <item:oritech:cooler_block>, [
    [<item:techreborn:iron_plate>, <item:techreborn:nak_coolant_cell_180k>, <item:techreborn:iron_plate>],
    [<item:techreborn:iron_plate>, <item:jsonreg:mv_electric_motor>, <item:techreborn:iron_plate>],
    [<item:jsonreg:mv_electric_piston>, <item:minecraft:cauldron>, <item:jsonreg:mv_electric_piston>]]);

<recipetype:minecraft:crafting>.removeByName("oritech:crafting/droneport");

<recipetype:minecraft:crafting>.removeByName("oritech:crafting/droneportalt");
craftingTable.addShaped("ctgui/new/oritech/crafting/droneport", <item:oritech:drone_port_block>, [
    [<item:oritech:advanced_computing_engine>, <item:jsonreg:mv_electric_motor>, <item:oritech:advanced_computing_engine>],
    [<item:jsonreg:mv_sensor>, <item:techreborn:advanced_machine_casing>, <item:jsonreg:mv_emitter>],
    [<item:techreborn:bronze_plate>, <item:techreborn:advanced_machine_casing>, <item:techreborn:bronze_plate>]]);

<recipetype:minecraft:crafting>.removeByName("oritech:crafting/addon/processingalt");
craftingTable.addShaped("ctgui/new/oritech/crafting/addon/processingalt", <item:oritech:machine_processing_addon>, [
    [<item:jsonreg:hv_electric_motor>, <item:oritech:machine_burst_addon>, <item:jsonreg:hv_electric_motor>],
    [<item:techreborn:electrum_plate>, <item:oritech:super_ai_chip>, <item:techreborn:electrum_plate>],
    [<tag:item:oritech:plating>, <tag:item:oritech:plating>, <tag:item:oritech:plating>]]);

<recipetype:minecraft:crafting>.removeByName("oritech:crafting/shrinker");
craftingTable.addShaped("ctgui/new/oritech/crafting/shrinker", <item:oritech:shrinker_block>, [
    [<item:jsonreg:hv_robot_arm>, <item:botania:gaia_ingot>, <item:jsonreg:hv_conveyor_module>],
    [<item:oritech:superconductor>, <item:jsonreg:gravi_star>, <item:oritech:superconductor>],
    [<item:jsonreg:hv_conveyor_module>, <item:techreborn:industrial_machine_casing>, <item:jsonreg:hv_robot_arm>]]);

<recipetype:minecraft:crafting>.removeByName("oritech:crafting/augment/basic");
craftingTable.addShaped("ctgui/new/oritech/crafting/augment/basic", <item:oritech:simple_augment_station>, [
    [<item:techreborn:electrum_plate>, <item:jsonreg:mv_robot_arm>, <item:techreborn:electrum_plate>],
    [<item:techreborn:electrum_plate>, <tag:item:c:storage_blocks/redstone>, <item:techreborn:electrum_plate>],
    [<tag:item:oritech:plating>, <item:minecraft:brewing_stand>, <tag:item:oritech:plating>]]);

<recipetype:minecraft:crafting>.removeByName("oritech:crafting/augment/advanced");
craftingTable.addShaped("ctgui/new/oritech/crafting/augment/advanced", <item:oritech:advanced_augment_station>, [
    [IIngredientEmpty.getInstance(), <item:jsonreg:mv_sensor>, IIngredientEmpty.getInstance()],
    [<item:jsonreg:enriched_naquadah_rod>, <item:oritech:flux_gate>, <item:jsonreg:enriched_naquadah_rod>],
    [<tag:item:oritech:plating>, <item:jsonreg:mv_electric_motor>, <tag:item:oritech:plating>]]);

<recipetype:minecraft:crafting>.removeByName("oritech:crafting/augment/arcane");
craftingTable.addShaped("ctgui/new/oritech/crafting/augment/arcane", <item:oritech:arcane_augment_station>, [
    [<item:oritech:overcharged_crystal>, <item:eternal_starlight:aethersent_ingot>, <item:oritech:overcharged_crystal>],
    [<item:oritech:overcharged_crystal>, <item:jsonreg:duratium_rod>, <item:oritech:overcharged_crystal>],
    [<item:techreborn:electrum_plate>, <item:jsonreg:gravi_star>, <item:techreborn:electrum_plate>]]);

<recipetype:minecraft:crafting>.removeByName("oritech:crafting/addon/speed");
craftingTable.addShaped("ctgui/new/oritech/crafting/addon/speed", <item:oritech:machine_speed_addon>, [
    [<tag:item:c:plates/plastic>, <item:jsonreg:lv_robot_arm>, <tag:item:c:plates/plastic>],
    [<tag:item:c:plates/plastic>, <tag:item:c:ingots/steel>, <tag:item:c:plates/plastic>],
    [<item:oritech:magnetic_coil>, <tag:item:oritech:plating>, <item:oritech:magnetic_coil>]]);

<recipetype:minecraft:crafting>.removeByName("oritech:crafting/addon/eff");
craftingTable.addShaped("ctgui/new/oritech/crafting/addon/eff", <item:oritech:machine_efficiency_addon>, [
    [<tag:item:c:plates/plastic>, <item:jsonreg:lv_robot_arm>, <tag:item:c:plates/plastic>],
    [<tag:item:c:plates/plastic>, <item:techreborn:electronic_circuit>, <tag:item:c:plates/plastic>],
    [<item:techreborn:carbon_plate>, <tag:item:oritech:plating>, <item:techreborn:carbon_plate>]]);

<recipetype:minecraft:crafting>.removeByName("oritech:crafting/addon/ultimate");
craftingTable.addShaped("ctgui/new/oritech/crafting/addon/ultimate", <item:oritech:machine_ultimate_addon>, [
    [<item:oritech:overcharged_crystal>, <item:oritech:machine_efficiency_addon>, <item:oritech:overcharged_crystal>],
    [<item:oritech:heisenberg_compensator>, <item:oritech:machine_speed_addon>, <item:oritech:heisenberg_compensator>],
    [<item:jsonreg:mv_robot_arm>, <item:techreborn:industrial_circuit>, <item:jsonreg:mv_robot_arm>]]);

<recipetype:minecraft:crafting>.removeByName("oritech:crafting/addon/quarry");
craftingTable.addShaped("ctgui/new/oritech/crafting/addon/quarry", <item:oritech:quarry_addon>, [
    [<tag:item:c:plates/plastic>, <item:oritech:enderic_lens>, <tag:item:c:plates/plastic>],
    [<tag:item:c:plates/plastic>, <tag:item:minecraft:pickaxes>, <tag:item:c:plates/plastic>],
    [<item:oritech:motor>, <tag:item:oritech:plating>, <item:oritech:motor>]]);

<recipetype:minecraft:crafting>.removeByName("oritech:crafting/addon/processing");

<recipetype:minecraft:crafting>.removeByName("oritech:crafting/addon/fluid");
craftingTable.addShaped("ctgui/new/oritech/crafting/addon/fluid", <item:oritech:machine_fluid_addon>, [
    [IIngredientEmpty.getInstance(), <item:oritech:fluid_pipe>, IIngredientEmpty.getInstance()],
    [<item:techreborn:invar_plate>, <item:oritech:fluid_pipe>, <item:techreborn:invar_plate>],
    [<tag:item:c:ingots/electrum>, <item:techreborn:carbon_plate>, <tag:item:c:ingots/electrum>]]);

<recipetype:minecraft:crafting>.removeByName("oritech:crafting/addon/yield");
craftingTable.addShaped("ctgui/new/oritech/crafting/addon/yield", <item:oritech:machine_yield_addon>, [
    [IIngredientEmpty.getInstance(), <item:jsonreg:mv_sensor>, IIngredientEmpty.getInstance()],
    [<item:jsonreg:epoxy_resin_ingot>, <item:oritech:enderic_lens>, <item:jsonreg:epoxy_resin_ingot>],
    [<item:techreborn:electrum_plate>, <tag:item:oritech:plating>, <item:techreborn:electrum_plate>]]);

<recipetype:minecraft:crafting>.removeByName("oritech:crafting/addon/capacitor");
craftingTable.addShaped("ctgui/new/oritech/crafting/addon/capacitor", <item:oritech:machine_capacitor_addon>, [
    [IIngredientEmpty.getInstance(), <item:techreborn:medium_voltage_su>, IIngredientEmpty.getInstance()],
    [<item:jsonreg:mv_voltage_coil>, IIngredientEmpty.getInstance(), <item:jsonreg:mv_voltage_coil>],
    [<item:oritech:energite_ingot>, <tag:item:oritech:plating>, <item:oritech:energite_ingot>]]);

<recipetype:minecraft:crafting>.removeByName("oritech:crafting/addon/acceptor");
craftingTable.addShaped("ctgui/new/oritech/crafting/addon/acceptor", <item:oritech:machine_acceptor_addon>, [
    [IIngredientEmpty.getInstance(), <item:techreborn:lsu_storage>, IIngredientEmpty.getInstance()],
    [<item:jsonreg:epoxy_resin_ingot>, <item:oritech:machine_capacitor_addon>, <item:jsonreg:epoxy_resin_ingot>],
    [<item:techreborn:electrum_plate>, <tag:item:oritech:plating>, <item:techreborn:electrum_plate>]]);

<recipetype:minecraft:crafting>.removeByName("oritech:crafting/addon/steamboileralt");

<recipetype:minecraft:crafting>.removeByName("oritech:crafting/addon/invproxy");
craftingTable.addShaped("ctgui/new/oritech/crafting/addon/invproxy", <item:oritech:machine_inventory_proxy_addon>, [
    [IIngredientEmpty.getInstance(), <item:jsonreg:lv_robot_arm>, IIngredientEmpty.getInstance()],
    [<tag:item:c:carbon_fibre>, <item:oritech:processing_unit>, <tag:item:c:carbon_fibre>],
    [<item:techreborn:bronze_plate>, <item:oritech:motor>, <item:techreborn:bronze_plate>]]);

<recipetype:minecraft:crafting>.removeByName("oritech:crafting/addon/steamboiler");
craftingTable.addShaped("ctgui/new/oritech/crafting/addon/steamboiler", <item:oritech:steam_boiler_addon>, [
    [<item:oritech:fluid_pipe>, <item:jsonreg:mv_electric_piston>, <item:oritech:fluid_pipe>],
    [<item:oritech:fluid_pipe>, <item:techreborn:copper_plate>, <item:oritech:fluid_pipe>],
    [<item:oritech:advanced_computing_engine>, <item:oritech:advanced_computing_engine>, <item:oritech:advanced_computing_engine>]]);

<recipetype:minecraft:crafting>.removeByName("oritech:crafting/addon/silktouch");
craftingTable.addShaped("ctgui/new/oritech/crafting/addon/silktouch", <item:oritech:machine_silk_touch_addon>, [
    [IIngredientEmpty.getInstance(), <item:jsonreg:mv_sensor>, IIngredientEmpty.getInstance()],
    [<item:techreborn:advanced_circuit>, <item:jsonreg:mv_robot_arm>, <item:techreborn:advanced_circuit>],
    [<item:jsonreg:titanium_rod>, <tag:item:oritech:plating>, <item:jsonreg:titanium_rod>]]);

<recipetype:minecraft:crafting>.removeByName("oritech:crafting/addon/burst");
craftingTable.addShaped("ctgui/new/oritech/crafting/addon/burst", <item:oritech:machine_burst_addon>, [
    [IIngredientEmpty.getInstance(), <item:oritech:machine_speed_addon>, IIngredientEmpty.getInstance()],
    [<tag:item:c:ingots/electrum>, <item:oritech:machine_speed_addon>, <tag:item:c:ingots/electrum>],
    [<item:techreborn:advanced_circuit>, <item:techreborn:cell>, <item:techreborn:advanced_circuit>]]);

<recipetype:minecraft:crafting>.removeByName("oritech:crafting/electricfurnacealt");

craftingTable.addShaped("ctgui/new/crafting/field_generator", <item:jsonreg:field_generator>, [
    [<item:oritech:superconductor>, <item:techreborn:tungstensteel_plate>, <item:oritech:superconductor>],
    [<item:techreborn:industrial_circuit>, <item:jsonreg:gravi_star>, <item:techreborn:industrial_circuit>],
    [<item:oritech:superconductor>, <item:techreborn:tungstensteel_plate>, <item:oritech:superconductor>]]);

craftingTable.addShaped("ctgui/new/crafting/plastic_sheet_from_polyethylene", <item:oritech:plastic_sheet>, [
    [<item:jsonreg:polyethylene_plate>]]);

<recipetype:minecraft:crafting>.removeByName("advanced_reborn:crafting/machine/renaming_machine");
craftingTable.addShaped("ctgui/new/advanced_reborn/crafting/machine/renaming_machine", <item:advanced_reborn:renaming_machine>, [
    [<item:jsonreg:refined_iron_rod>, <item:jsonreg:lv_robot_arm>, <item:jsonreg:refined_iron_rod>],
    [IIngredientEmpty.getInstance(), <item:techreborn:basic_machine_frame>, IIngredientEmpty.getInstance()]]);

<recipetype:minecraft:crafting>.removeByName("advanced_reborn:crafting/machine/induction_furnace");
craftingTable.addShaped("ctgui/new/advanced_reborn/crafting/machine/induction_furnace", <item:advanced_reborn:induction_furnace>, [
    [<item:techreborn:invar_plate>, <item:techreborn:cupronickel_heating_coil>, <item:techreborn:invar_plate>],
    [<item:techreborn:cupronickel_heating_coil>, <item:techreborn:electric_furnace>, <item:techreborn:cupronickel_heating_coil>],
    [IIngredientEmpty.getInstance(), <item:techreborn:advanced_machine_frame>, IIngredientEmpty.getInstance()]]);

<recipetype:minecraft:crafting>.removeByName("advanced_reborn:crafting/machine/rotary_grinder");
craftingTable.addShaped("ctgui/new/advanced_reborn/crafting/machine/rotary_grinder", <item:advanced_reborn:rotary_grinder>, [
    [IIngredientEmpty.getInstance(), <item:jsonreg:mv_robot_arm>, IIngredientEmpty.getInstance()],
    [IIngredientEmpty.getInstance(), <item:techreborn:grinder>, IIngredientEmpty.getInstance()],
    [<item:jsonreg:mv_electric_motor>, <item:techreborn:advanced_machine_frame>, <item:jsonreg:mv_electric_motor>]]);

<recipetype:minecraft:crafting>.removeByName("advanced_reborn:crafting/machine/centrifugal_extractor");
craftingTable.addShaped("ctgui/new/advanced_reborn/crafting/machine/centrifugal_extractor", <item:advanced_reborn:centrifugal_extractor>, [
    [<item:jsonreg:mv_electric_motor>, <item:techreborn:cell>, IIngredientEmpty.getInstance()],
    [<item:techreborn:titanium_ingot>, <item:techreborn:extractor>, IIngredientEmpty.getInstance()],
    [<item:jsonreg:mv_robot_arm>, <item:techreborn:advanced_machine_frame>, <item:jsonreg:mv_electric_piston>]]);

<recipetype:minecraft:crafting>.removeByName("advanced_reborn:crafting/machine/singularity_compressor");
craftingTable.addShaped("ctgui/new/advanced_reborn/crafting/machine/singularity_compressor", <item:advanced_reborn:singularity_compressor>, [
    [IIngredientEmpty.getInstance(), <item:jsonreg:mv_electric_motor>, IIngredientEmpty.getInstance()],
    [<item:jsonreg:mv_electric_piston>, <item:techreborn:compressor>, <item:jsonreg:mv_electric_piston>],
    [IIngredientEmpty.getInstance(), <item:techreborn:advanced_machine_frame>, IIngredientEmpty.getInstance()]]);

<recipetype:minecraft:crafting>.removeByName("advanced_reborn:crafting/machine/canning_machine");
craftingTable.addShaped("ctgui/new/advanced_reborn/crafting/machine/canning_machine", <item:advanced_reborn:canning_machine>, [
    [IIngredientEmpty.getInstance(), <item:techreborn:electronic_circuit>, IIngredientEmpty.getInstance()],
    [IIngredientEmpty.getInstance(), <item:techreborn:basic_machine_frame>, IIngredientEmpty.getInstance()],
    [<item:techreborn:refined_iron_plate>, <item:jsonreg:lv_electric_piston>, <item:techreborn:refined_iron_plate>]]);

<recipetype:minecraft:crafting>.removeByName("advanced_reborn:crafting/machine/teleporter");
craftingTable.addShaped("ctgui/new/advanced_reborn/crafting/machine/teleporter", <item:advanced_reborn:teleporter>, [
    [<item:jsonreg:mv_sensor>, <item:tesseract:tesseract>, <item:jsonreg:mv_emitter>],
    [<item:jsonreg:mv_electric_motor>, <item:techreborn:advanced_machine_casing>, <item:jsonreg:mv_electric_motor>],
    [<item:oritech:advanced_computing_engine>, <item:oritech:enderic_lens>, <item:oritech:advanced_computing_engine>]]);

<recipetype:minecraft:crafting>.removeByName("advanced_reborn:crafting/machine/freq_trans");
craftingTable.addShaped("ctgui/new/advanced_reborn/crafting/machine/freq_trans", <item:advanced_reborn:freq_trans>, [
    [<item:techreborn:gps>],
    [<item:techreborn:electronic_circuit>],
    [<item:jsonreg:mv_emitter>]]);

<recipetype:minecraft:crafting>.removeByName("techreborn:crafting_table/machine/industrial_centrifuge");

<recipetype:minecraft:crafting>.removeByName("techreborn:crafting_table/machine/alloy_smelter");
craftingTable.addShaped("ctgui/new/techreborn/crafting_table/machine/alloy_smelter", <item:techreborn:alloy_smelter>, [
    [IIngredientEmpty.getInstance(), <item:techreborn:electronic_circuit>, IIngredientEmpty.getInstance()],
    [<item:techreborn:electric_furnace>, <item:oritech:magnetic_coil>, <item:techreborn:electric_furnace>],
    [IIngredientEmpty.getInstance(), <item:oritech:magnetic_coil>, IIngredientEmpty.getInstance()]]);

<recipetype:minecraft:crafting>.removeByName("techreborn:crafting_table/machine/rolling_machine");
craftingTable.addShaped("ctgui/new/techreborn/crafting_table/machine/rolling_machine", <item:techreborn:rolling_machine>, [
    [<item:jsonreg:lv_electric_piston>, <item:techreborn:advanced_circuit>, <item:jsonreg:lv_electric_piston>],
    [<item:techreborn:compressor>, <item:techreborn:basic_machine_frame>, <item:techreborn:compressor>],
    [<item:jsonreg:lv_electric_piston>, <item:techreborn:advanced_circuit>, <item:jsonreg:lv_electric_piston>]]);

<recipetype:minecraft:crafting>.removeByName("refinedstorage:raw_basic_processor");
craftingTable.addShapeless("ctgui/new/refinedstorage/raw_basic_processor", <item:refinedstorage:raw_basic_processor>, [<item:refinedstorage:processor_binding>, <tag:item:c:silicon>, <tag:item:c:dusts/redstone>, <item:techreborn:iron_plate>]);

<recipetype:minecraft:crafting>.removeByName("refinedstorage:raw_improved_processor");
craftingTable.addShapeless("ctgui/new/refinedstorage/raw_improved_processor", <item:refinedstorage:raw_improved_processor>, [<item:refinedstorage:processor_binding>, <tag:item:c:silicon>, <tag:item:c:dusts/redstone>, <item:techreborn:gold_plate>]);

<recipetype:minecraft:crafting>.removeByName("refinedstorage:raw_advanced_processor");
craftingTable.addShapeless("ctgui/new/refinedstorage/raw_advanced_processor", <item:refinedstorage:raw_advanced_processor>, [<item:refinedstorage:processor_binding>, <tag:item:c:silicon>, <tag:item:c:dusts/redstone>, <item:techreborn:diamond_plate>]);

craftingTable.addShaped("ctgui/new/crafting/t1.processing_unit", <item:oritech:processing_unit>, [
    [<item:jsonreg:smd_capacitor>, <item:jsonreg:smd_resistor>, <item:jsonreg:smd_transistor>],
    [<item:jsonreg:smd_inductor>, <item:jsonreg:basic_circuit_board>, <item:jsonreg:smd_diode>],
    [<item:techreborn:copper_cable>, <item:techreborn:tin_ingot>, <item:techreborn:copper_cable>]]);

craftingTable.addShaped("ctgui/new/crafting/basic_circuit_board", <item:jsonreg:basic_circuit_board>, [
    [<item:techreborn:copper_cable>, <item:techreborn:copper_cable>, <item:techreborn:copper_cable>],
    [<item:techreborn:copper_cable>, <item:oritech:plastic_sheet>, <item:techreborn:copper_cable>],
    [<item:techreborn:copper_cable>, <item:techreborn:copper_cable>, <item:techreborn:copper_cable>]]);

<recipetype:minecraft:crafting>.removeByName("refinedstorage:controller");
craftingTable.addShaped("ctgui/new/refinedstorage/controller", <item:refinedstorage:controller>, [
    [<item:refinedstorage:quartz_enriched_iron>, <item:refinedstorage:advanced_processor>, <item:refinedstorage:quartz_enriched_iron>],
    [<item:techreborn:insulated_copper_cable>, <item:refinedstorage:machine_casing>, <item:techreborn:insulated_copper_cable>],
    [<item:refinedstorage:quartz_enriched_iron>, <item:refinedstorage:advanced_processor>, <item:refinedstorage:quartz_enriched_iron>]]);

craftingTable.addShaped("ctgui/new/crafting/assembly_augment", <item:affinity:assembly_augment>, [
    [<item:affinity:azalea_slab>, <item:affinity:azalea_slab>, <item:affinity:azalea_slab>],
    [<item:minecraft:amethyst_shard>, <tag:item:affinity:wisp_matter>, <item:minecraft:amethyst_shard>],
    [<item:affinity:azalea_log>, IIngredientEmpty.getInstance(), <item:affinity:azalea_log>]]);

<recipetype:minecraft:crafting>.removeByName("affinity:crafting/assembly_augment");

<recipetype:minecraft:crafting>.removeByName("botania:mana_spreader");

<recipetype:minecraft:crafting>.removeByName("botania:runic_altar");

<recipetype:minecraft:crafting>.removeByName("botania:floral_fertilizer");
craftingTable.addShapeless("ctgui/new/botania/floral_fertilizer", <item:botania:floral_fertilizer>, [<item:minecraft:bone_meal>, <tag:item:botania:petals>, <tag:item:botania:petals>]);

<recipetype:minecraft:crafting>.removeByName("avaritia:extreme_crafting_table");
craftingTable.addShaped("ctgui/new/avaritia/extreme_crafting_table", <item:avaritia:extreme_crafting_table>, [
    [<item:techreborn:refined_iron_plate>, <item:techreborn:diamond_plate>, <item:techreborn:refined_iron_plate>],
    [<item:minecraft:crafting_table>, <item:justarod:redstone_rod>, <item:minecraft:crafting_table>],
    [<item:techreborn:refined_iron_plate>, <item:techreborn:diamond_plate>, <item:techreborn:refined_iron_plate>]]);

<recipetype:minecraft:crafting>.removeByName("techreborn:crafting_table/machine/distillation_tower");

craftingTable.addShaped("ctgui/new/crafting/lathe", <item:techreborn:lathe>, [
    [<item:techreborn:electronic_circuit>, <item:jsonreg:lv_electric_piston>, <item:techreborn:electronic_circuit>],
    [<item:jsonreg:iron_rod>, <item:techreborn:basic_machine_frame>, <item:jsonreg:iron_rod>],
    [<item:oritech:motor>, IIngredientEmpty.getInstance(), <item:oritech:motor>]]);

craftingTable.addShaped("ctgui/new/crafting/distillation_tower", <item:techreborn:distillation_tower>, [
    [<item:techreborn:steel_plate>, <item:oritech:processing_unit>, <item:techreborn:steel_plate>],
    [<item:techreborn:extractor>, <item:techreborn:basic_machine_frame>, <item:techreborn:extractor>],
    [<item:techreborn:steel_plate>, <item:oritech:processing_unit>, <item:techreborn:steel_plate>]]);

craftingTable.addShaped("ctgui/new/crafting/primitive_distillation_tower", <item:techreborn:primitive_distillation_tower>, [
    [<item:oritech:fluid_pipe>, <item:jsonreg:lv_electric_piston>, <item:oritech:fluid_pipe>],
    [<item:oritech:fluid_pipe>, <item:techreborn:basic_machine_frame>, <item:oritech:fluid_pipe>],
    [<item:techreborn:invar_plate>, <item:techreborn:solid_fuel_generator>, <item:techreborn:invar_plate>]]);

craftingTable.addShaped("ctgui/new/crafting/small_iron_dust_from_iron_dust", <item:oritech:small_iron_dust> * 9, [
    [<item:oritech:iron_dust>]]);

craftingTable.addShaped("ctgui/new/crafting/multiblock_builder", <item:techreborn:multiblock_builder>, [
    [<item:minecraft:dirt>],
    [<item:minecraft:iron_ingot>],
    [<item:farmersdelight:iron_knife>]]);

craftingTable.addShaped("ctgui/new/crafting/large_compressor", <item:techreborn:large_compressor>, [
    [<item:techreborn:aluminum_plate>, <item:techreborn:compressor>, <item:techreborn:aluminum_plate>],
    [IIngredientEmpty.getInstance(), <item:techreborn:basic_machine_frame>, IIngredientEmpty.getInstance()],
    [<item:techreborn:aluminum_plate>, <item:techreborn:compressor>, <item:techreborn:aluminum_plate>]]);

craftingTable.addShaped("ctgui/new/crafting/large_lathe", <item:techreborn:large_lathe>, [
    [<item:techreborn:aluminum_plate>, <item:oritech:motor>, <item:techreborn:aluminum_plate>],
    [IIngredientEmpty.getInstance(), <item:techreborn:lathe>, IIngredientEmpty.getInstance()],
    [<item:techreborn:aluminum_plate>, <item:jsonreg:refined_iron_rod>, <item:techreborn:aluminum_plate>]]);

craftingTable.addShaped("ctgui/new/crafting/large_wire_mill", <item:techreborn:large_wire_mill>, [
    [<item:techreborn:aluminum_plate>, <item:jsonreg:steel_rod>, <item:techreborn:aluminum_plate>],
    [<item:oritech:motor>, <item:techreborn:wire_mill>, <item:oritech:motor>],
    [<item:techreborn:aluminum_plate>, <item:jsonreg:steel_rod>, <item:techreborn:aluminum_plate>]]);

craftingTable.addShaped("ctgui/new/crafting/precise_assembler", <item:techreborn:precise_assembler>, [
    [<item:jsonreg:mv_robot_arm>, <item:techreborn:assembly_machine>, <item:jsonreg:mv_robot_arm>],
    [<item:oritech:processing_unit>, <item:oritech:assembler_block>, <item:oritech:processing_unit>],
    [<item:jsonreg:duratium_rod>, <item:techreborn:advanced_machine_frame>, <item:jsonreg:duratium_rod>]]);

<recipetype:minecraft:crafting>.removeByName("botania:wand_of_the_forest");

craftingTable.addShapeless("ctgui/new/oritech/small_copper_dust", <item:oritech:small_copper_dust> * 9, [<item:oritech:copper_dust>]);

craftingTable.addShapeless("ctgui/new/oritech/small_gold_dust", <item:oritech:small_gold_dust> * 9, [<item:oritech:gold_dust>]);

<recipetype:minecraft:crafting>.removeByName("botania:terrestrial_agglomeration_plate");

<recipetype:minecraft:crafting>.removeByName("botania:natura_pylon");

<recipetype:minecraft:crafting>.removeByName("mininggadgets:mininggadget_simple");
craftingTable.addShaped("ctgui/new/mininggadgets/mininggadget_simple", <item:mininggadgets:mininggadget_simple>, [
    [IIngredientEmpty.getInstance(), <tag:item:c:gems>, IIngredientEmpty.getInstance()],
    [<item:techreborn:red_cell_battery>, <item:mininggadgets:upgrade_empty>, <item:jsonreg:lv_robot_arm>],
    [IIngredientEmpty.getInstance(), <item:techreborn:iron_plate>, IIngredientEmpty.getInstance()]]);

<recipetype:minecraft:crafting>.removeByName("mininggadgets:upgrade_empty");
craftingTable.addShaped("ctgui/new/mininggadgets/upgrade_empty", <item:mininggadgets:upgrade_empty>, [
    [<tag:item:c:dusts/redstone>, <item:techreborn:iron_plate>, <tag:item:c:dusts/redstone>],
    [IIngredientEmpty.getInstance(), <tag:item:c:glass_panes>, IIngredientEmpty.getInstance()],
    [<tag:item:c:dusts/redstone>, <item:techreborn:iron_plate>, <tag:item:c:dusts/redstone>]]);

<recipetype:minecraft:crafting>.removeByName("mininggadgets:upgrade_size_2");
craftingTable.addShaped("ctgui/new/mininggadgets/upgrade_size_2", <item:mininggadgets:upgrade_size_2>, [
    [<item:botania:mana_pearl>, <item:botania:manasteel_pickaxe>, <item:botania:mana_pearl>],
    [IIngredientEmpty.getInstance(), <item:mininggadgets:upgrade_size_1>, IIngredientEmpty.getInstance()],
    [<item:botania:mana_pearl>, <item:botania:mana_powder>, <item:botania:mana_pearl>]]);

<recipetype:minecraft:crafting>.removeByName("mininggadgets:upgrade_size_3");
craftingTable.addShaped("ctgui/new/mininggadgets/upgrade_size_3", <item:mininggadgets:upgrade_size_3>, [
    [<item:botania:pixie_dust>, <item:botania:elementium_pickaxe>, <item:botania:pixie_dust>],
    [IIngredientEmpty.getInstance(), <item:mininggadgets:upgrade_size_2>, IIngredientEmpty.getInstance()],
    [<item:botania:elementium_ingot>, <item:botania:pixie_dust>, <item:botania:elementium_ingot>]]);

<recipetype:minecraft:crafting>.removeByName("mininggadgets:upgrade_battery_1");
craftingTable.addShaped("ctgui/new/mininggadgets/upgrade_battery_1", <item:mininggadgets:upgrade_battery_1>, [
    [<item:minecraft:quartz>, <item:techreborn:red_cell_battery>, <item:minecraft:quartz>],
    [IIngredientEmpty.getInstance(), <item:mininggadgets:upgrade_empty>, IIngredientEmpty.getInstance()],
    [<item:minecraft:quartz>, IIngredientEmpty.getInstance(), <item:minecraft:quartz>]]);

<recipetype:minecraft:crafting>.removeByName("mininggadgets:upgrade_battery_2");
craftingTable.addShaped("ctgui/new/mininggadgets/upgrade_battery_2", <item:mininggadgets:upgrade_battery_2>, [
    [<item:minecraft:quartz>, <item:techreborn:lithium_ion_battery>, <item:minecraft:quartz>],
    [IIngredientEmpty.getInstance(), <item:mininggadgets:upgrade_battery_1>, IIngredientEmpty.getInstance()],
    [<item:minecraft:quartz>, IIngredientEmpty.getInstance(), <item:minecraft:quartz>]]);

<recipetype:minecraft:crafting>.removeByName("mininggadgets:upgrade_void_junk");
craftingTable.addShaped("ctgui/new/mininggadgets/upgrade_void_junk_0", <item:mininggadgets:upgrade_void_junk>, [
    [<tag:item:c:dusts/redstone>, IIngredientEmpty.getInstance(), <tag:item:c:dusts/redstone>],
    [<tag:item:c:ender_pearls>, <item:mininggadgets:upgrade_empty>, <tag:item:c:ender_pearls>],
    [<tag:item:c:dusts/redstone>, <item:tesseract:tesseract>, <tag:item:c:dusts/redstone>]]);

<recipetype:minecraft:crafting>.removeByName("mininggadgets:upgrade_battery_3");
craftingTable.addShaped("ctgui/new/mininggadgets/upgrade_battery_3_0", <item:mininggadgets:upgrade_battery_3>, [
    [IIngredientEmpty.getInstance(), <item:techreborn:lead_plate>, IIngredientEmpty.getInstance()],
    [<item:techreborn:lithium_ion_battery>, <item:mininggadgets:upgrade_battery_2>, <item:techreborn:lithium_ion_battery>],
    [<item:minecraft:quartz_block>, IIngredientEmpty.getInstance(), <item:minecraft:quartz_block>]]);

<recipetype:minecraft:crafting>.removeByName("mininggadgets:upgrade_light_placer");
craftingTable.addShaped("ctgui/new/mininggadgets/upgrade_light_placer", <item:mininggadgets:upgrade_light_placer>, [
    [IIngredientEmpty.getInstance(), <item:techreborn:lamp_led>, IIngredientEmpty.getInstance()],
    [<item:minecraft:glowstone>, <item:mininggadgets:upgrade_empty>, <item:minecraft:glowstone>],
    [<item:minecraft:glowstone_dust>, IIngredientEmpty.getInstance(), <item:minecraft:glowstone_dust>]]);

craftingTable.addShaped("ctgui/new/crafting/upgrade_battery_creative", <item:mininggadgets:upgrade_battery_creative>, [
    [IIngredientEmpty.getInstance(), <item:oritech:advanced_battery>, IIngredientEmpty.getInstance()],
    [<item:jsonreg:epoxy_resin_plate>, <item:mininggadgets:upgrade_battery_3>, <item:jsonreg:epoxy_resin_plate>],
    [IIngredientEmpty.getInstance(), <item:oritech:advanced_battery>, IIngredientEmpty.getInstance()]]);

<recipetype:minecraft:crafting>.removeByName("mininggadgets:mininggadget_fancy");
craftingTable.addShaped("ctgui/new/mininggadgets/mininggadget_fancy", <item:mininggadgets:mininggadget_fancy>, [
    [IIngredientEmpty.getInstance(), <item:techreborn:steel_plate>, <item:jsonreg:lv_robot_arm>],
    [<item:oritech:laser_arm_block>, <item:mininggadgets:upgrade_empty>, IIngredientEmpty.getInstance()],
    [IIngredientEmpty.getInstance(), <item:techreborn:steel_plate>, <item:jsonreg:lv_robot_arm>]]);

<recipetype:minecraft:crafting>.removeByName("mininggadgets:mininggadget");
craftingTable.addShaped("ctgui/new/mininggadgets/mininggadget", <item:mininggadgets:mininggadget>, [
    [IIngredientEmpty.getInstance(), <item:jsonreg:mv_robot_arm>, IIngredientEmpty.getInstance()],
    [<item:jsonreg:mv_emitter>, <item:mininggadgets:mininggadget_fancy>, <item:jsonreg:mv_sensor>],
    [<item:techreborn:titanium_plate>, IIngredientEmpty.getInstance(), <item:techreborn:titanium_plate>]]);

craftingTable.addShaped("ctgui/new/crafting/ore_crusher", <item:techreborn:ore_crusher>, [
    [IIngredientEmpty.getInstance(), <item:oritech:motor>, IIngredientEmpty.getInstance()],
    [<item:oritech:fluid_pipe>, <item:techreborn:basic_machine_frame>, <item:oritech:fluid_pipe>],
    [IIngredientEmpty.getInstance(), <item:jsonreg:steel_rod>, IIngredientEmpty.getInstance()]]);

craftingTable.addShaped("ctgui/new/crafting/large_ore_crusher", <item:techreborn:large_ore_crusher>, [
    [<item:techreborn:advanced_circuit>, <item:jsonreg:mv_robot_arm>, <item:techreborn:advanced_circuit>],
    [IIngredientEmpty.getInstance(), <item:techreborn:ore_crusher>, IIngredientEmpty.getInstance()],
    [<item:jsonreg:aluminum_rod>, <item:techreborn:advanced_machine_casing>, <item:jsonreg:aluminum_rod>]]);

craftingTable.addShaped("ctgui/new/crafting/large_grinder", <item:techreborn:large_grinder>, [
    [<item:techreborn:advanced_circuit>, <item:techreborn:advanced_machine_casing>, <item:techreborn:advanced_circuit>],
    [<item:jsonreg:aluminum_rod>, <item:techreborn:grinder>, <item:jsonreg:aluminum_rod>],
    [<item:jsonreg:mv_electric_motor>, <item:jsonreg:aluminum_rod>, <item:jsonreg:mv_electric_motor>]]);

craftingTable.addShaped("ctgui/new/crafting/urinary_catheter", <item:urinarycatheter:urinary_catheter>, [
    [<item:oritech:fluid_pipe>],
    [<item:botania:hydroangeas>],
    [<item:jsonreg:rubber_plate>]]);

craftingTable.addShaped("ctgui/new/crafting/infinite_pie", <item:infinite_pie:infinite_pie>, [
    [<item:minecraft:pumpkin_pie>, <item:farmersdelight:apple_pie>, <item:farmersdelight:sweet_berry_cheesecake>],
    [<item:farmersdelight:shepherds_pie_block>, <item:minecraft:cake>, <item:mysticsbiomes:cherry_pie>],
    [<item:techreborn:advanced_circuit>, <item:mysticsbiomes:peach_pie>, <item:techreborn:advanced_circuit>]]);

<recipetype:minecraft:crafting>.removeByName("botania:gaia_pylon");

craftingTable.addShaped("ctgui/new/crafting/large_centrifuge", <item:techreborn:large_centrifuge>, [
    [<item:techreborn:advanced_circuit>, <item:jsonreg:aluminum_rod>, <item:techreborn:advanced_circuit>],
    [<item:jsonreg:mv_electric_motor>, <item:techreborn:industrial_centrifuge>, <item:jsonreg:mv_electric_motor>],
    [<item:techreborn:aluminum_plate>, <item:jsonreg:mv_electric_motor>, <item:techreborn:aluminum_plate>]]);

craftingTable.addShaped("ctgui/new/crafting/large_extractor", <item:techreborn:large_extractor>, [
    [IIngredientEmpty.getInstance(), <item:jsonreg:mv_electric_motor>, IIngredientEmpty.getInstance()],
    [<item:techreborn:aluminum_plate>, <item:advanced_reborn:centrifugal_extractor>, <item:techreborn:aluminum_plate>],
    [IIngredientEmpty.getInstance(), <item:techreborn:advanced_machine_casing>, IIngredientEmpty.getInstance()]]);

<recipetype:minecraft:crafting>.removeByName("techreborn:crafting_table/machine/greenhouse_controller");
craftingTable.addShaped("ctgui/new/techreborn/crafting_table/machine/greenhouse_controller", <item:techreborn:greenhouse_controller>, [
    [<item:techreborn:refined_iron_ingot>, <item:techreborn:electronic_circuit>, <item:techreborn:refined_iron_ingot>],
    [<item:jsonreg:lv_robot_arm>, IIngredientEmpty.getInstance(), <item:jsonreg:lv_robot_arm>],
    [<item:techreborn:electronic_circuit>, <item:techreborn:basic_machine_frame>, <item:techreborn:electronic_circuit>]]);

craftingTable.addShaped("ctgui/new/crafting/large_greenhouse", <item:techreborn:large_greenhouse>, [
    [<item:techreborn:aluminum_plate>, <item:techreborn:advanced_machine_casing>, <item:techreborn:aluminum_plate>],
    [<item:jsonreg:mv_robot_arm>, <item:techreborn:greenhouse_controller>, <item:jsonreg:mv_robot_arm>],
    [<item:techreborn:advanced_circuit>, <item:techreborn:aluminum_plate>, <item:techreborn:advanced_circuit>]]);

craftingTable.addShaped("ctgui/new/crafting/large_ranch", <item:techreborn:large_ranch>, [
    [<item:oritech:processing_unit>, <item:easy_mob_farm:tier1_mob_farm_template>, <item:oritech:processing_unit>],
    [<item:jsonreg:mv_robot_arm>, <item:techreborn:advanced_circuit>, <item:jsonreg:mv_robot_arm>],
    [<item:techreborn:aluminum_plate>, <item:techreborn:advanced_machine_casing>, <item:techreborn:aluminum_plate>]]);

craftingTable.addShapeless("ctgui/new/crafting/rock_from_button", <item:earlystage:rock>, [<item:minecraft:stone_button>]);

craftingTable.addShaped("ctgui/new/techreborn/crafting_table/unit/tank/quantum_tank_unit_upgrade", <item:techreborn:crude_tank_unit>, [
    [IIngredientEmpty.getInstance(), <item:techreborn:cell>, IIngredientEmpty.getInstance()],
    [<item:techreborn:rubber>, <item:techreborn:crude_storage_unit>, <item:techreborn:rubber>],
    [IIngredientEmpty.getInstance(), <item:techreborn:cell>, IIngredientEmpty.getInstance()]]);

craftingTable.addShaped("ctgui/new/techreborn/crafting_table/unit/storage/crude_tank_unit", <item:techreborn:crude_tank_unit>, [
    [<tag:item:minecraft:planks>, <item:techreborn:iron_plate>, <tag:item:minecraft:planks>],
    [<tag:item:minecraft:planks>, <item:techreborn:cell>, <tag:item:minecraft:planks>],
    [<tag:item:minecraft:planks>, <item:techreborn:iron_plate>, <tag:item:minecraft:planks>]]);

<recipetype:minecraft:crafting>.removeByName("oritech:crafting/basicjetpack");
craftingTable.addShaped("ctgui/new/oritech/crafting/basicjetpack", <item:oritech:jetpack>, [
    [IIngredientEmpty.getInstance(), <item:jsonreg:lv_electric_piston>, IIngredientEmpty.getInstance()],
    [<item:techreborn:steel_plate>, <item:techreborn:steel_plate>, <item:techreborn:steel_plate>],
    [<item:techreborn:cell>, <item:techreborn:red_cell_battery>, <item:techreborn:cell>]]);

craftingTable.addShapeless("ctgui/new/paper_from_barks_earlystage", <item:minecraft:paper>, [<tag:item:earlystage:bark_items>, <tag:item:earlystage:bark_items>, <tag:item:earlystage:bark_items>]);

craftingTable.addShaped("ctgui/new/crafting/rotor", <item:jsonreg:rotor>, [
    [IIngredientEmpty.getInstance(), <item:techreborn:refined_iron_plate>, IIngredientEmpty.getInstance()],
    [<item:techreborn:refined_iron_plate>, <item:jsonreg:refined_iron_rod>, <item:techreborn:refined_iron_plate>],
    [IIngredientEmpty.getInstance(), <item:techreborn:refined_iron_plate>, IIngredientEmpty.getInstance()]]);

craftingTable.addShaped("ctgui/new/crafting/furnace_wo_flint", <item:minecraft:furnace> * 2, [
    [<item:minecraft:cobblestone>, <item:techreborn:iron_plate>, <item:minecraft:cobblestone>],
    [<item:minecraft:cobblestone>, <item:minecraft:cobblestone>, <item:minecraft:cobblestone>],
    [<item:minecraft:cobblestone>, <item:minecraft:coal>, <item:minecraft:cobblestone>]]);

<recipetype:minecraft:crafting>.removeByName("refinedstorage:processor_binding");
craftingTable.addShaped("ctgui/new/refinedstorage/processor_binding", <item:refinedstorage:processor_binding> * 8, [
    [<item:techreborn:copper_cable>, <item:oritech:fluxite>, <item:techreborn:copper_cable>]]);

craftingTable.addShaped("ctgui/new/crafting/neutron_collector_mv", <item:avaritia:neutron_collector> * 4, [
    [<item:jsonreg:holy_wooden_bucket>, IIngredientEmpty.getInstance(), <item:jsonreg:holy_wooden_bucket>],
    [<item:jsonreg:mv_electric_piston>, <item:techreborn:advanced_machine_casing>, <item:jsonreg:mv_electric_piston>],
    [IIngredientEmpty.getInstance(), <item:techreborn:aluminum_plate>, IIngredientEmpty.getInstance()]]);

<recipetype:minecraft:crafting>.removeByName("botania:elven_gateway_core");

<recipetype:minecraft:crafting>.removeByName("botania:gaia_ingot");

craftingTable.addShaped("ctgui/new/crafting/neko_aggregator", <item:toneko:neko_aggregator>, [
    [IIngredientEmpty.getInstance(), <item:jsonreg:mv_electric_piston>, IIngredientEmpty.getInstance()],
    [<item:toneko:neko_ingot>, <item:botania:life_aggregator>, <item:toneko:neko_ingot>],
    [<item:techreborn:aluminum_plate>, <item:advanced_reborn:singularity_compressor>, <item:techreborn:aluminum_plate>]]);

