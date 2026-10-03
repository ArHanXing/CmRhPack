// ============================================================
// 核燃料产线（设计见 scripts/nuclear_design.md）
// ============================================================
// 单元（cell）守恒是硬约束：进出的 cell 数（含补的空单元）必须相等。
//   本文件所有配方都满足，未用到任何「空单元配平」补位。
//
// 槽位上限已核对：
//   TR 化反 2 出 / 大化反 4 出 / 磨粉机 1 出 / 压缩机 1 出 / 装配机 1 出 / 离心机 ≥3 出
//   同位素分离机 2 进 2 出（新机器，规格见 scripts/isotope_separator_spec.md）
//
// ⚠ ④⑤⑥ 三条级联配方依赖新机器 techreborn:isotope_separator。
//   该机器尚在 TR 源码侧实现中；机器落地前这三条会让 CrT 报「未知 recipetype」。
//   如需先跑其余部分，把本文件里标注 [级联] 的三条注释掉即可。
//
// 试剂闭环（以 1 颗铀燃料棒计）：
//   硫酸：① 耗 1 / ② 产 1  -> 净 0
//   氢氟酸：② 耗 1 / ⑨ 产 2 -> 净 +1（外送给超能硅岩线，与氟石线呼应）
//   尾料UF₆：④⑤⑥ 产 / ③ 回填 -> 净 0（回路内持有 7 份，见设计文档）

// ============================================================
// A 转化段
// ============================================================

