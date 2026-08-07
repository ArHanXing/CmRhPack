import crafttweaker.api.tag.MCTag;
import crafttweaker.api.ingredient.type.IIngredientEmpty;
import crafttweaker.api.ingredient.IIngredient;

//结构指南针
craftingTable.removeByName("explorerscompass:explorers_compass");
craftingTable.addShaped("misc.explorerscompass.explorers_compass", <item:explorerscompass:explorerscompass>, [
    [<item:minecraft:blaze_powder>, <item:minecraft:quartz>, <item:minecraft:blaze_powder>], 
    [<item:minecraft:quartz>, <item:minecraft:compass>, <item:minecraft:quartz>], 
    [<item:minecraft:blaze_powder>, <item:minecraft:glowstone_dust>, <item:minecraft:blaze_powder>]]);

//飞机部分
//大钢螺旋桨
craftingTable.removeByName("immersive_aircraft:propeller");
craftingTable.addShaped("misc.immersive_aircraft.propeller", <item:immersive_aircraft:propeller>, [
    [<item:techreborn:steel_ingot>, <item:techreborn:steel_ingot>, <item:minecraft:air>], 
    [<item:minecraft:air>, <item:oritech:motor>, <item:minecraft:air>], 
    [<item:minecraft:air>, <item:techreborn:steel_ingot>, <item:techreborn:steel_ingot>]]);
//发动机
craftingTable.removeByName("immersive_aircraft:engine");
  craftingTable.addShaped("misc.immersive_aircraft.engine", <item:immersive_aircraft:engine>, [
    [<item:minecraft:air>, <item:techreborn:iron_plate>, <item:minecraft:air>], 
    [<item:oritech:motor>, <item:techreborn:iron_furnace>, <item:oritech:motor>], 
    [<item:techreborn:iron_plate>, <item:immersive_aircraft:boiler>, <item:techreborn:iron_plate>]]);

//末影之眼
craftingTable.removeByName("minecraft:ender_eye");
<recipetype:techreborn:chemical_reactor>.removeByName("techreborn:chemical_reactor/ender_eye");
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("misc.techreborn.chemical_reactor/ender_eye", {type: "techreborn:chemical_reactor", time: 400, 
outputs: [{id: "minecraft:ender_eye", count: 6}], power: 50, ingredients: [{item: "oritech:overcharged_crystal"}, {item: "eternal_starlight:seeking_eye", count:4}]});

//移除便宜喷气背包哈哈哈
craftingTable.removeByName("oritech:crafting/basicjetpackalt");

//Easy Mob Farm的配方
craftingTable.remove(<item:easy_mob_farm:tier0_mob_farm_template>);
craftingTable.remove(<item:easy_mob_farm:tier1_mob_farm_template>);
craftingTable.remove(<item:easy_mob_farm:tier2_mob_farm_template>);
craftingTable.remove(<item:easy_mob_farm:tier3_mob_farm_template>);
craftingTable.addShaped("misc.easy_mob_farm.t0_mob_farm", <item:easy_mob_farm:tier0_mob_farm_template>, [
    [<item:minecraft:air>, <item:techreborn:refined_iron_ingot>, <item:minecraft:air>], 
    [<item:minecraft:copper_ingot>, <item:techreborn:iron_furnace>, <item:minecraft:copper_ingot>], 
    [<item:minecraft:glass>, <item:minecraft:hopper>, <item:minecraft:glass>]]);
craftingTable.addShaped("misc.easy_mob_farm.t1_mob_farm", <item:easy_mob_farm:tier1_mob_farm_template>, [
    [<item:minecraft:air>, <item:oritech:fluxite>, <item:minecraft:air>], 
    [<item:minecraft:gold_ingot>, <item:easy_mob_farm:tier0_mob_farm_template>, <item:minecraft:gold_ingot>], 
    [<item:minecraft:glass>, <item:techreborn:electronic_circuit>, <item:minecraft:glass>]]);
craftingTable.addShaped("misc.easy_mob_farm.t2_mob_farm", <item:easy_mob_farm:tier2_mob_farm_template>, [
    [<item:minecraft:air>, <item:oritech:dubios_container>, <item:minecraft:air>], 
    [<item:techreborn:aluminum_ingot>, <item:easy_mob_farm:tier1_mob_farm_template>, <item:techreborn:aluminum_ingot>], 
    [<item:minecraft:glass>, <item:techreborn:advanced_circuit>, <item:minecraft:glass>]]);
