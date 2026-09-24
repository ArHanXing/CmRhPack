import crafttweaker.api.tag.MCTag;
import crafttweaker.api.recipe.type.Recipe;

//永恒星光的一些少量联动
//激活传送门
<recipetype:lychee:block_interacting>.addJsonRecipe("etst.lychee.active_voidstone",{
  "type": "lychee:block_interacting",
  "item_in": "botania:luminizer",
  "block_in": "jsonreg:inactive_voidstone",
  "post": [
    "place eternal_starlight:chiseled_voidstone"
  ]
});

//复合体
<recipetype:affinity:aspen_infusion>.removeByName("affinity:aspen_infusion/crystalline_wisp_matter_composite");
<recipetype:affinity:aspen_infusion>.addJsonRecipe("magic.affinity.aspen_infusion/crystalline_wisp_matter_composite", {type: "affinity:aspen_infusion",
    transfer_components: false,
    primary_input: {item: "affinity:scintillant_anthracite_blend"},
    output: {id: "affinity:crystalline_wisp_matter_composite", count: 1},
    duration: 400,
    inputs: [
        {item: "affinity:inert_wisp_matter"},
        {item: "botania:mana_powder"},
        {item: "affinity:vicious_wisp_matter"},
        {item: "botania:mana_powder"},
        {item: "affinity:wise_wisp_matter"},
        {item: "botania:mana_powder"}
    ],
    flux_cost_per_tick: 40
});
<recipetype:affinity:aspen_infusion>.addJsonRecipe("magic.affinity.aspen_infusion/crystalline_wisp_matter_composite/pixie_dust", {type: "affinity:aspen_infusion",
    transfer_components: false,
    primary_input: {item: "affinity:scintillant_anthracite_blend"},
    output: {id: "affinity:crystalline_wisp_matter_composite", count: 1},
    duration: 200,
    inputs: [
        {item: "affinity:inert_wisp_matter"},
        {item: "botania:pixie_dust"},
        {item: "affinity:vicious_wisp_matter"},
        {item: "botania:pixie_dust"},
        {item: "affinity:wise_wisp_matter"},
        {item: "botania:pixie_dust"}
    ],
    flux_cost_per_tick: 40
});
//融合主机新配方
<recipetype:affinity:aspen_infusion>.removeByName("affinity:aspen_infusion/spirit_integration_apparatus");
<recipetype:affinity:aspen_infusion>.addJsonRecipe("magic.affinity.aspen_infusion/spirit_integration_apparatus", {
    type: "affinity:aspen_infusion",
    transfer_components: false,
    primary_input: { item: "oritech:duratium_block" },
    output: { id: "affinity:spirit_integration_apparatus", count: 2 },
    duration: 120,
    inputs: [
        { item: "minecraft:red_nether_bricks" },
        { item: "affinity:vicious_wisp_matter" },
        { item: "botania:mana_pearl" },
        { item: "affinity:scintillant_anthracite_blend" },
        { item: "affinity:wise_wisp_matter" },
        { item: "affinity:scintillant_anthracite_blend" },
        { item: "botania:mana_pearl" },
        { item: "affinity:vicious_wisp_matter" }
    ],
    flux_cost_per_tick: 16
});
//生魂迷雾的填充配方
<recipetype:techreborn:solid_canning_machine>.addJsonRecipe("magic.tr.solid_canning_machine/mist.inert", {type: "techreborn:solid_canning_machine", 
    time: 20, outputs: [{id: "affinity:inert_wisp_mist"}], power: 1, 
    ingredients: [{item:"minecraft:glass_bottle"}, {item:"affinity:inert_wisp_matter"}]});
<recipetype:techreborn:solid_canning_machine>.addJsonRecipe("magic.tr.solid_canning_machine/mist.wise", {type: "techreborn:solid_canning_machine", 
    time: 20, outputs: [{id: "affinity:wise_wisp_mist"}], power: 1, 
    ingredients: [{item:"minecraft:glass_bottle"}, {item:"affinity:wise_wisp_matter"}]});
