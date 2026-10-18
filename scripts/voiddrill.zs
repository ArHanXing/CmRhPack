//集气室的正义配方
<recipetype:techreborn:gas_collector>.removeAll();
<recipetype:techreborn:void_drill>.removeAll();
<recipetype:techreborn:gas_collector>.addJsonRecipe("drills.tr.gas_collector/overworld", {type: "techreborn:gas_collector",
    amount: 5000,
    fluid: "jsonreg:low_oxygen_nitrogen",
    time: 100,
    power: 256,
    dimension: "minecraft:overworld",
    display: {id: "minecraft:grass_block", count: 1}
});
<recipetype:techreborn:gas_collector>.addJsonRecipe("drills.tr.gas_collector/nether", {type: "techreborn:gas_collector",
    amount: 5000,
    fluid: "jsonreg:nether_air",
    time: 100,
    power: 128,
    dimension: "minecraft:the_nether",
    display: {id: "minecraft:netherrack", count: 1}
});
<recipetype:techreborn:gas_collector>.addJsonRecipe("drills.tr.gas_collector/starlight", {type: "techreborn:gas_collector",
    amount: 5000,
    fluid: "jsonreg:starlight_air",
    time: 100,
    power: 256,
    dimension: "eternal_starlight:starlight",
    display: {id: "eternal_starlight:lunar_leaves", count: 1}
});
<recipetype:techreborn:gas_collector>.addJsonRecipe("drills.tr.gas_collector/end", {type: "techreborn:gas_collector",
    amount: 5000,
    fluid: "jsonreg:end_air",
    time: 100,
    power: 384,
    dimension: "minecraft:the_end",
    display: {id: "minecraft:end_stone", count: 1}
});
/*
[21:44:31.541][INFO][CraftTweaker-Commands]: Recipe type: '<recipetype:techreborn:void_drill>'
  <recipetype:techreborn:void_drill>.addJsonRecipe("techreborn:void_drill/desert", {type: "techreborn:void_drill", amount: 10000, fluid: "techreborn:silicon", time: 100, power: 512, biome: "minecraft:desert", display: {id: "minecraft:sand", count: 1}});
  <recipetype:techreborn:void_drill>.addJsonRecipe("techreborn:void_drill/jungle", {type: "techreborn:void_drill", amount: 10000, fluid: "techreborn:biofuel", time: 100, power: 512, biome: "minecraft:jungle", display: {id: "minecraft:jungle_leaves", count: 1}});
  <recipetype:techreborn:void_drill>.addJsonRecipe("techreborn:void_drill/nether_wastes", {type: "techreborn:void_drill", amount: 10000, fluid: "techreborn:helium3", time: 100, power: 512, biome: "minecraft:nether_wastes", display: {id: "minecraft:netherrack", count: 1}});
  <recipetype:techreborn:void_drill>.addJsonRecipe("techreborn:void_drill/snowy_plains", {type: "techreborn:void_drill", amount: 10000, fluid: "techreborn:deuterium", time: 100, power: 512, biome: "minecraft:snowy_plains", display: {id: "minecraft:snow_block", count: 1}});
 */


function _drill(id as string, _fluid as string, _amount as int, _biome as string, showBlock as string) as void{
    <recipetype:techreborn:void_drill>.addJsonRecipe(id,{type: "techreborn:void_drill",
        amount: _amount*20,
        fluid: _fluid,
        time: 400,
        power: 128,
        biome: _biome,
        display: {id: showBlock, count: 1}
    });
}

//amount是每秒产出