// ① 酸浸溶出：铀粉 ×8 + 硫酸 -> 铀酰硫酸溶液
//   1 铀矿 --T1.5--> 3 铀粉，故 1 颗燃料棒 ≈ 2.67 铀矿
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("nuclear.0.leach", {type: "techreborn:chemical_reactor",
    time: 400,
    power: 128,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:uranyl_sulfate_solution"}}
    ],
    ingredients: [
        {item: "oritech:uranium_dust", count: 8},
        {count: 1, components: {"techreborn:fluid": "oritech:still_sulfuric_acid"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// ② 氟化：铀酰硫酸溶液 + 氢氟酸 -> 天然六氟化铀 + 硫酸（酸回流，闭环）
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("nuclear.1.fluorinate", {type: "techreborn:chemical_reactor",
    time: 400,
    power: 128,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:natural_uf6"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "oritech:still_sulfuric_acid"}}
    ],
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:uranyl_sulfate_solution"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 1, components: {"techreborn:fluid": "jsonreg:hydrofluoric_acid"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// ③ 配料：天然料与新回流的尾料混合成级联进料
//   这是尾料回路的汇合点 —— 尾料必须全部回到这里，否则产率崩
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("nuclear.2.blend", {type: "techreborn:chemical_reactor",
    time: 200,
    power: 64,
    outputs: [
        {id: "techreborn:cell", count: 2, components: {"techreborn:fluid": "jsonreg:cascade_feed_uf6"}}
    ],
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:natural_uf6"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 1, components: {"techreborn:fluid": "jsonreg:tails_uf6"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// ============================================================
// B 级联段 [级联] —— 依赖 techreborn:isotope_separator
// ============================================================
// 分离比 2:1（每级浓度翻倍）：0.70% -> 1.40% -> 2.80% -> 5.60%
// 机器数量比 ④:⑤:⑥ = 4:2:1；启动需先向回路预充 7 份尾料UF₆
// degraded_output：转速 > 60% 时产品降一级（由机器在运行时替换 outputs[0]）

<recipetype:techreborn:isotope_separator>.addJsonRecipe("nuclear.3.stage1", {type: "techreborn:isotope_separator",
    time: 6000,
    power: 128,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:low_uf6"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:tails_uf6"}}
    ],
    degraded_output: {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:natural_uf6"}},
    ingredients: [
        {count: 2, components: {"techreborn:fluid": "jsonreg:cascade_feed_uf6"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

<recipetype:techreborn:isotope_separator>.addJsonRecipe("nuclear.4.stage2", {type: "techreborn:isotope_separator",
    time: 6000,
    power: 128,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:mid_uf6"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:tails_uf6"}}
    ],
    degraded_output: {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:low_uf6"}},
    ingredients: [
        {count: 2, components: {"techreborn:fluid": "jsonreg:low_uf6"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

<recipetype:techreborn:isotope_separator>.addJsonRecipe("nuclear.5.stage3", {type: "techreborn:isotope_separator",
    time: 6000,
    power: 128,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:high_uf6"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:tails_uf6"}}
    ],
    degraded_output: {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:mid_uf6"}},
    ingredients: [
        {count: 2, components: {"techreborn:fluid": "jsonreg:mid_uf6"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// ============================================================
// C 成品段
// ============================================================

// ⑨ 还原：反应堆级六氟化铀 + 氢 -> 浓缩铀粉 + 氢氟酸 ×2
//   产 2 份 HF 而 ② 只耗 1 份 -> 氢氟酸净产出，外送给超能硅岩线
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("nuclear.6.reduce", {type: "techreborn:chemical_reactor",
    time: 600,
    power: 256,
    outputs: [
        {id: "jsonreg:enriched_uranium_dust", count: 1},
        {id: "techreborn:cell", count: 2, components: {"techreborn:fluid": "jsonreg:hydrofluoric_acid"}}
    ],
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:high_uf6"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 1, components: {"techreborn:fluid": "techreborn:hydrogen"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// ⑩ 制棒：浓缩铀粉 + 空棒 -> 铀燃料棒
<recipetype:techreborn:precise_assembler>.addJsonRecipe("nuclear.7.rod_uranium", {type: "techreborn:precise_assembler",
    time: 200,
    power: 64,
    outputs: [
        {id: "jsonreg:uranium_fuel_rod", count: 1}
    ],
    ingredients: [
        {item: "jsonreg:enriched_uranium_dust", count: 1},
        {item: "jsonreg:fuel_rod", count: 1}
    ]
});

// ⑪ 尾料排放：从回路里放出贫化料，回收氢氟酸
//   不排的话尾料会在回路里无限累积；这是级联的「放血阀」
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("nuclear.8.tails_bleed", {type: "techreborn:chemical_reactor",
    time: 400,
    power: 128,
    outputs: [
        {id: "jsonreg:depleted_uranium_slag", count: 1},
        {id: "techreborn:cell", count: 2, components: {"techreborn:fluid": "jsonreg:hydrofluoric_acid"}}
    ],
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:tails_uf6"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 1, components: {"techreborn:fluid": "techreborn:hydrogen"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// ⑫ 贫铀利用：贫铀废渣 -> 贫铀合金坚固板
<recipetype:techreborn:compressor>.addJsonRecipe("nuclear.9.depleted_plate", {type: "techreborn:compressor",
    time: 300,
    power: 32,
    outputs: [
        {id: "jsonreg:depleted_uranium_dense_plate", count: 1}
    ],
    ingredients: [
        {item: "jsonreg:depleted_uranium_slag", count: 4}
    ]
});

// ============================================================
// D MOX 线（吃铀线的贫铀废渣）
// ============================================================
// 真实 MOX 工艺：UO₂ 基体 + PuO₂ 混合 -> 压制 -> 高温烧结 -> 装壳
// 基体正是铀线的贫铀废渣，故两条线自然咬合（铀:MOX ≈ 2:1）

// ① 氧化：贫铀废渣 -> 二氧化铀（UO₂）
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("nuclear.mox.0.oxide", {type: "techreborn:chemical_reactor",
    time: 300,
    power: 64,
    outputs: [
        {id: "jsonreg:uranium_dioxide_dust", count: 2},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {item: "jsonreg:depleted_uranium_slag", count: 2},
        {count: 1, components: {"techreborn:fluid": "techreborn:compressed_air"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// ② 制粉：钚球 -> 钚粉（钚球来自粒子加速器 / 末影激光器，T2.4 已有产出）
<recipetype:techreborn:grinder>.addJsonRecipe("nuclear.mox.1.plutonium", {type: "techreborn:grinder",
    time: 200,
    power: 32,
    outputs: [
        {id: "oritech:plutonium_dust", count: 1}
    ],
    ingredients: [
        {item: "oritech:plutonium_pellet", count: 1}
    ]
});

// ③ 混料：UO₂ 粉 ×7 + 钚粉 ×3 -> MOX 混合粉 ×10
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("nuclear.mox.2.blend", {type: "techreborn:chemical_reactor",
    time: 400,
    power: 128,
    outputs: [
        {id: "jsonreg:mox_blend_dust", count: 10}
    ],
    ingredients: [
        {item: "jsonreg:uranium_dioxide_dust", count: 7},
        {item: "oritech:plutonium_dust", count: 3}
    ]
});

// ④ 压制：MOX 混合粉 -> MOX 生坯
<recipetype:techreborn:compressor>.addJsonRecipe("nuclear.mox.3.press", {type: "techreborn:compressor",
    time: 200,
    power: 64,
    outputs: [
        {id: "jsonreg:mox_green_pellet", count: 1}
    ],
    ingredients: [
        {item: "jsonreg:mox_blend_dust", count: 2}
    ]
});

// ⑤ 烧结：MOX 生坯 --电高炉 heat 2500--> MOX 陶瓷芯块
<recipetype:techreborn:blast_furnace>.addJsonRecipe("nuclear.mox.4.sinter", {type: "techreborn:blast_furnace",
    time: 600,
    heat: 2500,
    power: 128,
    outputs: [
        {id: "jsonreg:mox_ceramic_pellet", count: 1}
    ],
    ingredients: [
        {item: "jsonreg:mox_green_pellet", count: 1}
    ]
});

// ⑥ 装壳：MOX 陶瓷芯块 + 空棒 + 铅板 -> MOX 燃料棒
<recipetype:techreborn:precise_assembler>.addJsonRecipe("nuclear.mox.5.rod", {type: "techreborn:precise_assembler",
    time: 300,
    power: 64,
    outputs: [
        {id: "jsonreg:mox_fuel_rod", count: 1}
    ],
    ingredients: [
        {item: "jsonreg:mox_ceramic_pellet", count: 1},
        {item: "jsonreg:fuel_rod", count: 1},
        {item: "techreborn:lead_plate", count: 2}
    ]
});

// ============================================================
// E 钍线（刻意做短：现实钍燃料不需要浓缩）
// ============================================================

// ① 析出：钍浓缩液（超能硅岩线副产）-> 钍粉
<recipetype:techreborn:centrifuge>.addJsonRecipe("nuclear.th.0.precipitate", {type: "techreborn:centrifuge",
    time: 400,
    power: 32,
    outputs: [
        {id: "jsonreg:thorium_dust", count: 1},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:thorium_concentrate"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// ② 制棒：钍粉 + 空棒 -> 钍燃料棒
<recipetype:techreborn:precise_assembler>.addJsonRecipe("nuclear.th.1.rod", {type: "techreborn:precise_assembler",
    time: 200,
    power: 64,
    outputs: [
        {id: "jsonreg:thorium_fuel_rod", count: 1}
    ],
    ingredients: [
        {item: "jsonreg:thorium_dust", count: 1},
        {item: "jsonreg:fuel_rod", count: 1}
    ]
});