craftingTable.addShaped("misc.easy_mob_farm.t3_mob_farm", <item:easy_mob_farm:tier3_mob_farm_template>, [
    [<item:minecraft:air>, <item:techreborn:industrial_machine_frame>, <item:minecraft:air>], 
    [<item:techreborn:tungstensteel_ingot>, <item:easy_mob_farm:tier2_mob_farm_template>, <item:techreborn:tungstensteel_ingot>], 
    [<item:minecraft:glass>, <item:techreborn:industrial_circuit>, <item:minecraft:glass>]]);

//便宜单元
<recipetype:oritech:assembler>.addJsonRecipe("misc.oritech.assembler/cell", 
{type: "oritech:assembler", fluidOutput: {fluid: "minecraft:empty", amount: 0}, results: [{id: "techreborn:cell", count: 8}], 
time: 20, fluidInput: {fluid: "minecraft:empty", amount: 0}, 
ingredients: [{item: "techreborn:tin_ingot"}, {item: "techreborn:tin_ingot"}, {item: "techreborn:tin_ingot"}, {item: "techreborn:tin_ingot"}]});

//便携储罐有Bug
craftingTable.remove(<item:oritech:small_tank_block>);
craftingTable.remove(<item:techreborn:basic_storage_unit>);
craftingTable.remove(<item:techreborn:crude_unit_upgrader>);
//更加便宜的TR罐子
craftingTable.addShaped("misc.techreborn.crafting_table/unit/storage/basic_storage_unit", <item:techreborn:basic_storage_unit>, [
    [<tag:item:c:plates/refined_iron>, <tag:item:c:plates/refined_iron>, <tag:item:c:plates/refined_iron>], 
    [<item:techreborn:crude_storage_unit>, <item:techreborn:basic_machine_frame>, <item:techreborn:crude_storage_unit>], 
    [<item:techreborn:electronic_circuit>, <item:minecraft:paper>, <item:techreborn:electronic_circuit>]]);
craftingTable.addShaped("misc.techreborn.crafting_table/unit/upgrader/crude_unit_upgrader", <item:techreborn:crude_unit_upgrader>, [
    [<tag:item:c:plates/refined_iron>, <tag:item:c:plates/refined_iron>, <tag:item:c:plates/refined_iron>], 
    [<item:techreborn:crude_storage_unit>, <item:techreborn:basic_machine_frame>, <item:minecraft:air>], 
    [<item:techreborn:electronic_circuit>, <item:minecraft:paper>, <item:techreborn:electronic_circuit>]]);
//超立方体
craftingTable.remove(<item:tesseract:tesseract>);
<recipetype:oritech:assembler>.addJsonRecipe("misc.oritech.assembler/tesseract", 
    {type: "oritech:assembler", fluidOutput: {fluid: "minecraft:empty", amount: 0}, results: [{id: "tesseract:tesseract", count: 2}], 
    time: 100, fluidInput: {fluid: "minecraft:empty", amount: 0}, 
    ingredients: [
        {item: "minecraft:obsidian"}, {item:"minecraft:ender_pearl"}, 
        {item: "minecraft:ender_pearl"}, {item: "techreborn:diamond_plate"}]});

