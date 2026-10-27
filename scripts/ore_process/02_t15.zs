

// === T1.5：湿法处理与初级浓缩 ===

// ============================================================
// T1.5：湿法处理与初级浓缩
// ============================================================
// 每个矿石走五步，浓缩物必须有明确来源：
//   a 浸出      OR 精炼厂    粗矿 ×2 + 硫酸 → X盐溶液[主] + 矿物浆液[副]
//   b 选择性析出 OR 流体离心  X盐溶液(1桶) + 盐粉 ×1 → X碎块 ×1
//   c 重结晶    OR 流体离心  X碎块 ×1 + 水 → X石(gem) ×1 + 矿物浆液
//   d 石磨粉    TR 磨粉机    X石 ×1 → X高纯粉 ×3
//   e 副产回收  OR 精炼厂    矿物浆液 1B → 石膏粉 ×2（**共用步**，见本段末尾）
//
// ⚠ **试剂分工**：硫酸只出现在 a 步「酸浸」—— 那才是它化学上该在的位置。
//   c 步是重结晶，用**水**；T2a 是浮选浓缩，用**氢氧化钠溶液**。
//   若 c 与 T2a 都用硫酸，两条支路就只差产量，T2(5粉) 会完全支配 T1.5(3粉)，
//   gem 路线永远无人问津。拆开水/碱之后「低门槛低产 vs 高门槛高产」才成立。
//
// ⚠ **OR 离心机只支持大小为 1 的输入**（物品 count 与流体桶数都必须是 1，见 CrTNOTE）。
//   所以 b/c 的进料恒为 1 桶溶液 / 1 个碎块，倍率只能靠产出侧：d 步 1 石 → 3 粉是唯一倍增点。
//   （精炼厂不受此限：naquadah 线在用 count 10/4/2，故 a 步的 粗矿 ×2 安全。）
//
// 产出核账（以 1 个矿石计）：
//   1 矿 --T1--> 粗矿 ×2 --a--> 1 桶盐溶液 --b--> 碎块 ×1 --c--> 石 ×1 --d--> **粉 ×3**
//   ⇒ T1.5 终点为 **3 倍**矿物产出。
//
// 收录矿物：17 种金属（铜金铁镍铂铅银锡钨铱铀铝 / 方铅闪锌朱砂黄铁方钠）
//   + **氟石**（非金属，只走到 T1.5 为止，不进 T2/T2.3 —— 它的下游是 t2.zs 的
//     氟化学，而不是金属锭）。
//
// 槽位：精炼厂 1流体+1物品→2流体；流体离心 1流体+1物品→1流体+1物品；
//       TR 磨粉机 1 进 1 出（**只有 1 个输出槽，绝不能多输出**）。
// 精炼厂只用 2 个流体输出位：放弃第 3 位会让第 1 位增产，与「浸出率」设定方向一致，
// 且不虚构并不存在的回收液。
//
// 浓缩物（jsonreg:*_concentrate）留待 T2 —— 它是 dust 之上的进一步提纯产物，
// 不在 T1.5 出现。

// ---------- e 副产回收（共用步，不属于任一矿物）----------
/*
    矿物浆液回收石膏，哇哦，免费的硫酸根（还有花不完的钙）。
*/
// T1.5 的 a/c 两步都会副产 oritech:still_mineral_slurry（浸出 20250 + 重结晶 8100
// = 每次 0.35B）。在本条写出来之前它是**死输出** —— Oritech 原本消费浆液的
// `centrifuge/fluid/clumpacid/*` 配方已被本文件开头的清退段删掉，
// 而 T1.5 自己还在产（全库 36 处全是产出、零消费）。
//
// 化学上正好对口：酸浸时矿石里的钙会进入渣相生成石膏
//   CaCO₃ + H₂SO₄ → CaSO₄ + H₂O + CO₂
// 所以浆液可以回收成石膏粉，再走 t2.zs 的 t2.tr.blast_furnace/gypsum_calcination
// （CaSO₄ → CaO + SO₃）与既有的 oil.other.so3_to_h2so4 回到硫酸，
// 把 T1.5 的酸耗闭掉一部分。
//
// 回收率核算（以每次浸出计）：耗酸 1B、副产浆液 0.35B
//   0.35B 浆液 → 0.7 石膏粉 → 0.7 SO₃ → 0.7B 硫酸   ⇒ **回收约 70%**
// 即本配方为 1B 浆液 : 2 石膏粉（1 石膏 → 1 SO₃ → 1B 硫酸）。
//
// 配方形态照抄 Oritech 自带的 refinery/quartz.json：只有 results，不写 fluidOutputs。
<recipetype:oritech:refinery>.addJsonRecipe("general.t15e.byproduct.gypsum", {type: "oritech:refinery",
    results: [{id: "jsonreg:calcium_sulfate_dust", count: 2}],
    time: 160,
    fluidInput: {fluid: "oritech:still_mineral_slurry", amount: 81000},
    ingredients: []
});

