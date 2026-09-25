// 移除「农作物 → 甲烷」产线

<recipetype:techreborn:centrifuge>.removeByName("techreborn:centrifuge/brain_coral_block");
<recipetype:techreborn:centrifuge>.removeByName("techreborn:centrifuge/bubble_coral_block");
<recipetype:techreborn:centrifuge>.removeByName("techreborn:centrifuge/cell");
<recipetype:techreborn:centrifuge>.removeByName("techreborn:centrifuge/cell_2");
<recipetype:techreborn:centrifuge>.removeByName("techreborn:centrifuge/enchanted_golden_apple");
<recipetype:techreborn:centrifuge>.removeByName("techreborn:centrifuge/fire_coral_block");
<recipetype:techreborn:centrifuge>.removeByName("techreborn:centrifuge/glistering_melon_slice");
<recipetype:techreborn:centrifuge>.removeByName("techreborn:centrifuge/glow_berries");
<recipetype:techreborn:centrifuge>.removeByName("techreborn:centrifuge/golden_apple");
<recipetype:techreborn:centrifuge>.removeByName("techreborn:centrifuge/golden_carrot");
<recipetype:techreborn:centrifuge>.removeByName("techreborn:centrifuge/horn_coral_block");
<recipetype:techreborn:centrifuge>.removeByName("techreborn:centrifuge/methan_cell_from_apple");
<recipetype:techreborn:centrifuge>.removeByName("techreborn:centrifuge/methan_cell_from_baked_potato");
<recipetype:techreborn:centrifuge>.removeByName("techreborn:centrifuge/methan_cell_from_beetroot");
<recipetype:techreborn:centrifuge>.removeByName("techreborn:centrifuge/methan_cell_from_bread");
<recipetype:techreborn:centrifuge>.removeByName("techreborn:centrifuge/methan_cell_from_brown_mushroom");
<recipetype:techreborn:centrifuge>.removeByName("techreborn:centrifuge/methan_cell_from_brown_mushroom_block");
<recipetype:techreborn:centrifuge>.removeByName("techreborn:centrifuge/methan_cell_from_carrot");
<recipetype:techreborn:centrifuge>.removeByName("techreborn:centrifuge/methan_cell_from_cookie");
<recipetype:techreborn:centrifuge>.removeByName("techreborn:centrifuge/methan_cell_from_egg");
<recipetype:techreborn:centrifuge>.removeByName("techreborn:centrifuge/methan_cell_from_kelp");
<recipetype:techreborn:centrifuge>.removeByName("techreborn:centrifuge/methan_cell_from_melon_slice");
<recipetype:techreborn:centrifuge>.removeByName("techreborn:centrifuge/methan_cell_from_mushroom_stew");
<recipetype:techreborn:centrifuge>.removeByName("techreborn:centrifuge/methan_cell_from_nether_wart");
<recipetype:techreborn:centrifuge>.removeByName("techreborn:centrifuge/methan_cell_from_nether_wart_block");
<recipetype:techreborn:centrifuge>.removeByName("techreborn:centrifuge/methan_cell_from_potato");
<recipetype:techreborn:centrifuge>.removeByName("techreborn:centrifuge/methan_cell_from_pumpkin");
<recipetype:techreborn:centrifuge>.removeByName("techreborn:centrifuge/methan_cell_from_red_mushroom");
<recipetype:techreborn:centrifuge>.removeByName("techreborn:centrifuge/methan_cell_from_red_mushroom_block");
<recipetype:techreborn:centrifuge>.removeByName("techreborn:centrifuge/methan_cell_from_rotten_flesh");
<recipetype:techreborn:centrifuge>.removeByName("techreborn:centrifuge/methan_cell_from_spider_eye");
<recipetype:techreborn:centrifuge>.removeByName("techreborn:centrifuge/methan_cell_from_turtle_egg");
<recipetype:techreborn:centrifuge>.removeByName("techreborn:centrifuge/rubber_log");
<recipetype:techreborn:centrifuge>.removeByName("techreborn:centrifuge/shroomlight");
<recipetype:techreborn:centrifuge>.removeByName("techreborn:centrifuge/sweet_berries");
<recipetype:techreborn:centrifuge>.removeByName("techreborn:centrifuge/tube_coral_block");
<recipetype:techreborn:centrifuge>.removeByName("techreborn:centrifuge/warped_wart_block");


<recipetype:techreborn:centrifuge>.addJsonRecipe("fix.methane.brain_coral_block", {type: "techreborn:centrifuge", time: 500, outputs: [
        {id: "minecraft:dead_brain_coral", count: 24},
        {id: "minecraft:dead_brain_coral_fan", count: 12},
        {id: "minecraft:pink_dye", count: 16}
    ], power: 5, ingredients: [{item: "minecraft:brain_coral_block", count: 12}]});

<recipetype:techreborn:centrifuge>.addJsonRecipe("fix.methane.bubble_coral_block", {type: "techreborn:centrifuge", time: 500, outputs: [
        {id: "minecraft:dead_bubble_coral", count: 24},
        {id: "minecraft:dead_bubble_coral_fan", count: 12},
        {id: "minecraft:purple_dye", count: 16}
    ], power: 5, ingredients: [{item: "minecraft:bubble_coral_block", count: 12}]});