<recipetype:techreborn:solid_canning_machine>.addJsonRecipe("magic.tr.solid_canning_machine/mist.vicious", {type: "techreborn:solid_canning_machine", 
    time: 20, outputs: [{id: "affinity:vicious_wisp_mist"}], power: 1, 
    ingredients: [{item:"minecraft:glass_bottle"}, {item:"affinity:vicious_wisp_matter"}]});
//化反制作闪烁无烟煤混合物
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("magic.tr.chemical/scintillant_anthracite_blend", {type: "techreborn:chemical_reactor", time: 400, 
    outputs: [{id: "affinity:scintillant_anthracite_blend", count: 2}], power: 40, 
    ingredients: [{item: "minecraft:glowstone_dust"}, {item: "affinity:anthracite_powder", count:2}]});

//原石也可以转化活石
<recipetype:botania:pure_daisy>.removeByName("botania:pure_daisy/cobblestone");
<recipetype:botania:pure_daisy>.addJsonRecipe("magic.botania.pure_daisy/livingrock_alt", {
    type: "botania:pure_daisy",
    input: {block: "minecraft:cobblestone", type: "botania:block"},
    time: 170,
    output: {type: "botania:state", state: {Name: "botania:livingrock"}}
});
/*
//更贵的Affinitea
<recipetype:affinity:aspen_infusion>.removeByName("affinity:aspen_infusion/affinitea");
<recipetype:affinity:aspen_infusion>.addJsonRecipe("magic.affinity.aspen_infusion/affinitea", {type: "affinity:aspen_infusion", transfer_components: false, 
primary_input: {item: "affinity:clay_cup"}, output: {id: "affinity:affinitea", count: 1}, duration: 200, 
    inputs: [{item: "affinity:inert_wisp_matter"}, {item: "minecraft:sugar"}, {item: "minecraft:melon_slice"}, {item: "minecraft:glow_berries"}, 
    {item: "minecraft:melon_slice"}, {item: "minecraft:sugar"}], flux_cost_per_tick: 20});
*/
//泰拉凝聚板
<recipetype:affinity:spirit_assimilation>.addJsonRecipe("affinity.spirit_assimilation/terrestrial_agglomeration", {
  type: "affinity:spirit_assimilation",
  output: {id: "botania:terrestrial_agglomeration_plate", count: 1},
  socle_inputs: [
    {item: "botania:rune_of_fire"},
    {item: "botania:rune_of_air"},
    {item: "botania:rune_of_mana"},
    {item: "botania:rune_of_earth"},
    {item: "botania:rune_of_water"}
  ],
  transfer_components_index: -1,
  duration: 500,
  core_inputs: [
    {item: "minecraft:lapis_block"},
    {item: "affinity:crystalline_wisp_matter_composite"},
    {item: "botania:mana_quartz_block"},
    {item: "minecraft:lapis_block"}
  ],
  flux_cost_per_tick: 20,
  entity: {id: "minecraft:player"}
});

//BOT自然水晶
<recipetype:affinity:aspen_infusion>.addJsonRecipe("magic.affinity.aspen_infusion/natura_pylon", {type: "affinity:aspen_infusion", transfer_components: false, 
    primary_input: {item: "botania:mana_pylon"},
    output: {id: "botania:natura_pylon", count: 1}, duration: 100, 
    inputs: [
        {item: "affinity:crystalline_wisp_matter_composite"},
        {item: "botania:terrasteel_nugget"},
        {item: "botania:mana_pearl"},
        {item: "botania:terrasteel_nugget"},
        {item: "oritech:enderic_compound"},
        {item: "botania:terrasteel_nugget"},
    ], flux_cost_per_tick: 20}
);
//精灵优化泰拉钢
<recipetype:botania:terrestrial_agglomeration_plate>.addJsonRecipe("magic.botania.terrestrial_agglomeration_plate/better_terrasteel_ingot", {type: "botania:terrestrial_agglomeration_plate",
    result: {id: "botania:terrasteel_ingot", count: 1},
    mana: 250000,
    ingredients: [{tag: "c:ingots/elementium"}, {tag: "c:gems/dragonstone"}, {tag: "c:dusts/pixie"}]});

