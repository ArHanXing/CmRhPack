import crafttweaker.api.recipe.type.Recipe;

// =====================================================================
// 温室配方批量生成（scripts/tools/gen_greenhouse.py 产出，请勿手改）
// =====================================================================
// 共 168 条，power 32 / time 200，对齐 TR 原生 18 条形制。
// 规则：树苗→原木×2+树苗×1；自繁殖植物→自身×3；野生作物→产物×2；作物方块→收获物×3。
// 已排除：TR 原生 18 条覆盖项、Botania（后续走「种神秘花」中转）、机器/食物/装饰方块。
// =====================================================================

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.minecraft_acacia_sapling", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "minecraft:acacia_sapling"}],
    outputs: [
        {count: 2, id: "minecraft:acacia_log"},
        {count: 1, id: "minecraft:acacia_sapling"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.minecraft_cherry_sapling", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "minecraft:cherry_sapling"}],
    outputs: [
        {count: 2, id: "minecraft:cherry_log"},
        {count: 1, id: "minecraft:cherry_sapling"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.minecraft_dark_oak_sapling", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "minecraft:dark_oak_sapling"}],
    outputs: [
        {count: 2, id: "minecraft:dark_oak_log"},
        {count: 1, id: "minecraft:dark_oak_sapling"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.minecraft_jungle_sapling", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "minecraft:jungle_sapling"}],
    outputs: [
        {count: 2, id: "minecraft:jungle_log"},
        {count: 1, id: "minecraft:jungle_sapling"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.minecraft_spruce_sapling", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "minecraft:spruce_sapling"}],
    outputs: [
        {count: 2, id: "minecraft:spruce_log"},
        {count: 1, id: "minecraft:spruce_sapling"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.minecraft_mangrove_propagule", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "minecraft:mangrove_propagule"}],
    outputs: [
        {count: 2, id: "minecraft:mangrove_log"},
        {count: 1, id: "minecraft:mangrove_propagule"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_banyin_sapling", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:banyin_sapling"}],
    outputs: [
        {count: 2, id: "eternal_starlight:banyin_log"},
        {count: 1, id: "eternal_starlight:banyin_sapling"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_cradlewood_sapling", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:cradlewood_sapling"}],
    outputs: [
        {count: 2, id: "eternal_starlight:cradlewood_log"},
        {count: 1, id: "eternal_starlight:cradlewood_sapling"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_jinglestem_sapling", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:jinglestem_sapling"}],
    outputs: [
        {count: 2, id: "eternal_starlight:jinglestem_log"},
        {count: 1, id: "eternal_starlight:jinglestem_sapling"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_lunar_sapling", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:lunar_sapling"}],
    outputs: [
        {count: 2, id: "eternal_starlight:lunar_log"},
        {count: 1, id: "eternal_starlight:lunar_sapling"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_northland_sapling", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:northland_sapling"}],
    outputs: [
        {count: 2, id: "eternal_starlight:northland_log"},
        {count: 1, id: "eternal_starlight:northland_sapling"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_scarlet_sapling", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:scarlet_sapling"}],
    outputs: [
        {count: 2, id: "eternal_starlight:scarlet_log"},
        {count: 1, id: "eternal_starlight:scarlet_sapling"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_torreya_sapling", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:torreya_sapling"}],
    outputs: [
        {count: 2, id: "eternal_starlight:torreya_log"},
        {count: 1, id: "eternal_starlight:torreya_sapling"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.mysticsbiomes_lavender_blossom_sapling", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "mysticsbiomes:lavender_blossom_sapling"}],
    outputs: [
        {count: 2, id: "mysticsbiomes:lavender_log"},
        {count: 1, id: "mysticsbiomes:lavender_blossom_sapling"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.mysticsbiomes_maple_sapling", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "mysticsbiomes:maple_sapling"}],
    outputs: [
        {count: 2, id: "mysticsbiomes:maple_log"},
        {count: 1, id: "mysticsbiomes:maple_sapling"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.mysticsbiomes_orange_maple_sapling", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "mysticsbiomes:orange_maple_sapling"}],
    outputs: [
        {count: 2, id: "mysticsbiomes:maple_log"},
        {count: 1, id: "mysticsbiomes:orange_maple_sapling"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.mysticsbiomes_yellow_maple_sapling", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "mysticsbiomes:yellow_maple_sapling"}],
    outputs: [
        {count: 2, id: "mysticsbiomes:maple_log"},
        {count: 1, id: "mysticsbiomes:yellow_maple_sapling"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.mysticsbiomes_peach_sapling", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "mysticsbiomes:peach_sapling"}],
    outputs: [
        {count: 2, id: "mysticsbiomes:peach_log"},
        {count: 1, id: "mysticsbiomes:peach_sapling"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.mysticsbiomes_pink_cherry_blossom_sapling", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "mysticsbiomes:pink_cherry_blossom_sapling"}],
    outputs: [
        {count: 2, id: "mysticsbiomes:black_cherry_log"},
        {count: 1, id: "mysticsbiomes:pink_cherry_blossom_sapling"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.mysticsbiomes_white_cherry_blossom_sapling", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "mysticsbiomes:white_cherry_blossom_sapling"}],
    outputs: [
        {count: 2, id: "mysticsbiomes:black_cherry_log"},
        {count: 1, id: "mysticsbiomes:white_cherry_blossom_sapling"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.mysticsbiomes_strawberry_blossom_sapling", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "mysticsbiomes:strawberry_blossom_sapling"}],
    outputs: [
        {count: 2, id: "mysticsbiomes:strawberry_log"},
        {count: 1, id: "mysticsbiomes:strawberry_blossom_sapling"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.mysticsbiomes_tropical_sapling", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "mysticsbiomes:tropical_sapling"}],
    outputs: [
        {count: 2, id: "mysticsbiomes:tropical_log"},
        {count: 1, id: "mysticsbiomes:tropical_sapling"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.mysticsbiomes_vanilla_sapling", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "mysticsbiomes:vanilla_sapling"}],
    outputs: [
        {count: 2, id: "mysticsbiomes:vanilla_log"},
        {count: 1, id: "mysticsbiomes:vanilla_sapling"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.techreborn_rubber_sapling", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "techreborn:rubber_sapling"}],
    outputs: [
        {count: 2, id: "techreborn:rubber_log"},
        {count: 1, id: "techreborn:rubber_sapling"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.minecraft_allium", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "minecraft:allium"}],
    outputs: [
        {count: 3, id: "minecraft:allium"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.minecraft_azure_bluet", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "minecraft:azure_bluet"}],
    outputs: [
        {count: 3, id: "minecraft:azure_bluet"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.minecraft_blue_orchid", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "minecraft:blue_orchid"}],
    outputs: [
        {count: 3, id: "minecraft:blue_orchid"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.minecraft_cornflower", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "minecraft:cornflower"}],
    outputs: [
        {count: 3, id: "minecraft:cornflower"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.minecraft_dandelion", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "minecraft:dandelion"}],
    outputs: [
        {count: 3, id: "minecraft:dandelion"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.minecraft_lily_of_the_valley", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "minecraft:lily_of_the_valley"}],
    outputs: [
        {count: 3, id: "minecraft:lily_of_the_valley"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.minecraft_orange_tulip", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "minecraft:orange_tulip"}],
    outputs: [
        {count: 3, id: "minecraft:orange_tulip"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.minecraft_oxeye_daisy", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "minecraft:oxeye_daisy"}],
    outputs: [
        {count: 3, id: "minecraft:oxeye_daisy"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.minecraft_peony", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "minecraft:peony"}],
    outputs: [
        {count: 3, id: "minecraft:peony"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.minecraft_pink_tulip", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "minecraft:pink_tulip"}],
    outputs: [
        {count: 3, id: "minecraft:pink_tulip"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.minecraft_poppy", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "minecraft:poppy"}],
    outputs: [
        {count: 3, id: "minecraft:poppy"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.minecraft_red_tulip", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "minecraft:red_tulip"}],
    outputs: [
        {count: 3, id: "minecraft:red_tulip"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.minecraft_rose_bush", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "minecraft:rose_bush"}],
    outputs: [
        {count: 3, id: "minecraft:rose_bush"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.minecraft_sunflower", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "minecraft:sunflower"}],
    outputs: [
        {count: 3, id: "minecraft:sunflower"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.minecraft_white_tulip", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "minecraft:white_tulip"}],
    outputs: [
        {count: 3, id: "minecraft:white_tulip"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.minecraft_wither_rose", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "minecraft:wither_rose"}],
    outputs: [
        {count: 3, id: "minecraft:wither_rose"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.minecraft_torchflower", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "minecraft:torchflower"}],
    outputs: [
        {count: 3, id: "minecraft:torchflower"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.minecraft_lily_pad", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "minecraft:lily_pad"}],
    outputs: [
        {count: 3, id: "minecraft:lily_pad"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.minecraft_spore_blossom", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "minecraft:spore_blossom"}],
    outputs: [
        {count: 3, id: "minecraft:spore_blossom"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.minecraft_crimson_fungus", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "minecraft:crimson_fungus"}],
    outputs: [
        {count: 3, id: "minecraft:crimson_fungus"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.minecraft_warped_fungus", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "minecraft:warped_fungus"}],
    outputs: [
        {count: 3, id: "minecraft:warped_fungus"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.minecraft_seagrass", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "minecraft:seagrass"}],
    outputs: [
        {count: 3, id: "minecraft:seagrass"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.minecraft_twisting_vines", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "minecraft:twisting_vines"}],
    outputs: [
        {count: 3, id: "minecraft:twisting_vines"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.minecraft_weeping_vines", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "minecraft:weeping_vines"}],
    outputs: [
        {count: 3, id: "minecraft:weeping_vines"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.minecraft_big_dripleaf", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "minecraft:big_dripleaf"}],
    outputs: [
        {count: 3, id: "minecraft:big_dripleaf"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.minecraft_small_dripleaf", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "minecraft:small_dripleaf"}],
    outputs: [
        {count: 3, id: "minecraft:small_dripleaf"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.minecraft_nether_sprouts", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "minecraft:nether_sprouts"}],
    outputs: [
        {count: 3, id: "minecraft:nether_sprouts"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.minecraft_nether_wart", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "minecraft:nether_wart"}],
    outputs: [
        {count: 3, id: "minecraft:nether_wart"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.minecraft_moss_block", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "minecraft:moss_block"}],
    outputs: [
        {count: 3, id: "minecraft:moss_block"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.minecraft_azalea", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "minecraft:azalea"}],
    outputs: [
        {count: 3, id: "minecraft:azalea"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.minecraft_flowering_azalea", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "minecraft:flowering_azalea"}],
    outputs: [
        {count: 3, id: "minecraft:flowering_azalea"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.minecraft_fern", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "minecraft:fern"}],
    outputs: [
        {count: 3, id: "minecraft:fern"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.minecraft_large_fern", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "minecraft:large_fern"}],
    outputs: [
        {count: 3, id: "minecraft:large_fern"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.minecraft_short_grass", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "minecraft:short_grass"}],
    outputs: [
        {count: 3, id: "minecraft:short_grass"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.minecraft_tall_grass", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "minecraft:tall_grass"}],
    outputs: [
        {count: 3, id: "minecraft:tall_grass"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.minecraft_chorus_flower", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "minecraft:chorus_flower"}],
    outputs: [
        {count: 3, id: "minecraft:chorus_flower"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.minecraft_pitcher_plant", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "minecraft:pitcher_plant"}],
    outputs: [
        {count: 3, id: "minecraft:pitcher_plant"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.cinderscapes_bramble_berries", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "cinderscapes:bramble_berries"}],
    outputs: [
        {count: 3, id: "cinderscapes:bramble_berries"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.cinderscapes_photofern", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "cinderscapes:photofern"}],
    outputs: [
        {count: 3, id: "cinderscapes:photofern"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.cinderscapes_tall_photofern", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "cinderscapes:tall_photofern"}],
    outputs: [
        {count: 3, id: "cinderscapes:tall_photofern"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.cinderscapes_umbral_fungus", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "cinderscapes:umbral_fungus"}],
    outputs: [
        {count: 3, id: "cinderscapes:umbral_fungus"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.cinderscapes_scorched_sprouts", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "cinderscapes:scorched_sprouts"}],
    outputs: [
        {count: 3, id: "cinderscapes:scorched_sprouts"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.ends_delight_chorus_succulent", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "ends_delight:chorus_succulent"}],
    outputs: [
        {count: 3, id: "ends_delight:chorus_succulent"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.farmersdelight_wild_cabbages", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "farmersdelight:wild_cabbages"}],
    outputs: [
        {count: 2, id: "farmersdelight:cabbage"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.farmersdelight_wild_onions", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "farmersdelight:wild_onions"}],
    outputs: [
        {count: 2, id: "farmersdelight:onion"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.farmersdelight_wild_tomatoes", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "farmersdelight:wild_tomatoes"}],
    outputs: [
        {count: 2, id: "farmersdelight:tomato"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.farmersdelight_wild_rice", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "farmersdelight:wild_rice"}],
    outputs: [
        {count: 2, id: "farmersdelight:rice_panicle"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.farmersdelight_wild_carrots", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "farmersdelight:wild_carrots"}],
    outputs: [
        {count: 2, id: "minecraft:carrot"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.farmersdelight_wild_potatoes", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "farmersdelight:wild_potatoes"}],
    outputs: [
        {count: 2, id: "minecraft:potato"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.farmersdelight_wild_beetroots", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "farmersdelight:wild_beetroots"}],
    outputs: [
        {count: 2, id: "minecraft:beetroot"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.farmersdelight_brown_mushroom_colony", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "farmersdelight:brown_mushroom_colony"}],
    outputs: [
        {count: 2, id: "minecraft:brown_mushroom"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.farmersdelight_red_mushroom_colony", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "farmersdelight:red_mushroom_colony"}],
    outputs: [
        {count: 2, id: "minecraft:red_mushroom"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.farmersdelight_rice", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "farmersdelight:rice"}],
    outputs: [
        {count: 3, id: "farmersdelight:rice_panicle"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_amaramber_grass", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:amaramber_grass"}],
    outputs: [
        {count: 3, id: "eternal_starlight:amaramber_grass"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_amaramber_grass_bush", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:amaramber_grass_bush"}],
    outputs: [
        {count: 3, id: "eternal_starlight:amaramber_grass_bush"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_amethysia_grass", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:amethysia_grass"}],
    outputs: [
        {count: 3, id: "eternal_starlight:amethysia_grass"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_aureate_flower", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:aureate_flower"}],
    outputs: [
        {count: 3, id: "eternal_starlight:aureate_flower"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_blazebank_grass", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:blazebank_grass"}],
    outputs: [
        {count: 3, id: "eternal_starlight:blazebank_grass"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_blooming_shadegrieve", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:blooming_shadegrieve"}],
    outputs: [
        {count: 3, id: "eternal_starlight:blooming_shadegrieve"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_blue_crystalfleur_vine", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:blue_crystalfleur_vine"}],
    outputs: [
        {count: 3, id: "eternal_starlight:blue_crystalfleur_vine"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_cave_moss", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:cave_moss"}],
    outputs: [
        {count: 3, id: "eternal_starlight:cave_moss"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_conebloom", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:conebloom"}],
    outputs: [
        {count: 3, id: "eternal_starlight:conebloom"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_crescent_grass", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:crescent_grass"}],
    outputs: [
        {count: 3, id: "eternal_starlight:crescent_grass"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_crystallized_lunar_grass", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:crystallized_lunar_grass"}],
    outputs: [
        {count: 3, id: "eternal_starlight:crystallized_lunar_grass"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_crystallum_coral_fan", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:crystallum_coral_fan"}],
    outputs: [
        {count: 3, id: "eternal_starlight:crystallum_coral_fan"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_fantabud", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:fantabud"}],
    outputs: [
        {count: 3, id: "eternal_starlight:fantabud"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_fantafern", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:fantafern"}],
    outputs: [
        {count: 3, id: "eternal_starlight:fantafern"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_fantagrass", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:fantagrass"}],
    outputs: [
        {count: 3, id: "eternal_starlight:fantagrass"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_fire_orchid", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:fire_orchid"}],
    outputs: [
        {count: 3, id: "eternal_starlight:fire_orchid"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_glimmerfly_bush", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:glimmerfly_bush"}],
    outputs: [
        {count: 3, id: "eternal_starlight:glimmerfly_bush"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_glintgrass", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:glintgrass"}],
    outputs: [
        {count: 3, id: "eternal_starlight:glintgrass"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_gloreed", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:gloreed"}],
    outputs: [
        {count: 3, id: "eternal_starlight:gloreed"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_glowing_crescent_grass", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:glowing_crescent_grass"}],
    outputs: [
        {count: 3, id: "eternal_starlight:glowing_crescent_grass"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_glowing_lunar_bush", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:glowing_lunar_bush"}],
    outputs: [
        {count: 3, id: "eternal_starlight:glowing_lunar_bush"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_glowing_lunar_grass", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:glowing_lunar_grass"}],
    outputs: [
        {count: 3, id: "eternal_starlight:glowing_lunar_grass"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_glowing_mushroom", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:glowing_mushroom"}],
    outputs: [
        {count: 3, id: "eternal_starlight:glowing_mushroom"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_glowing_night_sprouts", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:glowing_night_sprouts"}],
    outputs: [
        {count: 3, id: "eternal_starlight:glowing_night_sprouts"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_glowing_parasol_grass", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:glowing_parasol_grass"}],
    outputs: [
        {count: 3, id: "eternal_starlight:glowing_parasol_grass"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_golden_coral_fan", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:golden_coral_fan"}],
    outputs: [
        {count: 3, id: "eternal_starlight:golden_coral_fan"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_golden_grass", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:golden_grass"}],
    outputs: [
        {count: 3, id: "eternal_starlight:golden_grass"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_green_fantabud", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:green_fantabud"}],
    outputs: [
        {count: 3, id: "eternal_starlight:green_fantabud"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_green_fantafern", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:green_fantafern"}],
    outputs: [
        {count: 3, id: "eternal_starlight:green_fantafern"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_green_fantagrass", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:green_fantagrass"}],
    outputs: [
        {count: 3, id: "eternal_starlight:green_fantagrass"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_hanging_fantagrass", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:hanging_fantagrass"}],
    outputs: [
        {count: 3, id: "eternal_starlight:hanging_fantagrass"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_lumenstem", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:lumenstem"}],
    outputs: [
        {count: 3, id: "eternal_starlight:lumenstem"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_lunar_bush", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:lunar_bush"}],
    outputs: [
        {count: 3, id: "eternal_starlight:lunar_bush"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_lunar_grass", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:lunar_grass"}],
    outputs: [
        {count: 3, id: "eternal_starlight:lunar_grass"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_lunar_reed", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:lunar_reed"}],
    outputs: [
        {count: 3, id: "eternal_starlight:lunar_reed"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_lunar_vine", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:lunar_vine"}],
    outputs: [
        {count: 3, id: "eternal_starlight:lunar_vine"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_lunaris_cactus", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:lunaris_cactus"}],
    outputs: [
        {count: 3, id: "eternal_starlight:lunaris_cactus"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_mauve_fern", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:mauve_fern"}],
    outputs: [
        {count: 3, id: "eternal_starlight:mauve_fern"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_moonlight_bush", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:moonlight_bush"}],
    outputs: [
        {count: 3, id: "eternal_starlight:moonlight_bush"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_moonlight_lily_pad", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:moonlight_lily_pad"}],
    outputs: [
        {count: 3, id: "eternal_starlight:moonlight_lily_pad"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_night_sprouts", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:night_sprouts"}],
    outputs: [
        {count: 3, id: "eternal_starlight:night_sprouts"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_nightfan_bush", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:nightfan_bush"}],
    outputs: [
        {count: 3, id: "eternal_starlight:nightfan_bush"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_orange_scarlet_bud", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:orange_scarlet_bud"}],
    outputs: [
        {count: 3, id: "eternal_starlight:orange_scarlet_bud"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_parasol_grass", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:parasol_grass"}],
    outputs: [
        {count: 3, id: "eternal_starlight:parasol_grass"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_pink_rose_bush", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:pink_rose_bush"}],
    outputs: [
        {count: 3, id: "eternal_starlight:pink_rose_bush"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_purple_scarlet_bud", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:purple_scarlet_bud"}],
    outputs: [
        {count: 3, id: "eternal_starlight:purple_scarlet_bud"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_red_crystalfleur_vine", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:red_crystalfleur_vine"}],
    outputs: [
        {count: 3, id: "eternal_starlight:red_crystalfleur_vine"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_red_scarlet_bud", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:red_scarlet_bud"}],
    outputs: [
        {count: 3, id: "eternal_starlight:red_scarlet_bud"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_red_velvetumoss", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:red_velvetumoss"}],
    outputs: [
        {count: 3, id: "eternal_starlight:red_velvetumoss"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_red_velvetumoss_flower", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:red_velvetumoss_flower"}],
    outputs: [
        {count: 3, id: "eternal_starlight:red_velvetumoss_flower"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_red_velvetumoss_villi", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:red_velvetumoss_villi"}],
    outputs: [
        {count: 3, id: "eternal_starlight:red_velvetumoss_villi"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_sacred_lanternvine", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:sacred_lanternvine"}],
    outputs: [
        {count: 3, id: "eternal_starlight:sacred_lanternvine"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_sacred_starlight_flower", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:sacred_starlight_flower"}],
    outputs: [
        {count: 3, id: "eternal_starlight:sacred_starlight_flower"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_scarlet_grass", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:scarlet_grass"}],
    outputs: [
        {count: 3, id: "eternal_starlight:scarlet_grass"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_shadegrieve", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:shadegrieve"}],
    outputs: [
        {count: 3, id: "eternal_starlight:shadegrieve"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_shining_mushroom", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:shining_mushroom"}],
    outputs: [
        {count: 3, id: "eternal_starlight:shining_mushroom"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_small_glowing_night_sprouts", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:small_glowing_night_sprouts"}],
    outputs: [
        {count: 3, id: "eternal_starlight:small_glowing_night_sprouts"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_small_night_sprouts", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:small_night_sprouts"}],
    outputs: [
        {count: 3, id: "eternal_starlight:small_night_sprouts"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_spiral_kelp", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:spiral_kelp"}],
    outputs: [
        {count: 3, id: "eternal_starlight:spiral_kelp"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_starlight_flower", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:starlight_flower"}],
    outputs: [
        {count: 3, id: "eternal_starlight:starlight_flower"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_starlight_seagrass", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:starlight_seagrass"}],
    outputs: [
        {count: 3, id: "eternal_starlight:starlight_seagrass"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_starlight_torchflower", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:starlight_torchflower"}],
    outputs: [
        {count: 3, id: "eternal_starlight:starlight_torchflower"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_starlit_lily_pad", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:starlit_lily_pad"}],
    outputs: [
        {count: 3, id: "eternal_starlight:starlit_lily_pad"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_stellafly_bush", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:stellafly_bush"}],
    outputs: [
        {count: 3, id: "eternal_starlight:stellafly_bush"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_sunset_thornbloom", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:sunset_thornbloom"}],
    outputs: [
        {count: 3, id: "eternal_starlight:sunset_thornbloom"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_tall_crescent_grass", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:tall_crescent_grass"}],
    outputs: [
        {count: 3, id: "eternal_starlight:tall_crescent_grass"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_tall_glowing_crescent_grass", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:tall_glowing_crescent_grass"}],
    outputs: [
        {count: 3, id: "eternal_starlight:tall_glowing_crescent_grass"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_tall_golden_grass", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:tall_golden_grass"}],
    outputs: [
        {count: 3, id: "eternal_starlight:tall_golden_grass"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_tentacles_coral_fan", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:tentacles_coral_fan"}],
    outputs: [
        {count: 3, id: "eternal_starlight:tentacles_coral_fan"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_torreya_vines", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:torreya_vines"}],
    outputs: [
        {count: 3, id: "eternal_starlight:torreya_vines"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_twilvewyrm_herb", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:twilvewyrm_herb"}],
    outputs: [
        {count: 3, id: "eternal_starlight:twilvewyrm_herb"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_velvetumoss", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:velvetumoss"}],
    outputs: [
        {count: 3, id: "eternal_starlight:velvetumoss"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_velvetumoss_villi", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:velvetumoss_villi"}],
    outputs: [
        {count: 3, id: "eternal_starlight:velvetumoss_villi"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_vividstalk", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:vividstalk"}],
    outputs: [
        {count: 3, id: "eternal_starlight:vividstalk"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_whisperbloom", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:whisperbloom"}],
    outputs: [
        {count: 3, id: "eternal_starlight:whisperbloom"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_wick_grass", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:wick_grass"}],
    outputs: [
        {count: 3, id: "eternal_starlight:wick_grass"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.eternal_starlight_withered_starlight_flower", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "eternal_starlight:withered_starlight_flower"}],
    outputs: [
        {count: 3, id: "eternal_starlight:withered_starlight_flower"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.mysticsbiomes_beach_grass", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "mysticsbiomes:beach_grass"}],
    outputs: [
        {count: 3, id: "mysticsbiomes:beach_grass"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.mysticsbiomes_desert_grass", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "mysticsbiomes:desert_grass"}],
    outputs: [
        {count: 3, id: "mysticsbiomes:desert_grass"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.mysticsbiomes_desert_lily", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "mysticsbiomes:desert_lily"}],
    outputs: [
        {count: 3, id: "mysticsbiomes:desert_lily"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.mysticsbiomes_hydrangea_bush", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "mysticsbiomes:hydrangea_bush"}],
    outputs: [
        {count: 3, id: "mysticsbiomes:hydrangea_bush"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.mysticsbiomes_lavender_blossoms", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "mysticsbiomes:lavender_blossoms"}],
    outputs: [
        {count: 3, id: "mysticsbiomes:lavender_blossoms"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.mysticsbiomes_peony_bush", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "mysticsbiomes:peony_bush"}],
    outputs: [
        {count: 3, id: "mysticsbiomes:peony_bush"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.mysticsbiomes_pink_cherry_blossoms", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "mysticsbiomes:pink_cherry_blossoms"}],
    outputs: [
        {count: 3, id: "mysticsbiomes:pink_cherry_blossoms"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.mysticsbiomes_saguaro_blossom", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "mysticsbiomes:saguaro_blossom"}],
    outputs: [
        {count: 3, id: "mysticsbiomes:saguaro_blossom"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.mysticsbiomes_saguaro_cactus", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "mysticsbiomes:saguaro_cactus"}],
    outputs: [
        {count: 3, id: "mysticsbiomes:saguaro_cactus"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.mysticsbiomes_strawberry_blossoms", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "mysticsbiomes:strawberry_blossoms"}],
    outputs: [
        {count: 3, id: "mysticsbiomes:strawberry_blossoms"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.mysticsbiomes_tall_beach_grass", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "mysticsbiomes:tall_beach_grass"}],
    outputs: [
        {count: 3, id: "mysticsbiomes:tall_beach_grass"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.mysticsbiomes_tall_desert_grass", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "mysticsbiomes:tall_desert_grass"}],
    outputs: [
        {count: 3, id: "mysticsbiomes:tall_desert_grass"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.mysticsbiomes_white_cherry_blossoms", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "mysticsbiomes:white_cherry_blossoms"}],
    outputs: [
        {count: 3, id: "mysticsbiomes:white_cherry_blossoms"}
    ]
});

<recipetype:techreborn:greenhouse>.addJsonRecipe("greenhouse.mysticsbiomes_wildflower", {type: "techreborn:greenhouse",
    power: 32,
    time: 200,
    ingredients: [{item: "mysticsbiomes:wildflower"}],
    outputs: [
        {count: 3, id: "mysticsbiomes:wildflower"}
    ]
});
