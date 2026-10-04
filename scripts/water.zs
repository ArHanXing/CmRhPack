// ai generated

// 水处理：芯片切割用超纯水
// 需求方：t2.zs 的 TR 工业锯床 —— 1× 硅晶棒 + 1B 纯净水 → 2× 硅晶圆

// ---------- a 反渗透（OR 精炼厂，无多块结构，慢）----------
<recipetype:oritech:refinery>.addJsonRecipe("water.0a.or.reverse_osmosis", {type: "oritech:refinery",
    results: [],
    fluidOutputs: [
        {fluid: "homeostatic:purified_water", amount: 81000}
    ],
    time: 300,
    fluidInput: {fluid: "minecraft:water", amount: 81000},
    ingredients: []
});

// ---------- b 蒸馏（TR 蒸馏塔，快，副产盐水回流氯碱线）----------
<recipetype:techreborn:distillation_tower>.addJsonRecipe("water.0b.tr.distillation", {type: "techreborn:distillation_tower",
    time: 100,
    power: 32,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:brine"}},
        {id: "techreborn:cell", count: 4, components: {"techreborn:fluid": "homeostatic:purified_water"}}
    ],
    ingredients: [
        {count: 5, components: {"techreborn:fluid": "minecraft:water"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

//你以为有水线吗，想多了