//盖亚水晶
<recipetype:lychee:item_inside>.addJsonRecipe("magic.botania.gaia_pylon", {
    type: "lychee:item_inside",
    item_in: [{"item": "botania:mana_pylon"},{"item":"botania:pixie_dust", "count": 2},{"item":"botania:elementium_ingot", "count": 2}],
    block_in: {"blocks": ["eternal_starlight:ether"]},
    time: 50,
    post: [
        {"type": "drop_item", "id": "botania:gaia_pylon", "count": 1}
    ]
});

//盖亚魂复制
<recipetype:botania:runic_altar>.addJsonRecipe("magic.botania.runic_altar/gaia_spirit_replication", {type: "botania:runic_altar",
    catalysts: [{item: "botania:gaia_spirit"}],
    ingredients: [{item: "affinity:inert_wisp_matter"}, {item: "affinity:wise_wisp_matter"}, {item: "affinity:vicious_wisp_matter"}],
    reagent: {item: "affinity:crystalline_wisp_matter_composite"},
    output: {id: "botania:gaia_spirit", count: 3},
    mana: 24000
});
//时间瓶
craftingTable.removeByName("tiab:time_in_a_bottle");
craftingTable.addShaped("magic.time_in_a_bottle", <item:tiab:time_in_a_bottle>, [
    [<tag:item:c:ingots/gold>, <item:affinity:infused_stone>, <tag:item:c:ingots/gold>], 
    [<item:techreborn:steel_plate>, <item:minecraft:clock>, <item:oritech:plastic_sheet>], 
    [<tag:item:c:gems/lapis>, <item:minecraft:glass_bottle>, <tag:item:c:gems/lapis>]]);

//试管速冷钨钢
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("etst.techreborn.tungstensteel_freeze", {type: "techreborn:chemical_reactor", time: 400, 
    outputs: [{id: "techreborn:tungstensteel_ingot", count: 2}], power: 30, 
    ingredients: [{item: "eternal_starlight:frozen_tube"}, {item: "techreborn:hot_tungstensteel_ingot", count:2}]});

//末地气瓶
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("magic.tr.chemical.end_air",{
  type:"techreborn:chemical_reactor",
  time:200,
  outputs:[
    {id: "techreborn:cell", count: 1},
    {id: "techreborn:cell", count: 1}
  ],
  power:16,
  ingredients:[
    {count: 1, components: {"techreborn:fluid": "jsonreg:end_air"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
    {count: 1, item:"minecraft:glass_bottle"}
  ]
});
//精灵门核心
<recipetype:affinity:aspen_infusion>.addJsonRecipe("magic.affinity.aspen_infusion/elven_gateway_core", {type: "affinity:aspen_infusion", transfer_components: false, 
    primary_input: {item: "botania:mana_pearl"},
    output: {id: "botania:elven_gateway_core", count: 1}, duration: 100, 
    inputs: [
        {tag: "botania:livingwood_logs"},
        {item: "botania:terrasteel_nugget"},
        {tag: "botania:livingwood_logs"},
        {item: "botania:terrasteel_nugget"},
        {tag: "botania:livingwood_logs"},
        {item: "botania:terrasteel_nugget"},
    ], flux_cost_per_tick: 40}
);

//泰拉钢外壳
<recipetype:techreborn:precise_assembler>.addJsonRecipe("magic.tr.assembly/terrasteel_casing", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "jsonreg:terrasteel_casing", count: 1}
    ],
    time: 300, power: 256,
    ingredients: [
        {count: 2, item:"botania:terrasteel_ingot"},
        {count: 1, item:"jsonreg:steel_frame"},
        {count: 2, item:"affinity:crystalline_wisp_matter_composite"}
    ]
});

