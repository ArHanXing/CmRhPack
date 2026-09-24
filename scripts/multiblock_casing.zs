import crafttweaker.api.tag.MCTag;
import crafttweaker.api.recipe.type.Recipe;

//TODO
<recipetype:techreborn:precise_assembler>.addJsonRecipe("mbcasing.stress_proof_casing", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "jsonreg:stress_proof_casing", count: 8}
    ],
    time: 200, power: 128,
    ingredients: [
        {count: 8, item:"techreborn:steel_plate"},
        {count: 2, item:"techreborn:advanced_machine_casing"},
        {count: 1, item:"techreborn:iridium_plate"}
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("mbcasing.vibration_safe_casing", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "jsonreg:vibration_safe_casing", count: 4}
    ],
    time: 200, power: 128,
    ingredients: [
        {count: 4, item:"techreborn:advanced_alloy_plate"},
        {count: 2, item:"jsonreg:titanium_frame"},
        {count: 1, item:"techreborn:advanced_machine_casing"}
    ]
});

<recipetype:techreborn:precise_assembler>.addJsonRecipe("mbcasing.reaction_safe_mixing_casing", {type: "techreborn:precise_assembler", 
    outputs: [
        {id: "jsonreg:reaction_safe_mixing_casing", count: 4}
    ],
    time: 200, power: 128,
    ingredients: [
        {count: 4, item:"jsonreg:tetrafluoroethylene_plate"},
        {count: 2, item:"jsonreg:vibration_safe_casing"},
        {count: 1, item:"jsonreg:aluminum_frame"}
    ]
});