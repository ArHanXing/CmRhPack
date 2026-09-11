import crafttweaker.api.tag.MCTag;
import crafttweaker.api.recipe.type.Recipe;

//TODO
<recipetype:techreborn:precise_assembler>.addJsonRecipe("mbcasing.high_power_casing", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "jsonreg:high_power_casing", count: 2},
        {id: "techreborn:cell", count: 2}
    ],
    time: 300, power: 128,
    ingredients: [
        {count: 2, item:"jsonreg:duratium_frame"},
        {count: 1, item:"jsonreg:duratium_frame"},
        {count: 1, components: {"techreborn:fluid": "techreborn:silicon"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 1, components: {"techreborn:fluid": "techreborn:carbon"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});