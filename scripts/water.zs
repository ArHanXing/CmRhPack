// ============================================================
// 水处理：芯片切割用超纯水
// ============================================================
// 需求方：t2.zs 的 TR 工业锯床 —— 1× 硅晶棒 + 1B 纯净水 → 2× 硅晶圆
//
// 背景：homeostatic:purified_water 在本整合包原本**没有任何产出途径**。
//   Homeostatic 自带的产线是 create:mixing（1B 水 + 加热 → 1B 纯净水），
//   但 Create 未安装，该配方因 fabric:all_mods_loaded 条件不加载，
//   导致 T2 芯片线在晶圆切割这一步断裂。
//
// 两条路线（延续本包「OR 下位 / TR 上位」的既有分工）：
//   a 反渗透  OR 精炼厂   1B 水 → 1B 纯净水                    （无需多块结构，慢）
//   b 蒸馏    TR 蒸馏塔   5 水单元 → 1 盐水单元 + 4 纯净水单元   （快，副产盐水）
//
// ⚠ 本文件同时**修复**了原 oil.process.tr.water_distill 的 cell 丢失问题：
//   旧配方「5 水单元 → 1 盐水单元」静默吞掉 4 个 cell，不符合 TR 蒸馏塔
//   「进料 cell 数 = 出料 cell 数」的约定（见 TR 原版 distillation_tower/cell：
//   16 油 + 16 空单元 → 32 产物单元）。
//   现改为 **5 进 5 出**：5 水单元 → 1 盐水单元 + 4 纯净水单元。
//   盐水产出比例仍是 5 水 : 1 盐水，因此氢氧化钠与 T2a 浓缩物的成本不受影响。
//
// 注：不采用「水 → 蒸汽 → 冷凝」路线 —— oritech:steam_engine 烧 #c:steam 发电，
//     凭空造蒸汽会引入可携带燃料的发电漏洞。

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
<recipetype:techreborn:distillation_tower>.removeByName("oil.process.tr.water_distill");
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