<recipetype:techreborn:centrifuge>.addJsonRecipe("fix.methane.enchanted_golden_apple", {type: "techreborn:centrifuge", time: 500, outputs: [
        {id: "minecraft:gold_ingot", count: 64}
    ], power: 5, ingredients: [{item: "minecraft:enchanted_golden_apple"}, {count: 2, components: {"techreborn:fluid": "minecraft:empty"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}]});

<recipetype:techreborn:centrifuge>.addJsonRecipe("fix.methane.fire_coral_block", {type: "techreborn:centrifuge", time: 500, outputs: [
        {id: "minecraft:dead_fire_coral", count: 24},
        {id: "minecraft:dead_fire_coral_fan", count: 12},
        {id: "minecraft:red_dye", count: 16}
    ], power: 5, ingredients: [{item: "minecraft:fire_coral_block", count: 12}]});

<recipetype:techreborn:centrifuge>.addJsonRecipe("fix.methane.glistering_melon_slice", {type: "techreborn:centrifuge", time: 500, outputs: [
        {id: "minecraft:gold_nugget", count: 6}
    ], power: 5, ingredients: [{item: "minecraft:glistering_melon_slice", count: 8}]});

<recipetype:techreborn:centrifuge>.addJsonRecipe("fix.methane.glow_berries", {type: "techreborn:centrifuge", time: 500, outputs: [
        {id: "minecraft:orange_dye", count: 2},
        {id: "minecraft:glowstone_dust", count: 2}
    ], power: 5, ingredients: [{item: "minecraft:glow_berries", count: 32}]});

<recipetype:techreborn:centrifuge>.addJsonRecipe("fix.methane.golden_apple", {type: "techreborn:centrifuge", time: 500, outputs: [
        {id: "minecraft:gold_ingot", count: 6}
    ], power: 10, ingredients: [{item: "minecraft:golden_apple"}]});

<recipetype:techreborn:centrifuge>.addJsonRecipe("fix.methane.golden_carrot", {type: "techreborn:centrifuge", time: 500, outputs: [
        {id: "minecraft:gold_nugget", count: 6}
    ], power: 5, ingredients: [{item: "minecraft:golden_carrot"}]});

<recipetype:techreborn:centrifuge>.addJsonRecipe("fix.methane.horn_coral_block", {type: "techreborn:centrifuge", time: 500, outputs: [
        {id: "minecraft:dead_horn_coral", count: 24},
        {id: "minecraft:dead_horn_coral_fan", count: 12},
        {id: "minecraft:yellow_dye", count: 16}
    ], power: 5, ingredients: [{item: "minecraft:horn_coral_block", count: 12}]});

<recipetype:techreborn:centrifuge>.addJsonRecipe("fix.methane.methan_cell_from_egg", {type: "techreborn:centrifuge", time: 500, outputs: [
        {id: "techreborn:calcite_dust", count: 1}
    ], power: 5, ingredients: [{item: "minecraft:egg", count: 16}]});

<recipetype:techreborn:centrifuge>.addJsonRecipe("fix.methane.methan_cell_from_turtle_egg", {type: "techreborn:centrifuge", time: 500, outputs: [
        {id: "techreborn:calcite_dust", count: 1}
    ], power: 5, ingredients: [{item: "minecraft:turtle_egg", count: 32}]});

<recipetype:techreborn:centrifuge>.addJsonRecipe("fix.methane.rubber_log", {type: "techreborn:centrifuge", time: 5000, outputs: [
        {id: "techreborn:sap", count: 8},
        {id: "techreborn:cell", count: 4, components: {"techreborn:fluid": "techreborn:carbon"}}
    ], power: 5, ingredients: [{item: "techreborn:rubber_log", count: 16}, {count: 5, components: {"techreborn:fluid": "minecraft:empty"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}]});

<recipetype:techreborn:centrifuge>.addJsonRecipe("fix.methane.shroomlight", {type: "techreborn:centrifuge", time: 500, outputs: [
        {id: "minecraft:glowstone_dust", count: 4}
    ], power: 5, ingredients: [{item: "minecraft:shroomlight", count: 8}]});

<recipetype:techreborn:centrifuge>.addJsonRecipe("fix.methane.sweet_berries", {type: "techreborn:centrifuge", time: 500, outputs: [
        {id: "minecraft:red_dye", count: 5}
    ], power: 5, ingredients: [{item: "minecraft:sweet_berries", count: 32}]});

<recipetype:techreborn:centrifuge>.addJsonRecipe("fix.methane.tube_coral_block", {type: "techreborn:centrifuge", time: 500, outputs: [
        {id: "minecraft:dead_tube_coral", count: 24},
        {id: "minecraft:dead_tube_coral_fan", count: 12},
        {id: "minecraft:blue_dye", count: 16}
    ], power: 5, ingredients: [{item: "minecraft:tube_coral_block", count: 12}]});

<recipetype:techreborn:centrifuge>.addJsonRecipe("fix.methane.warped_wart_block", {type: "techreborn:centrifuge", time: 500, outputs: [
        {id: "techreborn:ender_pearl_dust", count: 2}
    ], power: 5, ingredients: [{item: "minecraft:warped_wart_block", count: 12}]});
