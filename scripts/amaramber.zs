import crafttweaker.api.recipe.type.Recipe;

// =====================================================================
// 榧木 → 绯夜脂（raw_amaramber）产线
// =====================================================================
// 四步，全部为机械工艺，无魔法前置：
//   ① 榧木热解   榧木 → 榧木焦油 + 二氧化碳            （工业高炉）
//   ② 乙醇萃取   榧木 + 乙醇 → 榧木树脂 + 回收乙醇      （化工反应器）
//   ②b 乙醇回收  回收乙醇 → 乙醇                        （化工反应器）
//   ③ 裂解树脂   榧木树脂 → 绯夜前驱体 + 燃料气         （蒸馏塔）
//   ④ 基团活化   绯夜前驱体 + 烈焰粉 → 绯夜脂          （化工反应器）
//
// 化学依据：
//   榧木（Torreya）在真实中富含紫杉烷类与挥发性萜类，干馏可得焦油；
//   乙醇作为极性溶剂萃取树脂质（松脂/萜烯）是标准做法；
//   树脂裂解（pyrolysis of resin）产生芳香族前体；
//   最后用烈焰粉提供的强放热活化能把前驱体闭合成绯夜脂的共轭骨架。
//
// 物料账（每格 = 1 cell = 1000 mB = 81000 OR 单位）：
//   ① 2 cell 进 → 2 cell 出        ✅
//   ② 2 cell 进 → 2 cell 出        ✅（乙醇净消耗 1）
//   ②b 2 cell 进 → 2 cell 出       ✅（50% 回收率）
//   ③ 4 cell 进 → 4 cell 出        ✅（2 装满 + 2 空）
//   ④ 1 cell 进 → 1 cell 出        ✅
//
// 与温室的联动：greenhouse.zs 已有 `torreya_sapling → torreya_log ×2`，
// 所以本线是**可再生闭环**，不必满世界砍树。
//
// 另注：raw_amaramber 原本只能靠「给榧木去皮」概率获得（见 tooltip.zs），
// 本线把它变成确定性产出，且不依赖随机。
// =====================================================================