//灵魂注入催化剂
<recipetype:techreborn:large_chemical_reactor>.addJsonRecipe("etst.tr.lcr/soul_injection", {type: "techreborn:large_chemical_reactor", 
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:soul_injection_catalyst"}},
        {id: "techreborn:cell", count: 7}
    ],
    time: 128, power: 256,
    ingredients: [
        {count: 8, components: {"techreborn:fluid": "eternal_starlight:ether"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 4, item:"affinity:crystalline_wisp_matter_composite"},
        {count: 4, item:"botania:pixie_dust"}
    ]
});

//合金炉
<recipetype:techreborn:precise_assembler>.addJsonRecipe("etst.tr.assembly/etst_alloy_furnace", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "eternal_starlight:alloy_furnace", count: 1},
        {id: "techreborn:cell", count: 2}
    ],
    time: 128, power: 256,
    ingredients: [
        {item: "jsonreg:terrasteel_casing", count: 16},
        {item: "jsonreg:steel_frame", count: 8},
        {item: "eternal_starlight:golem_steel_ingot", count: 4},
        {item: "jsonreg:mv_voltage_coil", count: 4},
        {item: "eternal_starlight:frozen_tube", count: 4},
        {item: "jsonreg:mv_robot_arm", count: 2},
        {count: 2, components: {"techreborn:fluid": "jsonreg:soul_injection_catalyst"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});
//盖亚魂锭
<recipetype:eternal_starlight:alloy>.addJsonRecipe("magic.etst.alloy/gaia_ingot", {type: "eternal_starlight:alloy",
    burn_time: 400,
    results: [
        {amount: 1, item: {id: "botania:gaia_ingot"}},
        {amount: {min_inclusive: 0, max_inclusive: 6, type: "minecraft:uniform"}, item: {id: "eternal_starlight:aethersent_nugget"}},
        {amount: {max_inclusive: 3, min_inclusive: 0, type: "minecraft:uniform"}, item: {id: "botania:gaia_spirit"}}
    ],ingredients: [
        {item: "botania:gaia_spirit"},
        {item: "botania:gaia_spirit"},
        {item: "botania:gaia_spirit"},
        {item: "botania:gaia_spirit"},
        {item: "botania:terrasteel_ingot"},
        {item: "affinity:crystalline_wisp_matter_composite"}
    ]});

//猫猫锭
<recipetype:toneko:neko_aggregator>.removeByName("toneko:neko_aggregator/resource/neko_ingot");
<recipetype:toneko:neko_aggregator>.removeByName("toneko:neko_aggregator/resource/neko_ingot_1");
<recipetype:eternal_starlight:alloy>.addJsonRecipe("magic.etst.alloy/neko_ingot", {
    burn_time: 400,
    results: [
        {amount: 1, item: {id: "toneko:neko_ingot"}},
        {amount: {min_inclusive: 0, max_inclusive: 3, type: "minecraft:uniform"}, item: {id: "eternal_starlight:dimslag"}},
        {amount: {max_inclusive: 3, min_inclusive: 0, type: "minecraft:uniform"}, item: {id: "toneko:neko_ingot"}}
    ],ingredients: [
        {item: "toneko:neko_potion"},
        {item: "affinity:crystalline_wisp_matter_composite"},
        {item: "eternal_starlight:deepsilver_ingot"},
        {item: "eternal_starlight:deepsilver_ingot"},
        {item: "eternal_starlight:deepsilver_ingot"}
    ]});

//猫猫万能工具
<recipetype:toneko:neko_aggregator>.removeByName("toneko:neko_aggregator/neko_multi_tool");
<recipetype:toneko:neko_aggregator>.addJsonRecipe("etst.toneko.neko_aggregator/neko_multi_tool", {type: "toneko:neko_aggregator",
    energy: 114.0, result: {id: "toneko:neko_multi_tool", count: 1},
    pattern: [
        " X ",
        " I ",
        "   "
    ], key: {I: {item: "toneko:neko_energy_storage_large"}, X: {item: "techreborn:omni_tool"}}
});

//超临界合成
<recipetype:lychee:block_interacting>.addJsonRecipe("magic.lychee.sps",{
  "type": "lychee:block_interacting",
  "item_in": "toneko:neko_ingot",
  "block_in": "toneko:neko_aggregator",
  "post": [
    "place techreborn:supercritical_polymerization_chamber"
  ]
});
//Affinity的一些魔改
// ====      mod的杜鹃灌注必须用数据包        ====
// ==== 可在 OpenLoader/LanguageAdd包 里查看 ====

//无烟煤粉
<recipetype:botania:mana_infusion>.addJsonRecipe("magic.bot.mana_infusion/ranthracite_dust", {type: "botania:mana_infusion",
    input: {item:"affinity:anthracite_powder"},
    output: {id:"affinity:ranthracite_dust",count:1},
    mana: 200
});

//BOT符文：七宗罪配方现在需要别的配料，导致它们只能通过杜鹃仪式消耗符文制作
<recipetype:botania:runic_altar>.removeByName("botania:runic_altar/rune_of_envy");
<recipetype:botania:runic_altar>.removeByName("botania:runic_altar/rune_of_gluttony");
<recipetype:botania:runic_altar>.removeByName("botania:runic_altar/rune_of_greed");
<recipetype:botania:runic_altar>.removeByName("botania:runic_altar/rune_of_lust");
<recipetype:botania:runic_altar>.removeByName("botania:runic_altar/rune_of_pride");
<recipetype:botania:runic_altar>.removeByName("botania:runic_altar/rune_of_sloth");
<recipetype:botania:runic_altar>.removeByName("botania:runic_altar/rune_of_wrath");
<recipetype:botania:runic_altar>.addJsonRecipe("magic.botania.runic_altar/rune_of_envy", {type: "botania:runic_altar", catalysts: [{item: "botania:rune_of_winter"}, {item: "botania:rune_of_water"}], reagent: {item: "botania:terrasteel_nugget"}, output: {id: "botania:rune_of_envy", count: 1}, mana: 12000, ingredients: [{tag: "c:gems/mana_diamond"}, {tag: "c:gems/mana_diamond"}, {tag: "c:gems/mana_quartz"}]});
<recipetype:botania:runic_altar>.addJsonRecipe("magic.botania.runic_altar/rune_of_gluttony", {type: "botania:runic_altar", catalysts: [{item: "botania:rune_of_winter"}, {item: "botania:rune_of_fire"}], reagent: {item: "botania:terrasteel_nugget"}, output: {id: "botania:rune_of_gluttony", count: 1}, mana: 12000, ingredients: [{tag: "c:gems/mana_diamond"}, {tag: "c:gems/mana_diamond"}, {tag: "c:gems/mana_quartz"}]});
<recipetype:botania:runic_altar>.addJsonRecipe("magic.botania.runic_altar/rune_of_greed", {type: "botania:runic_altar", catalysts: [{item: "botania:rune_of_spring"}, {item: "botania:rune_of_water"}], reagent: {item: "botania:terrasteel_nugget"}, output: {id: "botania:rune_of_greed", count: 1}, mana: 12000, ingredients: [{tag: "c:gems/mana_diamond"}, {tag: "c:gems/mana_diamond"}, {tag: "c:gems/mana_quartz"}]});
<recipetype:botania:runic_altar>.addJsonRecipe("magic.botania.runic_altar/rune_of_lust", {type: "botania:runic_altar", catalysts: [{item: "botania:rune_of_summer"}, {item: "botania:rune_of_air"}], reagent: {item: "botania:terrasteel_nugget"}, output: {id: "botania:rune_of_lust", count: 1}, mana: 12000, ingredients: [{tag: "c:gems/mana_diamond"}, {tag: "c:gems/mana_diamond"}, {tag: "c:gems/mana_quartz"}]});
<recipetype:botania:runic_altar>.addJsonRecipe("magic.botania.runic_altar/rune_of_pride", {type: "botania:runic_altar", catalysts: [{item: "botania:rune_of_summer"}, {item: "botania:rune_of_fire"}], reagent: {item: "botania:terrasteel_nugget"}, output: {id: "botania:rune_of_pride", count: 1}, mana: 12000, ingredients: [{tag: "c:gems/mana_diamond"}, {tag: "c:gems/mana_diamond"}, {tag: "c:gems/mana_quartz"}]});
<recipetype:botania:runic_altar>.addJsonRecipe("magic.botania.runic_altar/rune_of_sloth", {type: "botania:runic_altar", catalysts: [{item: "botania:rune_of_autumn"}, {item: "botania:rune_of_air"}], reagent: {item: "botania:terrasteel_nugget"}, output: {id: "botania:rune_of_sloth", count: 1}, mana: 12000, ingredients: [{tag: "c:gems/mana_diamond"}, {tag: "c:gems/mana_diamond"}, {tag: "c:gems/mana_quartz"}]});
<recipetype:botania:runic_altar>.addJsonRecipe("magic.botania.runic_altar/rune_of_wrath", {type: "botania:runic_altar", catalysts: [{item: "botania:rune_of_winter"}, {item: "botania:rune_of_earth"}], reagent: {item: "botania:terrasteel_nugget"}, output: {id: "botania:rune_of_wrath", count: 1}, mana: 12000, ingredients: [{tag: "c:gems/mana_diamond"}, {tag: "c:gems/mana_diamond"}, {tag: "c:gems/mana_quartz"}]});
//BOT符文：添加杜鹃仪式配方
<recipetype:affinity:aspen_infusion>.addJsonRecipe("magic.affinity.aspen_infusion/botrune.air", {
    type: "affinity:aspen_infusion",
    transfer_components: false,
    primary_input: { item: "botania:livingrock" },
    output: { id: "botania:rune_of_air", count: 2 },
    duration: 100,
    inputs: [
        { tag: "c:dusts/mana" },
        { tag: "c:ingots/manasteel" },
        { tag: "minecraft:wool_carpets" },
        { item: "minecraft:feather" },
        { item: "minecraft:string" }
    ],
    flux_cost_per_tick: 16
});

<recipetype:affinity:aspen_infusion>.addJsonRecipe("magic.affinity.aspen_infusion/botrune.autumn", {
    type: "affinity:aspen_infusion",
    transfer_components: false,
    primary_input: { item: "botania:livingrock" },
    output: { id: "botania:rune_of_autumn", count: 1 },
    duration: 100,
    inputs: [
        { item: "botania:rune_of_fire" },
        { item: "botania:rune_of_air" },
        { tag: "minecraft:leaves" },
        { tag: "minecraft:leaves" },
        { tag: "minecraft:leaves" },
        { item: "minecraft:spider_eye" }
    ],
    flux_cost_per_tick: 16
});

<recipetype:affinity:aspen_infusion>.addJsonRecipe("magic.affinity.aspen_infusion/botrune.earth", {
    type: "affinity:aspen_infusion",
    transfer_components: false,
    primary_input: { item: "botania:livingrock" },
    output: { id: "botania:rune_of_earth", count: 2 },
    duration: 100,
    inputs: [
        { tag: "c:dusts/mana" },
        { tag: "c:ingots/manasteel" },
        { item: "minecraft:stone" },
        { tag: "c:storage_blocks/coal" },
        { item: "minecraft:brown_mushroom" }  // 原 wrapped 取第一个
    ],
    flux_cost_per_tick: 16
});

<recipetype:affinity:aspen_infusion>.addJsonRecipe("magic.affinity.aspen_infusion/botrune.envy", {
    type: "affinity:aspen_infusion",
    transfer_components: false,
    primary_input: { item: "botania:livingrock" },
    output: { id: "botania:rune_of_envy", count: 1 },
    duration: 100,
    inputs: [
        { item: "botania:rune_of_winter" },
        { item: "botania:rune_of_water" },
        { tag: "c:gems/mana_diamond" },
        { tag: "c:gems/mana_diamond" }
    ],
    flux_cost_per_tick: 16
});

<recipetype:affinity:aspen_infusion>.addJsonRecipe("magic.affinity.aspen_infusion/botrune.fire", {
    type: "affinity:aspen_infusion",
    transfer_components: false,
    primary_input: { item: "botania:livingrock" },
    output: { id: "botania:rune_of_fire", count: 2 },
    duration: 100,
    inputs: [
        { tag: "c:dusts/mana" },
        { tag: "c:ingots/manasteel" },
        { tag: "c:bricks/nether" },
        { item: "minecraft:gunpowder" },
        { item: "minecraft:nether_wart" }
    ],
    flux_cost_per_tick: 16
});

<recipetype:affinity:aspen_infusion>.addJsonRecipe("magic.affinity.aspen_infusion/botrune.gluttony", {
    type: "affinity:aspen_infusion",
    transfer_components: false,
    primary_input: { item: "botania:livingrock" },
    output: { id: "botania:rune_of_gluttony", count: 1 },
    duration: 100,
    inputs: [
        { item: "botania:rune_of_winter" },
        { item: "botania:rune_of_fire" },
        { tag: "c:gems/mana_diamond" },
        { tag: "c:gems/mana_diamond" }
    ],
    flux_cost_per_tick: 16
});

<recipetype:affinity:aspen_infusion>.addJsonRecipe("magic.affinity.aspen_infusion/botrune.greed", {
    type: "affinity:aspen_infusion",
    transfer_components: false,
    primary_input: { item: "botania:livingrock" },
    output: { id: "botania:rune_of_greed", count: 1 },
    duration: 100,
    inputs: [
        { item: "botania:rune_of_spring" },
        { item: "botania:rune_of_water" },
        { tag: "c:gems/mana_diamond" },
        { tag: "c:gems/mana_diamond" }
    ],
    flux_cost_per_tick: 16
});

<recipetype:affinity:aspen_infusion>.addJsonRecipe("magic.affinity.aspen_infusion/botrune.lust", {
    type: "affinity:aspen_infusion",
    transfer_components: false,
    primary_input: { item: "botania:livingrock" },
    output: { id: "botania:rune_of_lust", count: 1 },
    duration: 100,
    inputs: [
        { item: "botania:rune_of_summer" },
        { item: "botania:rune_of_air" },
        { tag: "c:gems/mana_diamond" },
        { tag: "c:gems/mana_diamond" }
    ],
    flux_cost_per_tick: 16
});

<recipetype:affinity:aspen_infusion>.addJsonRecipe("magic.affinity.aspen_infusion/botrune.mana", {
    type: "affinity:aspen_infusion",
    transfer_components: false,
    primary_input: { item: "botania:livingrock" },
    output: { id: "botania:rune_of_mana", count: 1 },
    duration: 100,
    inputs: [
        { tag: "c:ingots/manasteel" },
        { tag: "c:ingots/manasteel" },
        { tag: "c:ingots/manasteel" },
        { tag: "c:ingots/manasteel" },
        { tag: "c:ingots/manasteel" },
        { tag: "c:gems/mana_pearl" }
    ],
    flux_cost_per_tick: 16
});

<recipetype:affinity:aspen_infusion>.addJsonRecipe("magic.affinity.aspen_infusion/botrune.pride", {
    type: "affinity:aspen_infusion",
    transfer_components: false,
    primary_input: { item: "botania:livingrock" },
    output: { id: "botania:rune_of_pride", count: 1 },
    duration: 100,
    inputs: [
        { item: "botania:rune_of_summer" },
        { item: "botania:rune_of_fire" },
        { tag: "c:gems/mana_diamond" },
        { tag: "c:gems/mana_diamond" }
    ],
    flux_cost_per_tick: 16
});

<recipetype:affinity:aspen_infusion>.addJsonRecipe("magic.affinity.aspen_infusion/botrune.sloth", {
    type: "affinity:aspen_infusion",
    transfer_components: false,
    primary_input: { item: "botania:livingrock" },
    output: { id: "botania:rune_of_sloth", count: 1 },
    duration: 100,
    inputs: [
        { item: "botania:rune_of_autumn" },
        { item: "botania:rune_of_air" },
        { tag: "c:gems/mana_diamond" },
        { tag: "c:gems/mana_diamond" }
    ],
    flux_cost_per_tick: 16
});

<recipetype:affinity:aspen_infusion>.addJsonRecipe("magic.affinity.aspen_infusion/botrune.spring", {
    type: "affinity:aspen_infusion",
    transfer_components: false,
    primary_input: { item: "botania:livingrock" },
    output: { id: "botania:rune_of_spring", count: 1 },
    duration: 100,
    inputs: [
        { item: "botania:rune_of_water" },
        { item: "botania:rune_of_fire" },
        { tag: "minecraft:saplings" },
        { tag: "minecraft:saplings" },
        { tag: "minecraft:saplings" },
        { item: "minecraft:wheat" }
    ],
    flux_cost_per_tick: 16
});

<recipetype:affinity:aspen_infusion>.addJsonRecipe("magic.affinity.aspen_infusion/botrune.summer", {
    type: "affinity:aspen_infusion",
    transfer_components: false,
    primary_input: { item: "botania:livingrock" },
    output: { id: "botania:rune_of_summer", count: 1 },
    duration: 100,
    inputs: [
        { item: "botania:rune_of_earth" },
        { item: "botania:rune_of_air" },
        { tag: "minecraft:sand" },
        { tag: "minecraft:sand" },
        { item: "minecraft:slime_ball" },
        { item: "minecraft:melon_slice" }
    ],
    flux_cost_per_tick: 16
});

<recipetype:affinity:aspen_infusion>.addJsonRecipe("magic.affinity.aspen_infusion/botrune.water", {
    type: "affinity:aspen_infusion",
    transfer_components: false,
    primary_input: { item: "botania:livingrock" },
    output: { id: "botania:rune_of_water", count: 2 },
    duration: 100,
    inputs: [
        { tag: "c:dusts/mana" },
        { tag: "c:ingots/manasteel" },
        { item: "minecraft:bone_meal" },
        { item: "minecraft:sugar_cane" },
        { tag: "c:tools/fishing_rod" }
    ],
    flux_cost_per_tick: 16
});

<recipetype:affinity:aspen_infusion>.addJsonRecipe("magic.affinity.aspen_infusion/botrune.winter", {
    type: "affinity:aspen_infusion",
    transfer_components: false,
    primary_input: { item: "botania:livingrock" },
    output: { id: "botania:rune_of_winter", count: 1 },
    duration: 100,
    inputs: [
        { item: "botania:rune_of_water" },
        { item: "botania:rune_of_earth" },
        { item: "minecraft:snow_block" },
        { item: "minecraft:snow_block" },
        { tag: "minecraft:wool" },
        { item: "minecraft:cake" }
    ],
    flux_cost_per_tick: 16
});

<recipetype:affinity:aspen_infusion>.addJsonRecipe("magic.affinity.aspen_infusion/botrune.wrath", {
    type: "affinity:aspen_infusion",
    transfer_components: false,
    primary_input: { item: "botania:livingrock" },
    output: { id: "botania:rune_of_wrath", count: 1 },
    duration: 100,
    inputs: [
        { item: "botania:rune_of_winter" },
        { item: "botania:rune_of_earth" },
        { tag: "c:gems/mana_diamond" },
        { tag: "c:gems/mana_diamond" }
    ],
    flux_cost_per_tick: 16
});