//由ctgui制作
//末影龙卡
craftingTable.addShaped("misc.ctgui.crafting.mob_capture_card_enderdragon", <item:easy_mob_farm:mob_capture_card>.withJsonComponent(<componenttype:easy_mob_farm:mob_capture_data>, {rarity: "epic", entityType: "minecraft:ender_dragon", type: "minecraft:ender_dragon", name: "entity.minecraft.ender_dragon"}), [
    [IIngredientEmpty.getInstance(), <item:easy_mob_farm:blank_mob_capture_card>, IIngredientEmpty.getInstance()],
    [IIngredientEmpty.getInstance(), <item:minecraft:dragon_egg>, IIngredientEmpty.getInstance()],
    [<item:minecraft:amethyst_shard>.withJsonComponent(<componenttype:minecraft:custom_model_data>, 90001).withJsonComponent(<componenttype:minecraft:custom_data>, {"stellarity.special_item": "enderite_shard"}).withJsonComponent(<componenttype:minecraft:rarity>, "uncommon").withJsonComponent(<componenttype:minecraft:item_name>, "{\"fallback\":\"Enderite Shard\",\"translate\":\"stellarity.items.materials.enderite_shard\",\"type\":\"translatable\"}").withJsonComponent(<componenttype:minecraft:lore>, ["\"\"", "{\"color\":\"#EEEEEE\",\"fallback\":\"Contains a fraction of the unknown\",\"italic\":false,\"translate\":\"stellarity.items.materials.enderite_shard.description\",\"type\":\"translatable\"}", "\"\"", "{\"color\":\"#CC26FF\",\"italic\":true,\"translate\":\"Stellarity\",\"type\":\"translatable\"}"]), <item:minecraft:dragon_breath>, <item:minecraft:amethyst_shard>.withJsonComponent(<componenttype:minecraft:custom_model_data>, 90001).withJsonComponent(<componenttype:minecraft:custom_data>, {"stellarity.special_item": "enderite_shard"}).withJsonComponent(<componenttype:minecraft:rarity>, "uncommon").withJsonComponent(<componenttype:minecraft:item_name>, "{\"fallback\":\"Enderite Shard\",\"translate\":\"stellarity.items.materials.enderite_shard\",\"type\":\"translatable\"}").withJsonComponent(<componenttype:minecraft:lore>, ["\"\"", "{\"color\":\"#EEEEEE\",\"fallback\":\"Contains a fraction of the unknown\",\"italic\":false,\"translate\":\"stellarity.items.materials.enderite_shard.description\",\"type\":\"translatable\"}", "\"\"", "{\"color\":\"#CC26FF\",\"italic\":true,\"translate\":\"Stellarity\",\"type\":\"translatable\"}"])]]);
//凋零卡
craftingTable.addShaped("misc.ctgui.crafting.mob_capture_card_wither", <item:easy_mob_farm:mob_capture_card>.withJsonComponent(<componenttype:easy_mob_farm:mob_capture_data>, {rarity: "epic", entityType: "minecraft:wither", type: "minecraft:wither", name: "entity.minecraft.wither"}), [
    [IIngredientEmpty.getInstance(), <item:easy_mob_farm:blank_mob_capture_card>, IIngredientEmpty.getInstance()],
    [<item:easy_mob_farm:no_flowers_filter>, <item:minecraft:nether_star>, <item:easy_mob_farm:no_flowers_filter>],
    [IIngredientEmpty.getInstance(), <item:transmog:void_fragment>, IIngredientEmpty.getInstance()]]);

//加厚中子反射 直接用单元
craftingTable.addShaped("misc.ctgui.crafting.trparts/thick_neutron_reflector_alt", <item:techreborn:thick_neutron_reflector>, [
    [IIngredientEmpty.getInstance(), <item:techreborn:neutron_reflector>, IIngredientEmpty.getInstance()],
    [<item:techreborn:neutron_reflector>, <item:techreborn:cell>.withJsonComponent(<componenttype:techreborn:fluid>, "techreborn:beryllium"), <item:techreborn:neutron_reflector>],
    [IIngredientEmpty.getInstance(), <item:techreborn:neutron_reflector>, IIngredientEmpty.getInstance()]]);

// ai
// 节点数据格式: [名称, 命名空间, 产出物品, 产出数量, 材料1, 材料2, 材料3, 材料4]
val vanillaNodes = [
    ["coal",     "oritech", "minecraft:coal",        8, "minecraft:coal_block",          "tesseract:tesseract", "oritech:advanced_computing_engine", "minecraft:coal_block"],
    ["copper",   "oritech", "minecraft:raw_copper",  4, "minecraft:copper_block",        "tesseract:tesseract", "oritech:advanced_computing_engine", "minecraft:copper_block"],
    ["diamond",  "oritech", "minecraft:diamond",     4, "minecraft:diamond_block",       "tesseract:tesseract", "oritech:advanced_computing_engine", "minecraft:diamond_block"],
    ["emerald",  "oritech", "minecraft:emerald",     6, "minecraft:emerald_block",       "tesseract:tesseract", "oritech:advanced_computing_engine", "minecraft:emerald_block"],
    ["gold",     "oritech", "minecraft:raw_gold",    4, "minecraft:gold_block",          "tesseract:tesseract", "oritech:advanced_computing_engine", "minecraft:gold_block"],
    ["iron",     "oritech", "minecraft:raw_iron",    4, "minecraft:iron_block",          "tesseract:tesseract", "oritech:advanced_computing_engine", "minecraft:iron_block"],
    ["lapis",    "oritech", "minecraft:lapis_lazuli",8, "minecraft:lapis_block",         "tesseract:tesseract", "oritech:advanced_computing_engine", "minecraft:lapis_block"],
    ["nickel",   "oritech", "oritech:raw_nickel",    4, "techreborn:nickel_storage_block","tesseract:tesseract", "oritech:advanced_computing_engine", "techreborn:nickel_storage_block"],
    ["platinum", "oritech", "oritech:raw_platinum",  4, "techreborn:platinum_storage_block","tesseract:tesseract","oritech:advanced_computing_engine","techreborn:platinum_storage_block"],
    ["redstone", "oritech", "minecraft:redstone",    8, "minecraft:redstone_block",      "tesseract:tesseract", "oritech:advanced_computing_engine", "minecraft:redstone_block"],
    ["uranium",  "oritech", "oritech:raw_uranium",   5, "oritech:deepslate_uranium_ore", "tesseract:tesseract", "oritech:advanced_computing_engine", "oritech:deepslate_uranium_ore"]
];