_drill("drills.tr.void_drill/desert/oil", "techreborn:oil", 2000, "minecraft:desert", "minecraft:sand");
_drill("drills.tr.void_drill/badlands/oil", "techreborn:oil", 2000, "minecraft:badlands", "minecraft:red_sand");
_drill("drills.tr.void_drill/eroded_badlands/oil", "techreborn:oil", 2000, "minecraft:eroded_badlands", "minecraft:red_sand");
_drill("drills.tr.void_drill/wooded_badlands/oil", "techreborn:oil", 3000, "minecraft:wooded_badlands", "minecraft:red_sand");
_drill("drills.tr.void_drill/ocean/brine", "jsonreg:brine", 2000, "minecraft:ocean", "minecraft:water_bucket");
_drill("drills.tr.void_drill/deep_ocean/brine", "jsonreg:brine", 2000, "minecraft:deep_ocean", "minecraft:water_bucket");
_drill("drills.tr.void_drill/warm_ocean/brine", "jsonreg:brine", 2000, "minecraft:warm_ocean", "minecraft:brain_coral_block");
_drill("drills.tr.void_drill/lukewarm_ocean/brine", "jsonreg:brine", 2000, "minecraft:lukewarm_ocean", "minecraft:sand");
_drill("drills.tr.void_drill/deep_lukewarm_ocean/brine", "jsonreg:brine", 2000, "minecraft:deep_lukewarm_ocean", "minecraft:sand");
_drill("drills.tr.void_drill/cold_ocean/brine", "jsonreg:brine", 2000, "minecraft:cold_ocean", "minecraft:gravel");
_drill("drills.tr.void_drill/deep_cold_ocean/brine", "jsonreg:brine", 2000, "minecraft:deep_cold_ocean", "minecraft:gravel");
_drill("drills.tr.void_drill/frozen_ocean/brine", "jsonreg:brine", 2000, "minecraft:frozen_ocean", "minecraft:ice");
_drill("drills.tr.void_drill/deep_frozen_ocean/brine", "jsonreg:brine", 2000, "minecraft:deep_frozen_ocean", "minecraft:blue_ice");
_drill("drills.tr.void_drill/blackstone_shales/sulfuric", "oritech:still_sulfuric_acid", 500, "cinderscapes:blackstone_shales", "minecraft:blackstone");
_drill("drills.tr.void_drill/nether_wastes/sulfuric", "oritech:still_sulfuric_acid", 250, "minecraft:nether_wastes", "minecraft:netherrack");
_drill("drills.tr.void_drill/soul_sand_valley/sulfuric", "oritech:still_sulfuric_acid", 250, "minecraft:soul_sand_valley", "minecraft:soul_sand");
_drill("drills.tr.void_drill/ashy_shoals/sulfur", "techreborn:sulfur", 250, "cinderscapes:ashy_shoals", "cinderscapes:scorched_stem");
_drill("drills.tr.void_drill/ether_river/ether", "eternal_starlight:ether", 2000, "eternal_starlight:ether_river", "eternal_starlight:ether_bucket");
_drill("drills.tr.void_drill/shimmer_river/ether", "eternal_starlight:ether", 1000, "eternal_starlight:shimmer_river", "eternal_starlight:twilight_sand");
_drill("drills.tr.void_drill/solaris_isles/wisp_concentrate", "jsonreg:wisp_concentrate", 100, "eternal_starlight:solaris_isles", "eternal_starlight:golden_grass_block");
_drill("drills.tr.void_drill/the_end/nitric_acid", "jsonreg:nitric_acid", 500, "minecraft:the_end", "minecraft:end_stone");
_drill("drills.tr.void_drill/flesh_tundra/sheol_of_fire", "oritech:still_sheol_fire", 250, "stellarity:flesh_tundra", "minecraft:nether_wart_block");
_drill("drills.tr.void_drill/hallowed_tundra/wisp_raw_liquid", "jsonreg:wisp_raw_liquid", 1000, "stellarity:hallowed_tundra", "minecraft:light_blue_wool");
_drill("drills.tr.void_drill/the_hallowed/wisp_raw_liquid", "jsonreg:wisp_raw_liquid", 1000, "stellarity:the_hallow", "minecraft:light_blue_wool");