// =====================================================================
// ① 榧木热解（工业高炉）
// =====================================================================
// 干馏：木材在隔绝空气下加热，挥发分馏出为焦油与不可凝气。
// ⚠ 输出只能 2 个：工业炉的 inventory 共 5 槽（输入[0,1] / 输出[2,3] / 能量[4]），
//   反编译 IndustrialBlastFurnaceBlockEntity 构造确认第三、四个参数是 [0,1] 与 [2,3]。
//   原本想再加一个木炭，实测 3 输出会越界，故残炭不单独产出。
// 真实木材热解的不可凝气主要是 CO₂ + CO + CH₄，这里取 CO₂ 作为主成分
// （本包此前完全没有二氧化碳流体，见文末「二氧化碳固有配方」）。
<recipetype:techreborn:blast_furnace>.addJsonRecipe("amaramber.1.pyrolysis", {type: "techreborn:blast_furnace",
    time: 600,
    heat: 1500,
    power: 64,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:torreya_tar"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:carbon_dioxide"}}
    ],
    ingredients: [
        {item: "eternal_starlight:torreya_log", count: 1},
        {count: 2, components: {"techreborn:fluid": "minecraft:empty"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});


// =====================================================================
// ② 乙醇萃取（化工反应器）
// =====================================================================
// 乙醇浸泡榧木屑，溶出树脂质；溶剂部分失效后成为「回收乙醇」。
// 一次投 2 个乙醇单元，其中 1 个随树脂带走、1 个以回收态返回 ——
// 所以**每轮净消耗 1 个乙醇**，回收乙醇走 ②b 再生。
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("amaramber.2.extract", {type: "techreborn:chemical_reactor",
    time: 300,
    power: 64,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:torreya_resin"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:recovered_ethanol"}}
    ],
    ingredients: [
        {item: "eternal_starlight:torreya_log", count: 2},
        {count: 2, components: {"techreborn:fluid": "jsonreg:ethanol"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// ②b 乙醇回收（化工反应器）
// 实际是精馏提纯的抽象：2 单元回收乙醇 → 1 单元可用乙醇 + 1 空单元，50% 收率。
// 这个损失是故意的 —— 让乙醇保持真实消耗品属性，而不是靠循环无限白嫖。
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("amaramber.2b.recover_ethanol", {type: "techreborn:chemical_reactor",
    time: 200,
    power: 30,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:ethanol"}},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {count: 2, components: {"techreborn:fluid": "jsonreg:recovered_ethanol"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});


// =====================================================================
// ③ 裂解树脂（蒸馏塔）
// =====================================================================
// 树脂在塔内分级裂解，轻组分走燃料气，主馏分是绯夜前驱体。
// 蒸馏塔 4 进 6 出：2 装满树脂单元 + 2 空单元 → 2 装满产物 + 2 空单元。
<recipetype:techreborn:distillation_tower>.addJsonRecipe("amaramber.3.crack_resin", {type: "techreborn:distillation_tower",
    time: 400,
    power: 64,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:amaramber_precursor"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:fuel_gas"}},
        {id: "techreborn:cell", count: 2}
    ],
    ingredients: [
        {count: 2, components: {"techreborn:fluid": "jsonreg:torreya_resin"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 2, components: {"techreborn:fluid": "minecraft:empty"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});


// =====================================================================
// ④ 绯夜基团活化（化工反应器）
// =====================================================================
// 烈焰粉提供强放热活化能，把前驱体的共轭骨架闭合为绯夜脂。
// 这就是整条线的终点 —— 产出 eternal_starlight:raw_amaramber。
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("amaramber.4.activate", {type: "techreborn:chemical_reactor",
    time: 400,
    power: 128,
    outputs: [
        {id: "eternal_starlight:raw_amaramber", count: 1},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:amaramber_precursor"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "minecraft:blaze_powder", count: 2}
    ]
});


// =====================================================================
// 二氧化碳（jsonreg:carbon_dioxide）的固有配方
// =====================================================================
// 本包此前**完全没有二氧化碳**（TR / Oritech 的 jar 内均无此流体），
// 而 ① 的副产会持续产出它。若没有出口，产物只能堆仓。
// 这里补齐三条最小闭环：燃烧（产）、电解（CO + O₂）、Sabatier（甲烷化）。

// —— 产：碳 + 压缩空气 → CO₂（燃烧）——
// 真实为 C + O₂ → CO₂。压缩空气既提供氧，也作为载气。
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("amaramber.co2.combustion", {type: "techreborn:chemical_reactor",
    time: 200,
    power: 30,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:carbon_dioxide"}}
    ],
    ingredients: [
        {item: "techreborn:coal_dust", count: 1},
        {count: 1, components: {"techreborn:fluid": "techreborn:compressed_air"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// —— 电解：2 CO₂ → 2 CO + O₂ ——
// 真实高温电解 CO₂ 的主产物就是 CO（可作为还原气/羰基合成原料）与氧气。
<recipetype:techreborn:industrial_electrolyzer>.addJsonRecipe("amaramber.co2.electrolysis", {type: "techreborn:industrial_electrolyzer",
    time: 400,
    power: 128,
    outputs: [
        {id: "techreborn:cell", count: 2, components: {"techreborn:fluid": "jsonreg:carbon_monoxide"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:liquid_oxygen"}}
    ],
    ingredients: [
        {count: 2, components: {"techreborn:fluid": "jsonreg:carbon_dioxide"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 1, components: {"techreborn:fluid": "minecraft:empty"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// —— Sabatier 甲烷化：CO₂ + 4 H₂ → CH₄ + 2 H₂O ——
// 真实 Sabatier 反应，是空间站/潜艇的二氧化碳再生核心技术。
// 放在大化反（6 进 4 出）是因为 cell 进出共 5 个，化反的 2 槽放不下。
<recipetype:techreborn:large_chemical_reactor>.addJsonRecipe("amaramber.co2.sabatier", {type: "techreborn:large_chemical_reactor",
    time: 400,
    power: 128,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "techreborn:methane"}},
        {id: "techreborn:cell", count: 2, components: {"techreborn:fluid": "minecraft:water"}},
        {id: "techreborn:cell", count: 2}
    ],
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:carbon_dioxide"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 4, components: {"techreborn:fluid": "techreborn:hydrogen"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});


// =====================================================================
// 榧木焦油的出口（避免死产物）
// =====================================================================
// 热解每轮必产 1 桶焦油，而本线主流程不用它。若不给出口，
// 玩家会被迫堆仓或倒掉 —— 木焦油在真实中本就是燃料与化工原料。
// 这里只给「燃料」这一个最小出口：42 EU/t × 1000 = 42,000 EU/桶，
// 介于原油（26,000）与重柴油（148,000）之间，符合木焦油的实际热值位置。
<recipetype:techreborn:semi_fluid_generator>.addJsonRecipe("oil.burn.trsemi_fluid/torreya_tar", {type: "techreborn:semi_fluid_generator", power: 42, fluid: "jsonreg:torreya_tar"});
<recipetype:oritech:fuel_generator>.addJsonRecipe("oil.burn.orfuelgen/torreya_tar", {type: "oritech:fuel_generator", results: [], time: 8, fluidInput: {fluid: "jsonreg:torreya_tar", amount: 8100}, ingredients: []});