val customNodes = [
    ["tungsten", "jsonreg", "techreborn:raw_tungsten", 4, "techreborn:hot_tungstensteel_ingot", "tesseract:tesseract", "oritech:super_ai_chip", "techreborn:hot_tungstensteel_ingot"],
    ["iridium",  "jsonreg", "techreborn:raw_iridium",  3, "techreborn:iridium_alloy_plate",    "tesseract:tesseract", "oritech:super_ai_chip", "techreborn:tungstensteel_plate"],
    ["fossil",   "jsonreg", "minecraft:ancient_debris",3, "minecraft:ancient_debris",         "tesseract:tesseract", "oritech:advanced_computing_engine", "minecraft:ancient_debris"],
    ["lead","jsonreg","techreborn:raw_lead",4, "techreborn:lead_plate","tesseract:tesseract", "oritech:advanced_computing_engine", "techreborn:lead_plate",],
    ["bauxite","jsonreg","techreborn:bauxite_ore",4, "techreborn:magnalium_plate","tesseract:tesseract", "oritech:advanced_computing_engine", "techreborn:magnalium_plate"],
    ["neutron","jsonreg","avaritia:neutron_nugget",3,"avaritia:neutronium_block","tesseract:tesseract","oritech:super_ai_chip", "avaritia:neutronium_block"],
    ["gem","jsonreg","techreborn:ruby_dust",6,"techreborn:ruby_plate","tesseract:tesseract","oritech:advanced_computing_engine","techreborn:ruby_plate"],
    ["tin","jsonreg","techreborn:raw_tin",2,"techreborn:tin_plate","tesseract:tesseract","oritech:advanced_computing_engine","techreborn:tin_plate"],
    ["silver","jsonreg","techreborn:raw_silver",4,"techreborn:silver_plate","tesseract:tesseract","oritech:advanced_computing_engine","techreborn:silver_plate"],
    ["sphalerite","jsonreg","techreborn:sphalerite_dust",6,"techreborn:zinc_storage_block","tesseract:tesseract","oritech:advanced_computing_engine","techreborn:zinc_storage_block"],
    ["naquadah","jsonreg","jsonreg:naquadah_dust",3,"jsonreg:naquadah_plate","tesseract:tesseract","oritech:advanced_computing_engine","jsonreg:naquadah_plate"]
];

// 1. 深钻配方（先清空所有原配方）
<recipetype:oritech:deep_drill>.removeAll();

for node in vanillaNodes {
    val nodeName = node[0] as string;
    val nodeNamespace = node[1] as string;
    val outputItem = node[2] as string;
    val outputCount = node[3] as int;
    val nodeItem = nodeNamespace + ":resource_node_" + nodeName;
    <recipetype:oritech:deep_drill>.addJsonRecipe("misc.oritech.deepdrill/" + nodeName, {
        type: "oritech:deep_drill",
        fluidOutput: {fluid: "minecraft:empty", amount: 0},
        results: [{id: outputItem, count: outputCount}],
        time: 1,
        fluidInput: {fluid: "minecraft:empty", amount: 0},
        ingredients: [{item: nodeItem}]
    });
}

