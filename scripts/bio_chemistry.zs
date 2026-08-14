import crafttweaker.api.tag.MCTag;
import crafttweaker.api.recipe.type.Recipe;

// 生物化工线（T1）
// 我恶心死你们哈哈哈

// ========== A 线 发酵（Lychee 世界合成，55s = 1100tick）==========
// 4 生物质 泡水糖化发酵 -> 1 发酵液单元
<recipetype:lychee:item_inside>.addJsonRecipe("bio.vat.mash", {
    type: "lychee:item_inside",
    item_in: [{"item": "oritech:biomass", "count": 4},{"item":"techreborn:cell"}],
    block_in: {"blocks": ["minecraft:water"]},
    time: 200,
    post: [
        {"type": "drop_item", "id": "techreborn:cell", "count": 1, "components": {"techreborn:fluid": "jsonreg:fermented_mash"}}
    ]
});

// ========== A 线 蒸馏（OR 流体离心机：1 流体出 + 1 物品出）==========
// 发酵液 -> 乙醇（1:1，含水就当蒸掉了）
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("bio.sep.ethanol", {
    type: "oritech:centrifuge_fluid",
    results: [],
    fluidOutputs: [
        {fluid: "jsonreg:ethanol", amount: 81000}
    ],
    time: 200,
    fluidInput: {fluid: "jsonreg:fermented_mash", amount: 81000},
    ingredients: []
});

// ========== A 线 乙醇脱水 -> 乙烯（TR 化反，2 进 1 出）==========
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("bio.eth.ethylene", {
    type: "techreborn:chemical_reactor",
    time: 200,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:ethylene"}}
    ],
    power: 30,
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:ethanol"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 1, item:"oritech:small_copper_dust"}
    ]
});

// ========== B 线 发酵聚合（Lychee，110s = 2200tick）==========
// raw_biopolymer -> 塑料片；原离心机直通配方移除，必须过发酵池
<recipetype:lychee:item_inside>.addJsonRecipe("bio.vat.biopolymer", {
    type: "lychee:item_inside",
    item_in: {"item": "oritech:raw_biopolymer", "count": 1},
    block_in: {"blocks": ["minecraft:water"]},
    time: 400,
    post: [
        {"type": "drop_item", "id": "oritech:plastic_sheet", "count": 1}
    ]
});

//210s 生化A线
//405s 生化B线
//50s 原石化线