// ---------- 铜 ----------
<recipetype:oritech:refinery>.addJsonRecipe("general.t15a.leach.copper", {type: "oritech:refinery",
    results: [],
    fluidOutputs: [
        {fluid: "jsonreg:copper_solution", amount: 81000},
        {fluid: "oritech:still_mineral_slurry", amount: 20250}
    ],
    time: 160,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 81000},
    ingredients: [{item: "minecraft:raw_copper", count: 2}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15b.precipitate.copper", {type: "oritech:centrifuge_fluid",
    results: [{id: "oritech:copper_clump", count: 1}],
    time: 150,
    fluidInput: {fluid: "jsonreg:copper_solution", amount: 81000},
    ingredients: [{item: "jsonreg:salt_dust", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15c.recrystallize.copper", {type: "oritech:centrifuge_fluid",
    results: [{id: "oritech:copper_gem", count: 1}],
    fluidOutputs: [{fluid: "oritech:still_mineral_slurry", amount: 8100}],
    time: 200,
    fluidInput: {fluid: "minecraft:water", amount: 40500},
    ingredients: [{item: "oritech:copper_clump", count: 1}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t15d.grind_gem.copper", {type: "techreborn:grinder",
    time: 200, power: 32,
    outputs: [{id: "oritech:copper_dust", count: 3}],
    ingredients: [{item: "oritech:copper_gem"}]
});

// ---------- 金 ----------
<recipetype:oritech:refinery>.addJsonRecipe("general.t15a.leach.gold", {type: "oritech:refinery",
    results: [],
    fluidOutputs: [
        {fluid: "jsonreg:gold_solution", amount: 81000},
        {fluid: "oritech:still_mineral_slurry", amount: 20250}
    ],
    time: 160,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 81000},
    ingredients: [{item: "minecraft:raw_gold", count: 2}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15b.precipitate.gold", {type: "oritech:centrifuge_fluid",
    results: [{id: "oritech:gold_clump", count: 1}],
    time: 150,
    fluidInput: {fluid: "jsonreg:gold_solution", amount: 81000},
    ingredients: [{item: "jsonreg:salt_dust", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15c.recrystallize.gold", {type: "oritech:centrifuge_fluid",
    results: [{id: "oritech:gold_gem", count: 1}],
    fluidOutputs: [{fluid: "oritech:still_mineral_slurry", amount: 8100}],
    time: 200,
    fluidInput: {fluid: "minecraft:water", amount: 40500},
    ingredients: [{item: "oritech:gold_clump", count: 1}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t15d.grind_gem.gold", {type: "techreborn:grinder",
    time: 200, power: 32,
    outputs: [{id: "oritech:gold_dust", count: 3}],
    ingredients: [{item: "oritech:gold_gem"}]
});

// ---------- 铁 ----------
<recipetype:oritech:refinery>.addJsonRecipe("general.t15a.leach.iron", {type: "oritech:refinery",
    results: [],
    fluidOutputs: [
        {fluid: "jsonreg:iron_solution", amount: 81000},
        {fluid: "oritech:still_mineral_slurry", amount: 20250}
    ],
    time: 160,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 81000},
    ingredients: [{item: "minecraft:raw_iron", count: 2}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15b.precipitate.iron", {type: "oritech:centrifuge_fluid",
    results: [{id: "oritech:iron_clump", count: 1}],
    time: 150,
    fluidInput: {fluid: "jsonreg:iron_solution", amount: 81000},
    ingredients: [{item: "jsonreg:salt_dust", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15c.recrystallize.iron", {type: "oritech:centrifuge_fluid",
    results: [{id: "oritech:iron_gem", count: 1}],
    fluidOutputs: [{fluid: "oritech:still_mineral_slurry", amount: 8100}],
    time: 200,
    fluidInput: {fluid: "minecraft:water", amount: 40500},
    ingredients: [{item: "oritech:iron_clump", count: 1}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t15d.grind_gem.iron", {type: "techreborn:grinder",
    time: 200, power: 32,
    outputs: [{id: "oritech:iron_dust", count: 3}],
    ingredients: [{item: "oritech:iron_gem"}]
});

// ---------- 镍 ----------
<recipetype:oritech:refinery>.addJsonRecipe("general.t15a.leach.nickel", {type: "oritech:refinery",
    results: [],
    fluidOutputs: [
        {fluid: "jsonreg:nickel_solution", amount: 81000},
        {fluid: "oritech:still_mineral_slurry", amount: 20250}
    ],
    time: 160,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 81000},
    ingredients: [{item: "oritech:raw_nickel", count: 2}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15b.precipitate.nickel", {type: "oritech:centrifuge_fluid",
    results: [{id: "oritech:nickel_clump", count: 1}],
    time: 150,
    fluidInput: {fluid: "jsonreg:nickel_solution", amount: 81000},
    ingredients: [{item: "jsonreg:salt_dust", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15c.recrystallize.nickel", {type: "oritech:centrifuge_fluid",
    results: [{id: "oritech:nickel_gem", count: 1}],
    fluidOutputs: [{fluid: "oritech:still_mineral_slurry", amount: 8100}],
    time: 200,
    fluidInput: {fluid: "minecraft:water", amount: 40500},
    ingredients: [{item: "oritech:nickel_clump", count: 1}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t15d.grind_gem.nickel", {type: "techreborn:grinder",
    time: 200, power: 32,
    outputs: [{id: "techreborn:nickel_dust", count: 3}],
    ingredients: [{item: "oritech:nickel_gem"}]
});

// ---------- 铂 ----------
<recipetype:oritech:refinery>.addJsonRecipe("general.t15a.leach.platinum", {type: "oritech:refinery",
    results: [],
    fluidOutputs: [
        {fluid: "jsonreg:platinum_solution", amount: 81000},
        {fluid: "oritech:still_mineral_slurry", amount: 20250}
    ],
    time: 160,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 81000},
    ingredients: [{item: "oritech:raw_platinum", count: 2}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15b.precipitate.platinum", {type: "oritech:centrifuge_fluid",
    results: [{id: "oritech:platinum_clump", count: 1}],
    time: 150,
    fluidInput: {fluid: "jsonreg:platinum_solution", amount: 81000},
    ingredients: [{item: "jsonreg:salt_dust", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15c.recrystallize.platinum", {type: "oritech:centrifuge_fluid",
    results: [{id: "oritech:platinum_gem", count: 1}],
    fluidOutputs: [{fluid: "oritech:still_mineral_slurry", amount: 8100}],
    time: 200,
    fluidInput: {fluid: "minecraft:water", amount: 40500},
    ingredients: [{item: "oritech:platinum_clump", count: 1}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t15d.grind_gem.platinum", {type: "techreborn:grinder",
    time: 200, power: 32,
    outputs: [{id: "techreborn:platinum_dust", count: 3}],
    ingredients: [{item: "oritech:platinum_gem"}]
});

// ---------- 铅 ----------
<recipetype:oritech:refinery>.addJsonRecipe("general.t15a.leach.lead", {type: "oritech:refinery",
    results: [],
    fluidOutputs: [
        {fluid: "jsonreg:lead_solution", amount: 81000},
        {fluid: "oritech:still_mineral_slurry", amount: 20250}
    ],
    time: 160,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 81000},
    ingredients: [{item: "techreborn:raw_lead", count: 2}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15b.precipitate.lead", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:lead_clump", count: 1}],
    time: 150,
    fluidInput: {fluid: "jsonreg:lead_solution", amount: 81000},
    ingredients: [{item: "jsonreg:salt_dust", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15c.recrystallize.lead", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:lead_gem", count: 1}],
    fluidOutputs: [{fluid: "oritech:still_mineral_slurry", amount: 8100}],
    time: 200,
    fluidInput: {fluid: "minecraft:water", amount: 40500},
    ingredients: [{item: "jsonreg:lead_clump", count: 1}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t15d.grind_gem.lead", {type: "techreborn:grinder",
    time: 200, power: 32,
    outputs: [{id: "jsonreg:lead_dust", count: 3}],
    ingredients: [{item: "jsonreg:lead_gem"}]
});

// ---------- 银 ----------
<recipetype:oritech:refinery>.addJsonRecipe("general.t15a.leach.silver", {type: "oritech:refinery",
    results: [],
    fluidOutputs: [
        {fluid: "jsonreg:silver_solution", amount: 81000},
        {fluid: "oritech:still_mineral_slurry", amount: 20250}
    ],
    time: 160,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 81000},
    ingredients: [{item: "techreborn:raw_silver", count: 2}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15b.precipitate.silver", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:silver_clump", count: 1}],
    time: 150,
    fluidInput: {fluid: "jsonreg:silver_solution", amount: 81000},
    ingredients: [{item: "jsonreg:salt_dust", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15c.recrystallize.silver", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:silver_gem", count: 1}],
    fluidOutputs: [{fluid: "oritech:still_mineral_slurry", amount: 8100}],
    time: 200,
    fluidInput: {fluid: "minecraft:water", amount: 40500},
    ingredients: [{item: "jsonreg:silver_clump", count: 1}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t15d.grind_gem.silver", {type: "techreborn:grinder",
    time: 200, power: 32,
    outputs: [{id: "jsonreg:silver_dust", count: 3}],
    ingredients: [{item: "jsonreg:silver_gem"}]
});

// ---------- 锡 ----------
<recipetype:oritech:refinery>.addJsonRecipe("general.t15a.leach.tin", {type: "oritech:refinery",
    results: [],
    fluidOutputs: [
        {fluid: "jsonreg:tin_solution", amount: 81000},
        {fluid: "oritech:still_mineral_slurry", amount: 20250}
    ],
    time: 160,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 81000},
    ingredients: [{item: "techreborn:raw_tin", count: 2}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15b.precipitate.tin", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:tin_clump", count: 1}],
    time: 150,
    fluidInput: {fluid: "jsonreg:tin_solution", amount: 81000},
    ingredients: [{item: "jsonreg:salt_dust", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15c.recrystallize.tin", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:tin_gem", count: 1}],
    fluidOutputs: [{fluid: "oritech:still_mineral_slurry", amount: 8100}],
    time: 200,
    fluidInput: {fluid: "minecraft:water", amount: 40500},
    ingredients: [{item: "jsonreg:tin_clump", count: 1}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t15d.grind_gem.tin", {type: "techreborn:grinder",
    time: 200, power: 32,
    outputs: [{id: "jsonreg:tin_dust", count: 3}],
    ingredients: [{item: "jsonreg:tin_gem"}]
});

// ---------- 钨 ----------
<recipetype:oritech:refinery>.addJsonRecipe("general.t15a.leach.tungsten", {type: "oritech:refinery",
    results: [],
    fluidOutputs: [
        {fluid: "jsonreg:tungsten_solution", amount: 81000},
        {fluid: "oritech:still_mineral_slurry", amount: 20250}
    ],
    time: 160,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 81000},
    ingredients: [{item: "techreborn:raw_tungsten", count: 2}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15b.precipitate.tungsten", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:tungsten_clump", count: 1}],
    time: 150,
    fluidInput: {fluid: "jsonreg:tungsten_solution", amount: 81000},
    ingredients: [{item: "jsonreg:salt_dust", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15c.recrystallize.tungsten", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:tungsten_gem", count: 1}],
    fluidOutputs: [{fluid: "oritech:still_mineral_slurry", amount: 8100}],
    time: 200,
    fluidInput: {fluid: "minecraft:water", amount: 40500},
    ingredients: [{item: "jsonreg:tungsten_clump", count: 1}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t15d.grind_gem.tungsten", {type: "techreborn:grinder",
    time: 200, power: 32,
    outputs: [{id: "jsonreg:tungsten_dust", count: 3}],
    ingredients: [{item: "jsonreg:tungsten_gem"}]
});

// ---------- 铱 ----------
<recipetype:oritech:refinery>.addJsonRecipe("general.t15a.leach.iridium", {type: "oritech:refinery",
    results: [],
    fluidOutputs: [
        {fluid: "jsonreg:iridium_solution", amount: 81000},
        {fluid: "oritech:still_mineral_slurry", amount: 20250}
    ],
    time: 160,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 81000},
    ingredients: [{item: "techreborn:raw_iridium", count: 2}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15b.precipitate.iridium", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:iridium_clump", count: 1}],
    time: 150,
    fluidInput: {fluid: "jsonreg:iridium_solution", amount: 81000},
    ingredients: [{item: "jsonreg:salt_dust", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15c.recrystallize.iridium", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:iridium_gem", count: 1}],
    fluidOutputs: [{fluid: "oritech:still_mineral_slurry", amount: 8100}],
    time: 200,
    fluidInput: {fluid: "minecraft:water", amount: 40500},
    ingredients: [{item: "jsonreg:iridium_clump", count: 1}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t15d.grind_gem.iridium", {type: "techreborn:grinder",
    time: 200, power: 32,
    outputs: [{id: "jsonreg:iridium_dust", count: 3}],
    ingredients: [{item: "jsonreg:iridium_gem"}]
});

// ---------- 铀 ----------
<recipetype:oritech:refinery>.addJsonRecipe("general.t15a.leach.uranium", {type: "oritech:refinery",
    results: [],
    fluidOutputs: [
        {fluid: "jsonreg:uranium_solution", amount: 81000},
        {fluid: "oritech:still_mineral_slurry", amount: 20250}
    ],
    time: 160,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 81000},
    ingredients: [{item: "oritech:raw_uranium", count: 2}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15b.precipitate.uranium", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:uranium_clump", count: 1}],
    time: 150,
    fluidInput: {fluid: "jsonreg:uranium_solution", amount: 81000},
    ingredients: [{item: "jsonreg:salt_dust", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15c.recrystallize.uranium", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:uranium_gem", count: 1}],
    fluidOutputs: [{fluid: "oritech:still_mineral_slurry", amount: 8100}],
    time: 200,
    fluidInput: {fluid: "minecraft:water", amount: 40500},
    ingredients: [{item: "jsonreg:uranium_clump", count: 1}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t15d.grind_gem.uranium", {type: "techreborn:grinder",
    time: 200, power: 32,
    outputs: [{id: "oritech:uranium_dust", count: 3}],
    ingredients: [{item: "jsonreg:uranium_gem"}]
});

// ---------- 铝 ----------
<recipetype:oritech:refinery>.addJsonRecipe("general.t15a.leach.aluminum", {type: "oritech:refinery",
    results: [],
    fluidOutputs: [
        {fluid: "jsonreg:aluminum_solution", amount: 81000},
        {fluid: "oritech:still_mineral_slurry", amount: 20250}
    ],
    time: 160,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 81000},
    ingredients: [{tag: "c:ores/bauxite", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15b.precipitate.aluminum", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:aluminum_clump", count: 1}],
    time: 150,
    fluidInput: {fluid: "jsonreg:aluminum_solution", amount: 81000},
    ingredients: [{item: "jsonreg:salt_dust", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15c.recrystallize.aluminum", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:aluminum_gem", count: 1}],
    fluidOutputs: [{fluid: "oritech:still_mineral_slurry", amount: 8100}],
    time: 200,
    fluidInput: {fluid: "minecraft:water", amount: 40500},
    ingredients: [{item: "jsonreg:aluminum_clump", count: 1}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t15d.grind_gem.aluminum", {type: "techreborn:grinder",
    time: 200, power: 32,
    outputs: [{id: "techreborn:aluminum_dust", count: 3}],
    ingredients: [{item: "jsonreg:aluminum_gem"}]
});

// ---------- 方铅 ----------
<recipetype:oritech:refinery>.addJsonRecipe("general.t15a.leach.galena", {type: "oritech:refinery",
    results: [],
    fluidOutputs: [
        {fluid: "jsonreg:galena_solution", amount: 81000},
        {fluid: "oritech:still_mineral_slurry", amount: 20250}
    ],
    time: 160,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 81000},
    ingredients: [{tag: "c:ores/galena", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15b.precipitate.galena", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:galena_clump", count: 1}],
    time: 150,
    fluidInput: {fluid: "jsonreg:galena_solution", amount: 81000},
    ingredients: [{item: "jsonreg:salt_dust", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15c.recrystallize.galena", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:galena_gem", count: 1}],
    fluidOutputs: [{fluid: "oritech:still_mineral_slurry", amount: 8100}],
    time: 200,
    fluidInput: {fluid: "minecraft:water", amount: 40500},
    ingredients: [{item: "jsonreg:galena_clump", count: 1}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t15d.grind_gem.galena", {type: "techreborn:grinder",
    time: 200, power: 32,
    outputs: [{id: "techreborn:galena_dust", count: 3}],
    ingredients: [{item: "jsonreg:galena_gem"}]
});

// ---------- 闪锌 ----------
<recipetype:oritech:refinery>.addJsonRecipe("general.t15a.leach.sphalerite", {type: "oritech:refinery",
    results: [],
    fluidOutputs: [
        {fluid: "jsonreg:sphalerite_solution", amount: 81000},
        {fluid: "oritech:still_mineral_slurry", amount: 20250}
    ],
    time: 160,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 81000},
    ingredients: [{tag: "c:ores/sphalerite", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15b.precipitate.sphalerite", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:sphalerite_clump", count: 1}],
    time: 150,
    fluidInput: {fluid: "jsonreg:sphalerite_solution", amount: 81000},
    ingredients: [{item: "jsonreg:salt_dust", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15c.recrystallize.sphalerite", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:sphalerite_gem", count: 1}],
    fluidOutputs: [{fluid: "oritech:still_mineral_slurry", amount: 8100}],
    time: 200,
    fluidInput: {fluid: "minecraft:water", amount: 40500},
    ingredients: [{item: "jsonreg:sphalerite_clump", count: 1}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t15d.grind_gem.sphalerite", {type: "techreborn:grinder",
    time: 200, power: 32,
    outputs: [{id: "techreborn:sphalerite_dust", count: 3}],
    ingredients: [{item: "jsonreg:sphalerite_gem"}]
});

// ---------- 朱砂 ----------
<recipetype:oritech:refinery>.addJsonRecipe("general.t15a.leach.cinnabar", {type: "oritech:refinery",
    results: [],
    fluidOutputs: [
        {fluid: "jsonreg:cinnabar_solution", amount: 81000},
        {fluid: "oritech:still_mineral_slurry", amount: 20250}
    ],
    time: 160,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 81000},
    ingredients: [{tag: "c:ores/cinnabar", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15b.precipitate.cinnabar", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:cinnabar_clump", count: 1}],
    time: 150,
    fluidInput: {fluid: "jsonreg:cinnabar_solution", amount: 81000},
    ingredients: [{item: "jsonreg:salt_dust", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15c.recrystallize.cinnabar", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:cinnabar_gem", count: 1}],
    fluidOutputs: [{fluid: "oritech:still_mineral_slurry", amount: 8100}],
    time: 200,
    fluidInput: {fluid: "minecraft:water", amount: 40500},
    ingredients: [{item: "jsonreg:cinnabar_clump", count: 1}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t15d.grind_gem.cinnabar", {type: "techreborn:grinder",
    time: 200, power: 32,
    outputs: [{id: "techreborn:cinnabar_dust", count: 3}],
    ingredients: [{item: "jsonreg:cinnabar_gem"}]
});

// ---------- 黄铁 ----------
<recipetype:oritech:refinery>.addJsonRecipe("general.t15a.leach.pyrite", {type: "oritech:refinery",
    results: [],
    fluidOutputs: [
        {fluid: "jsonreg:pyrite_solution", amount: 81000},
        {fluid: "oritech:still_mineral_slurry", amount: 20250}
    ],
    time: 160,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 81000},
    ingredients: [{tag: "c:ores/pyrite", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15b.precipitate.pyrite", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:pyrite_clump", count: 1}],
    time: 150,
    fluidInput: {fluid: "jsonreg:pyrite_solution", amount: 81000},
    ingredients: [{item: "jsonreg:salt_dust", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15c.recrystallize.pyrite", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:pyrite_gem", count: 1}],
    fluidOutputs: [{fluid: "oritech:still_mineral_slurry", amount: 8100}],
    time: 200,
    fluidInput: {fluid: "minecraft:water", amount: 40500},
    ingredients: [{item: "jsonreg:pyrite_clump", count: 1}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t15d.grind_gem.pyrite", {type: "techreborn:grinder",
    time: 200, power: 32,
    outputs: [{id: "techreborn:pyrite_dust", count: 3}],
    ingredients: [{item: "jsonreg:pyrite_gem"}]
});

// ---------- 方钠 ----------
<recipetype:oritech:refinery>.addJsonRecipe("general.t15a.leach.sodalite", {type: "oritech:refinery",
    results: [],
    fluidOutputs: [
        {fluid: "jsonreg:sodalite_solution", amount: 81000},
        {fluid: "oritech:still_mineral_slurry", amount: 20250}
    ],
    time: 160,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 81000},
    ingredients: [{tag: "c:ores/sodalite", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15b.precipitate.sodalite", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:sodalite_clump", count: 1}],
    time: 150,
    fluidInput: {fluid: "jsonreg:sodalite_solution", amount: 81000},
    ingredients: [{item: "jsonreg:salt_dust", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15c.recrystallize.sodalite", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:sodalite_gem", count: 1}],
    fluidOutputs: [{fluid: "oritech:still_mineral_slurry", amount: 8100}],
    time: 200,
    fluidInput: {fluid: "minecraft:water", amount: 40500},
    ingredients: [{item: "jsonreg:sodalite_clump", count: 1}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t15d.grind_gem.sodalite", {type: "techreborn:grinder",
    time: 200, power: 32,
    outputs: [{id: "techreborn:sodalite_dust", count: 3}],
    ingredients: [{item: "jsonreg:sodalite_gem"}]
});

// ---------- 氟石 ----------
// 非 raw 矿物，与黄铁/方钠同型：a 步直接吃矿石（不是粗矿），终点同样是 ×3 粉。
<recipetype:oritech:refinery>.addJsonRecipe("general.t15a.leach.fluorite", {type: "oritech:refinery",
    results: [],
    fluidOutputs: [
        {fluid: "jsonreg:fluorite_solution", amount: 81000},
        {fluid: "oritech:still_mineral_slurry", amount: 20250}
    ],
    time: 160,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 81000},
    ingredients: [{item: "jsonreg:nether_fluorite_ore", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15b.precipitate.fluorite", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:fluorite_clump", count: 1}],
    time: 150,
    fluidInput: {fluid: "jsonreg:fluorite_solution", amount: 81000},
    ingredients: [{item: "jsonreg:salt_dust", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15c.recrystallize.fluorite", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:fluorite_gem", count: 1}],
    fluidOutputs: [{fluid: "oritech:still_mineral_slurry", amount: 8100}],
    time: 200,
    fluidInput: {fluid: "minecraft:water", amount: 40500},
    ingredients: [{item: "jsonreg:fluorite_clump", count: 1}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t15d.grind_gem.fluorite", {type: "techreborn:grinder",
    time: 200, power: 32,
    outputs: [{id: "jsonreg:fluorite_dust", count: 3}],
    ingredients: [{item: "jsonreg:fluorite_gem"}]
});

// ============================================================
// T1.5：湿法初级浓缩
// ============================================================
// ---------- 钒磁铁矿 ----------
<recipetype:oritech:refinery>.addJsonRecipe("general.t15a.leach.vanadium_magnetite", {type: "oritech:refinery",
    results: [],
    fluidOutputs: [
        {fluid: "jsonreg:vanadium_magnetite_solution", amount: 81000},
        {fluid: "oritech:still_mineral_slurry", amount: 20250}
    ],
    time: 160,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 81000},
    ingredients: [{item: "jsonreg:nether_vanadium_magnetite_ore", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15b.precipitate.vanadium_magnetite", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:vanadium_magnetite_clump", count: 1}],
    time: 150,
    fluidInput: {fluid: "jsonreg:vanadium_magnetite_solution", amount: 81000},
    ingredients: [{item: "jsonreg:salt_dust", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15c.recrystallize.vanadium_magnetite", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:vanadium_magnetite_gem", count: 1}],
    fluidOutputs: [{fluid: "oritech:still_mineral_slurry", amount: 8100}],
    time: 200,
    fluidInput: {fluid: "minecraft:water", amount: 40500},
    ingredients: [{item: "jsonreg:vanadium_magnetite_clump", count: 1}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t15d.grind_gem.vanadium_magnetite", {type: "techreborn:grinder",
    time: 200, power: 32,
    outputs: [{id: "jsonreg:vanadium_magnetite_dust", count: 3}],
    ingredients: [{item: "jsonreg:vanadium_magnetite_gem"}]
});

// ---------- 软锰矿 ----------
<recipetype:oritech:refinery>.addJsonRecipe("general.t15a.leach.pyrolusite", {type: "oritech:refinery",
    results: [],
    fluidOutputs: [
        {fluid: "jsonreg:pyrolusite_solution", amount: 81000},
        {fluid: "oritech:still_mineral_slurry", amount: 20250}
    ],
    time: 160,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 81000},
    ingredients: [{item: "jsonreg:nether_pyrolusite_ore", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15b.precipitate.pyrolusite", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:pyrolusite_clump", count: 1}],
    time: 150,
    fluidInput: {fluid: "jsonreg:pyrolusite_solution", amount: 81000},
    ingredients: [{item: "jsonreg:salt_dust", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15c.recrystallize.pyrolusite", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:pyrolusite_gem", count: 1}],
    fluidOutputs: [{fluid: "oritech:still_mineral_slurry", amount: 8100}],
    time: 200,
    fluidInput: {fluid: "minecraft:water", amount: 40500},
    ingredients: [{item: "jsonreg:pyrolusite_clump", count: 1}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t15d.grind_gem.pyrolusite", {type: "techreborn:grinder",
    time: 200, power: 32,
    outputs: [{id: "techreborn:manganese_dust", count: 3}],
    ingredients: [{item: "jsonreg:pyrolusite_gem"}]
});

// ---------- 铬铁矿 ----------
<recipetype:oritech:refinery>.addJsonRecipe("general.t15a.leach.chromite", {type: "oritech:refinery",
    results: [],
    fluidOutputs: [
        {fluid: "jsonreg:chromite_solution", amount: 81000},
        {fluid: "oritech:still_mineral_slurry", amount: 20250}
    ],
    time: 160,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 81000},
    ingredients: [{item: "jsonreg:nether_chromite_ore", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15b.precipitate.chromite", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:chromite_clump", count: 1}],
    time: 150,
    fluidInput: {fluid: "jsonreg:chromite_solution", amount: 81000},
    ingredients: [{item: "jsonreg:salt_dust", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15c.recrystallize.chromite", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:chromite_gem", count: 1}],
    fluidOutputs: [{fluid: "oritech:still_mineral_slurry", amount: 8100}],
    time: 200,
    fluidInput: {fluid: "minecraft:water", amount: 40500},
    ingredients: [{item: "jsonreg:chromite_clump", count: 1}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t15d.grind_gem.chromite", {type: "techreborn:grinder",
    time: 200, power: 32,
    outputs: [{id: "techreborn:chrome_dust", count: 3}],
    ingredients: [{item: "jsonreg:chromite_gem"}]
});

// ---------- 硬锰矿 ----------
<recipetype:oritech:refinery>.addJsonRecipe("general.t15a.leach.hausmannite", {type: "oritech:refinery",
    results: [],
    fluidOutputs: [
        {fluid: "jsonreg:hausmannite_solution", amount: 81000},
        {fluid: "oritech:still_mineral_slurry", amount: 20250}
    ],
    time: 160,
    fluidInput: {fluid: "oritech:still_sulfuric_acid", amount: 81000},
    ingredients: [{item: "jsonreg:nether_hausmannite_ore", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15b.precipitate.hausmannite", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:hausmannite_clump", count: 1}],
    time: 150,
    fluidInput: {fluid: "jsonreg:hausmannite_solution", amount: 81000},
    ingredients: [{item: "jsonreg:salt_dust", count: 1}]
});
<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15c.recrystallize.hausmannite", {type: "oritech:centrifuge_fluid",
    results: [{id: "jsonreg:hausmannite_gem", count: 1}],
    fluidOutputs: [{fluid: "oritech:still_mineral_slurry", amount: 8100}],
    time: 200,
    fluidInput: {fluid: "minecraft:water", amount: 40500},
    ingredients: [{item: "jsonreg:hausmannite_clump", count: 1}]
});
<recipetype:techreborn:grinder>.addJsonRecipe("general.t15d.grind_gem.hausmannite", {type: "techreborn:grinder",
    time: 200, power: 32,
    outputs: [{id: "techreborn:manganese_dust", count: 3}],
    ingredients: [{item: "jsonreg:hausmannite_gem"}]
});