for node in customNodes {
    val nodeName = node[0] as string;
    val nodeNamespace = node[1] as string;
    val outputItem = node[2] as string;
    val outputCount = node[3] as int;
    val nodeItem = nodeNamespace + ":resource_node_" + nodeName;
    <recipetype:oritech:deep_drill>.addJsonRecipe("misc.oritech.deepdrill/" + nodeName, {
        type: "oritech:deep_drill",
        fluidOutput: {fluid: "minecraft:empty", amount: 0},
        results: [{id: outputItem, count: outputCount}],
        time: 1,
        fluidInput: {fluid: "minecraft:empty", amount: 0},
        ingredients: [{item: nodeItem}]
    });
}

// 2. 将自定义节点添加到资源节点标签
val tagResourceNodes = <tag:block:oritech:resource_nodes>;
for node in customNodes {
    val nodeName = node[0] as string;
    val nodeNamespace = node[1] as string;
    val blockRef = <block:${nodeNamespace}:resource_node_${nodeName}>;
    tagResourceNodes.add(blockRef);
}

// 3. 修改所有资源节点的硬度
for node in vanillaNodes {
    val nodeName = node[0] as string;
    val nodeNamespace = node[1] as string;
    val blockState = <blockstate:${nodeNamespace}:resource_node_${nodeName}>;
    blockState.destroySpeed = 10;
}
for node in customNodes {
    val nodeName = node[0] as string;
    val nodeNamespace = node[1] as string;
    val blockState = <blockstate:${nodeNamespace}:resource_node_${nodeName}>;
    blockState.destroySpeed = 10;
}

// 4. 装配器合成配方
for node in vanillaNodes {
    val nodeName = node[0] as string;
    val nodeNamespace = node[1] as string;
    val outputItem = nodeNamespace + ":resource_node_" + nodeName;
    val ing1 = node[4] as string;
    val ing2 = node[5] as string;
    val ing3 = node[6] as string;
    val ing4 = node[7] as string;
    <recipetype:oritech:assembler>.addJsonRecipe("misc.oritech.assembler/" + nodeName + "_node", {
        type: "oritech:assembler",
        fluidOutput: {fluid: "minecraft:empty", amount: 0},
        results: [{id: outputItem, count: 1}],
        time: 1200,
        fluidInput: {fluid: "minecraft:empty", amount: 0},
        ingredients: [{item: ing1}, {item: ing2}, {item: ing3}, {item: ing4}]
    });
}

for node in customNodes {
    val nodeName = node[0] as string;
    val nodeNamespace = node[1] as string;
    val outputItem = nodeNamespace + ":resource_node_" + nodeName;
    val ing1 = node[4] as string;
    val ing2 = node[5] as string;
    val ing3 = node[6] as string;
    val ing4 = node[7] as string;
    <recipetype:oritech:assembler>.addJsonRecipe("misc.oritech.assembler/" + nodeName + "_node", {
        type: "oritech:assembler",
        fluidOutput: {fluid: "minecraft:empty", amount: 0},
        results: [{id: outputItem, count: 1}],
        time: 1200,
        fluidInput: {fluid: "minecraft:empty", amount: 0},
        ingredients: [{item: ing1}, {item: ing2}, {item: ing3}, {item: ing4}]
    });
}

//虚空维度进入 //TODO
<recipetype:lychee:block_clicking>.addJsonRecipe("misc.enter_void_dimension",{
  "type": "lychee:block_clicking",
  "item_in": {},
  "block_in": "minecraft:obsidian",
  "post": [
    {
      "type": "if",
      "contextual": {
        "type": "location",
        "predicate": {
          "dimension": "d4r4_dimension:void_dimension"
        }
      },
      "then": [
        { "type": "execute", "command": "execute in minecraft:overworld run tp @p 0 100 0","hide": true},
        { "type": "execute", "command": "setblock 0 100 0 minecraft:obsidian","hide": true},
        { "type": "execute", "command": "setblock 0 102 0 minecraft:air","hide": true}
      ],
      "else": [
        { "type": "execute", "command": "execute in d4r4_dimension:void_dimension run tp @p 0 100 0","hide": true},
        { "type": "execute", "command": "setblock 0 100 0 minecraft:obsidian","hide": true},
        { "type": "execute", "command": "setblock 0 102 0 minecraft:air","hide": true}
      ]
    },
    {
      "type": "prevent_default"
    }
    
  ]
});

