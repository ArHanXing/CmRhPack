// ============================================================
// OR → TR 大型机器兼容层（由 scripts/tools/gen_large_machine_compat.py 生成，勿手改）
// ============================================================
// TechReborn 5.12.13 新增两台多方块机器，都是 4 进 6 出，
// 配方类型为 RebornRecipe（无原生流体字段，流体走 techreborn:fluid 组件单元）：
//   oritech:centrifuge_fluid  →  techreborn:large_mixer     (power 32)
//   oritech:refinery          →  techreborn:large_refinery  (power 64)
//
// 转换规则：OR 流体量不是 1000mB 整数倍时，整条配方翻倍 m 次
//   （时间 / 物品进出 / 流体进出一起翻）直到全部凑整，再把每个 1000mB 折成 1 个单元。
//   cell 守恒：入侧满单元多则在产出侧补空单元，反之在输入侧补。
//   ⚠ OR 配方里「装满液体的单元」是以物品形态出现在 ingredients 里的
//     （例：oil.process.or.nitric_acid 的水单元），转换时保留其流体组件。
//   奖励：耗时 ×0.8、耗能 ×0.5（FE→EU 按 1:1，基准见 precision_assembly.zs）。
//
// 共 70 条；OR 原配方保留不动，本文件只做「复制一份给 TR」。
// ============================================================

<recipetype:techreborn:large_mixer>.addJsonRecipe("large.mixer.bio.sep.ethanol", {type: "techreborn:large_mixer",
    time: 160,
    power: 32,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:bio_ethanol"}}
    ],
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:fermented_mash"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

<recipetype:techreborn:large_refinery>.addJsonRecipe("large.refinery.general.t15e.byproduct.gypsum", {type: "techreborn:large_refinery",
    time: 128,
    power: 64,
    outputs: [
        {id: "jsonreg:calcium_sulfate_dust", count: 2},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "oritech:still_mineral_slurry"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

<recipetype:techreborn:large_refinery>.addJsonRecipe("large.refinery.general.t15a.leach.copper", {type: "techreborn:large_refinery",
    time: 512,
    power: 64,
    outputs: [
        {id: "techreborn:cell", count: 4, components: {"techreborn:fluid": "jsonreg:copper_solution"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "oritech:still_mineral_slurry"}}
    ],
    ingredients: [
        {count: 4, components: {"techreborn:fluid": "oritech:still_sulfuric_acid"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "minecraft:raw_copper", count: 8},
        {count: 1, components: {"techreborn:fluid": "minecraft:empty"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

<recipetype:techreborn:large_mixer>.addJsonRecipe("large.mixer.general.t15b.precipitate.copper", {type: "techreborn:large_mixer",
    time: 120,
    power: 32,
    outputs: [
        {id: "oritech:copper_clump", count: 1},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:copper_solution"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "jsonreg:salt_dust", count: 1}
    ]
});

<recipetype:techreborn:large_mixer>.addJsonRecipe("large.mixer.general.t15c.recrystallize.copper", {type: "techreborn:large_mixer",
    time: 1600,
    power: 32,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "oritech:still_mineral_slurry"}},
        {id: "oritech:copper_gem", count: 10},
        {id: "techreborn:cell", count: 4}
    ],
    ingredients: [
        {count: 5, components: {"techreborn:fluid": "minecraft:water"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "oritech:copper_clump", count: 10}
    ]
});

<recipetype:techreborn:large_refinery>.addJsonRecipe("large.refinery.general.t15a.leach.gold", {type: "techreborn:large_refinery",
    time: 512,
    power: 64,
    outputs: [
        {id: "techreborn:cell", count: 4, components: {"techreborn:fluid": "jsonreg:gold_solution"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "oritech:still_mineral_slurry"}}
    ],
    ingredients: [
        {count: 4, components: {"techreborn:fluid": "oritech:still_sulfuric_acid"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "minecraft:raw_gold", count: 8},
        {count: 1, components: {"techreborn:fluid": "minecraft:empty"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

<recipetype:techreborn:large_mixer>.addJsonRecipe("large.mixer.general.t15b.precipitate.gold", {type: "techreborn:large_mixer",
    time: 120,
    power: 32,
    outputs: [
        {id: "oritech:gold_clump", count: 1},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:gold_solution"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "jsonreg:salt_dust", count: 1}
    ]
});

<recipetype:techreborn:large_mixer>.addJsonRecipe("large.mixer.general.t15c.recrystallize.gold", {type: "techreborn:large_mixer",
    time: 1600,
    power: 32,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "oritech:still_mineral_slurry"}},
        {id: "oritech:gold_gem", count: 10},
        {id: "techreborn:cell", count: 4}
    ],
    ingredients: [
        {count: 5, components: {"techreborn:fluid": "minecraft:water"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "oritech:gold_clump", count: 10}
    ]
});

<recipetype:techreborn:large_refinery>.addJsonRecipe("large.refinery.general.t15a.leach.iron", {type: "techreborn:large_refinery",
    time: 512,
    power: 64,
    outputs: [
        {id: "techreborn:cell", count: 4, components: {"techreborn:fluid": "jsonreg:iron_solution"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "oritech:still_mineral_slurry"}}
    ],
    ingredients: [
        {count: 4, components: {"techreborn:fluid": "oritech:still_sulfuric_acid"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "minecraft:raw_iron", count: 8},
        {count: 1, components: {"techreborn:fluid": "minecraft:empty"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

<recipetype:techreborn:large_mixer>.addJsonRecipe("large.mixer.general.t15b.precipitate.iron", {type: "techreborn:large_mixer",
    time: 120,
    power: 32,
    outputs: [
        {id: "oritech:iron_clump", count: 1},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:iron_solution"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "jsonreg:salt_dust", count: 1}
    ]
});

<recipetype:techreborn:large_mixer>.addJsonRecipe("large.mixer.general.t15c.recrystallize.iron", {type: "techreborn:large_mixer",
    time: 1600,
    power: 32,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "oritech:still_mineral_slurry"}},
        {id: "oritech:iron_gem", count: 10},
        {id: "techreborn:cell", count: 4}
    ],
    ingredients: [
        {count: 5, components: {"techreborn:fluid": "minecraft:water"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "oritech:iron_clump", count: 10}
    ]
});

<recipetype:techreborn:large_refinery>.addJsonRecipe("large.refinery.general.t15a.leach.nickel", {type: "techreborn:large_refinery",
    time: 512,
    power: 64,
    outputs: [
        {id: "techreborn:cell", count: 4, components: {"techreborn:fluid": "jsonreg:nickel_solution"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "oritech:still_mineral_slurry"}}
    ],
    ingredients: [
        {count: 4, components: {"techreborn:fluid": "oritech:still_sulfuric_acid"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "oritech:raw_nickel", count: 8},
        {count: 1, components: {"techreborn:fluid": "minecraft:empty"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

<recipetype:techreborn:large_mixer>.addJsonRecipe("large.mixer.general.t15b.precipitate.nickel", {type: "techreborn:large_mixer",
    time: 120,
    power: 32,
    outputs: [
        {id: "oritech:nickel_clump", count: 1},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:nickel_solution"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "jsonreg:salt_dust", count: 1}
    ]
});

<recipetype:techreborn:large_mixer>.addJsonRecipe("large.mixer.general.t15c.recrystallize.nickel", {type: "techreborn:large_mixer",
    time: 1600,
    power: 32,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "oritech:still_mineral_slurry"}},
        {id: "oritech:nickel_gem", count: 10},
        {id: "techreborn:cell", count: 4}
    ],
    ingredients: [
        {count: 5, components: {"techreborn:fluid": "minecraft:water"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "oritech:nickel_clump", count: 10}
    ]
});

<recipetype:techreborn:large_refinery>.addJsonRecipe("large.refinery.general.t15a.leach.platinum", {type: "techreborn:large_refinery",
    time: 512,
    power: 64,
    outputs: [
        {id: "techreborn:cell", count: 4, components: {"techreborn:fluid": "jsonreg:platinum_solution"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "oritech:still_mineral_slurry"}}
    ],
    ingredients: [
        {count: 4, components: {"techreborn:fluid": "oritech:still_sulfuric_acid"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "oritech:raw_platinum", count: 8},
        {count: 1, components: {"techreborn:fluid": "minecraft:empty"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

<recipetype:techreborn:large_mixer>.addJsonRecipe("large.mixer.general.t15b.precipitate.platinum", {type: "techreborn:large_mixer",
    time: 120,
    power: 32,
    outputs: [
        {id: "oritech:platinum_clump", count: 1},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:platinum_solution"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "jsonreg:salt_dust", count: 1}
    ]
});

<recipetype:techreborn:large_mixer>.addJsonRecipe("large.mixer.general.t15c.recrystallize.platinum", {type: "techreborn:large_mixer",
    time: 1600,
    power: 32,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "oritech:still_mineral_slurry"}},
        {id: "oritech:platinum_gem", count: 10},
        {id: "techreborn:cell", count: 4}
    ],
    ingredients: [
        {count: 5, components: {"techreborn:fluid": "minecraft:water"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "oritech:platinum_clump", count: 10}
    ]
});

<recipetype:techreborn:large_refinery>.addJsonRecipe("large.refinery.general.t15a.leach.lead", {type: "techreborn:large_refinery",
    time: 512,
    power: 64,
    outputs: [
        {id: "techreborn:cell", count: 4, components: {"techreborn:fluid": "jsonreg:lead_solution"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "oritech:still_mineral_slurry"}}
    ],
    ingredients: [
        {count: 4, components: {"techreborn:fluid": "oritech:still_sulfuric_acid"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "techreborn:raw_lead", count: 8},
        {count: 1, components: {"techreborn:fluid": "minecraft:empty"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

<recipetype:techreborn:large_mixer>.addJsonRecipe("large.mixer.general.t15b.precipitate.lead", {type: "techreborn:large_mixer",
    time: 120,
    power: 32,
    outputs: [
        {id: "jsonreg:lead_clump", count: 1},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:lead_solution"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "jsonreg:salt_dust", count: 1}
    ]
});

<recipetype:techreborn:large_mixer>.addJsonRecipe("large.mixer.general.t15c.recrystallize.lead", {type: "techreborn:large_mixer",
    time: 1600,
    power: 32,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "oritech:still_mineral_slurry"}},
        {id: "jsonreg:lead_gem", count: 10},
        {id: "techreborn:cell", count: 4}
    ],
    ingredients: [
        {count: 5, components: {"techreborn:fluid": "minecraft:water"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "jsonreg:lead_clump", count: 10}
    ]
});

<recipetype:techreborn:large_refinery>.addJsonRecipe("large.refinery.general.t15a.leach.silver", {type: "techreborn:large_refinery",
    time: 512,
    power: 64,
    outputs: [
        {id: "techreborn:cell", count: 4, components: {"techreborn:fluid": "jsonreg:silver_solution"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "oritech:still_mineral_slurry"}}
    ],
    ingredients: [
        {count: 4, components: {"techreborn:fluid": "oritech:still_sulfuric_acid"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "techreborn:raw_silver", count: 8},
        {count: 1, components: {"techreborn:fluid": "minecraft:empty"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

<recipetype:techreborn:large_mixer>.addJsonRecipe("large.mixer.general.t15b.precipitate.silver", {type: "techreborn:large_mixer",
    time: 120,
    power: 32,
    outputs: [
        {id: "jsonreg:silver_clump", count: 1},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:silver_solution"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "jsonreg:salt_dust", count: 1}
    ]
});

<recipetype:techreborn:large_mixer>.addJsonRecipe("large.mixer.general.t15c.recrystallize.silver", {type: "techreborn:large_mixer",
    time: 1600,
    power: 32,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "oritech:still_mineral_slurry"}},
        {id: "jsonreg:silver_gem", count: 10},
        {id: "techreborn:cell", count: 4}
    ],
    ingredients: [
        {count: 5, components: {"techreborn:fluid": "minecraft:water"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "jsonreg:silver_clump", count: 10}
    ]
});

<recipetype:techreborn:large_refinery>.addJsonRecipe("large.refinery.general.t15a.leach.tin", {type: "techreborn:large_refinery",
    time: 512,
    power: 64,
    outputs: [
        {id: "techreborn:cell", count: 4, components: {"techreborn:fluid": "jsonreg:tin_solution"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "oritech:still_mineral_slurry"}}
    ],
    ingredients: [
        {count: 4, components: {"techreborn:fluid": "oritech:still_sulfuric_acid"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "techreborn:raw_tin", count: 8},
        {count: 1, components: {"techreborn:fluid": "minecraft:empty"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

<recipetype:techreborn:large_mixer>.addJsonRecipe("large.mixer.general.t15b.precipitate.tin", {type: "techreborn:large_mixer",
    time: 120,
    power: 32,
    outputs: [
        {id: "jsonreg:tin_clump", count: 1},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:tin_solution"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "jsonreg:salt_dust", count: 1}
    ]
});

<recipetype:techreborn:large_mixer>.addJsonRecipe("large.mixer.general.t15c.recrystallize.tin", {type: "techreborn:large_mixer",
    time: 1600,
    power: 32,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "oritech:still_mineral_slurry"}},
        {id: "jsonreg:tin_gem", count: 10},
        {id: "techreborn:cell", count: 4}
    ],
    ingredients: [
        {count: 5, components: {"techreborn:fluid": "minecraft:water"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "jsonreg:tin_clump", count: 10}
    ]
});

<recipetype:techreborn:large_refinery>.addJsonRecipe("large.refinery.general.t15a.leach.tungsten", {type: "techreborn:large_refinery",
    time: 512,
    power: 64,
    outputs: [
        {id: "techreborn:cell", count: 4, components: {"techreborn:fluid": "jsonreg:tungsten_solution"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "oritech:still_mineral_slurry"}}
    ],
    ingredients: [
        {count: 4, components: {"techreborn:fluid": "oritech:still_sulfuric_acid"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "techreborn:raw_tungsten", count: 8},
        {count: 1, components: {"techreborn:fluid": "minecraft:empty"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

<recipetype:techreborn:large_mixer>.addJsonRecipe("large.mixer.general.t15b.precipitate.tungsten", {type: "techreborn:large_mixer",
    time: 120,
    power: 32,
    outputs: [
        {id: "jsonreg:tungsten_clump", count: 1},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:tungsten_solution"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "jsonreg:salt_dust", count: 1}
    ]
});

<recipetype:techreborn:large_mixer>.addJsonRecipe("large.mixer.general.t15c.recrystallize.tungsten", {type: "techreborn:large_mixer",
    time: 1600,
    power: 32,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "oritech:still_mineral_slurry"}},
        {id: "jsonreg:tungsten_gem", count: 10},
        {id: "techreborn:cell", count: 4}
    ],
    ingredients: [
        {count: 5, components: {"techreborn:fluid": "minecraft:water"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "jsonreg:tungsten_clump", count: 10}
    ]
});

<recipetype:techreborn:large_refinery>.addJsonRecipe("large.refinery.general.t15a.leach.iridium", {type: "techreborn:large_refinery",
    time: 512,
    power: 64,
    outputs: [
        {id: "techreborn:cell", count: 4, components: {"techreborn:fluid": "jsonreg:iridium_solution"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "oritech:still_mineral_slurry"}}
    ],
    ingredients: [
        {count: 4, components: {"techreborn:fluid": "oritech:still_sulfuric_acid"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "techreborn:raw_iridium", count: 8},
        {count: 1, components: {"techreborn:fluid": "minecraft:empty"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

<recipetype:techreborn:large_mixer>.addJsonRecipe("large.mixer.general.t15b.precipitate.iridium", {type: "techreborn:large_mixer",
    time: 120,
    power: 32,
    outputs: [
        {id: "jsonreg:iridium_clump", count: 1},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:iridium_solution"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "jsonreg:salt_dust", count: 1}
    ]
});

<recipetype:techreborn:large_mixer>.addJsonRecipe("large.mixer.general.t15c.recrystallize.iridium", {type: "techreborn:large_mixer",
    time: 1600,
    power: 32,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "oritech:still_mineral_slurry"}},
        {id: "jsonreg:iridium_gem", count: 10},
        {id: "techreborn:cell", count: 4}
    ],
    ingredients: [
        {count: 5, components: {"techreborn:fluid": "minecraft:water"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "jsonreg:iridium_clump", count: 10}
    ]
});

<recipetype:techreborn:large_refinery>.addJsonRecipe("large.refinery.general.t15a.leach.uranium", {type: "techreborn:large_refinery",
    time: 512,
    power: 64,
    outputs: [
        {id: "techreborn:cell", count: 4, components: {"techreborn:fluid": "jsonreg:uranium_solution"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "oritech:still_mineral_slurry"}}
    ],
    ingredients: [
        {count: 4, components: {"techreborn:fluid": "oritech:still_sulfuric_acid"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "oritech:raw_uranium", count: 8},
        {count: 1, components: {"techreborn:fluid": "minecraft:empty"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

<recipetype:techreborn:large_mixer>.addJsonRecipe("large.mixer.general.t15b.precipitate.uranium", {type: "techreborn:large_mixer",
    time: 120,
    power: 32,
    outputs: [
        {id: "jsonreg:uranium_clump", count: 1},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:uranium_solution"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "jsonreg:salt_dust", count: 1}
    ]
});

<recipetype:techreborn:large_mixer>.addJsonRecipe("large.mixer.general.t15c.recrystallize.uranium", {type: "techreborn:large_mixer",
    time: 1600,
    power: 32,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "oritech:still_mineral_slurry"}},
        {id: "jsonreg:uranium_gem", count: 10},
        {id: "techreborn:cell", count: 4}
    ],
    ingredients: [
        {count: 5, components: {"techreborn:fluid": "minecraft:water"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "jsonreg:uranium_clump", count: 10}
    ]
});

<recipetype:techreborn:large_refinery>.addJsonRecipe("large.refinery.general.t15a.leach.aluminum", {type: "techreborn:large_refinery",
    time: 512,
    power: 64,
    outputs: [
        {id: "techreborn:cell", count: 4, components: {"techreborn:fluid": "jsonreg:aluminum_solution"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "oritech:still_mineral_slurry"}}
    ],
    ingredients: [
        {count: 4, components: {"techreborn:fluid": "oritech:still_sulfuric_acid"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {tag: "c:ores/bauxite", count: 4},
        {count: 1, components: {"techreborn:fluid": "minecraft:empty"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

<recipetype:techreborn:large_mixer>.addJsonRecipe("large.mixer.general.t15b.precipitate.aluminum", {type: "techreborn:large_mixer",
    time: 120,
    power: 32,
    outputs: [
        {id: "jsonreg:aluminum_clump", count: 1},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:aluminum_solution"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "jsonreg:salt_dust", count: 1}
    ]
});

<recipetype:techreborn:large_mixer>.addJsonRecipe("large.mixer.general.t15c.recrystallize.aluminum", {type: "techreborn:large_mixer",
    time: 1600,
    power: 32,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "oritech:still_mineral_slurry"}},
        {id: "jsonreg:aluminum_gem", count: 10},
        {id: "techreborn:cell", count: 4}
    ],
    ingredients: [
        {count: 5, components: {"techreborn:fluid": "minecraft:water"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "jsonreg:aluminum_clump", count: 10}
    ]
});

<recipetype:techreborn:large_refinery>.addJsonRecipe("large.refinery.general.t15a.leach.galena", {type: "techreborn:large_refinery",
    time: 512,
    power: 64,
    outputs: [
        {id: "techreborn:cell", count: 4, components: {"techreborn:fluid": "jsonreg:galena_solution"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "oritech:still_mineral_slurry"}}
    ],
    ingredients: [
        {count: 4, components: {"techreborn:fluid": "oritech:still_sulfuric_acid"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {tag: "c:ores/galena", count: 4},
        {count: 1, components: {"techreborn:fluid": "minecraft:empty"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

<recipetype:techreborn:large_mixer>.addJsonRecipe("large.mixer.general.t15b.precipitate.galena", {type: "techreborn:large_mixer",
    time: 120,
    power: 32,
    outputs: [
        {id: "jsonreg:galena_clump", count: 1},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:galena_solution"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "jsonreg:salt_dust", count: 1}
    ]
});

<recipetype:techreborn:large_mixer>.addJsonRecipe("large.mixer.general.t15c.recrystallize.galena", {type: "techreborn:large_mixer",
    time: 1600,
    power: 32,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "oritech:still_mineral_slurry"}},
        {id: "jsonreg:galena_gem", count: 10},
        {id: "techreborn:cell", count: 4}
    ],
    ingredients: [
        {count: 5, components: {"techreborn:fluid": "minecraft:water"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "jsonreg:galena_clump", count: 10}
    ]
});

<recipetype:techreborn:large_refinery>.addJsonRecipe("large.refinery.general.t15a.leach.sphalerite", {type: "techreborn:large_refinery",
    time: 512,
    power: 64,
    outputs: [
        {id: "techreborn:cell", count: 4, components: {"techreborn:fluid": "jsonreg:sphalerite_solution"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "oritech:still_mineral_slurry"}}
    ],
    ingredients: [
        {count: 4, components: {"techreborn:fluid": "oritech:still_sulfuric_acid"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {tag: "c:ores/sphalerite", count: 4},
        {count: 1, components: {"techreborn:fluid": "minecraft:empty"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

<recipetype:techreborn:large_mixer>.addJsonRecipe("large.mixer.general.t15b.precipitate.sphalerite", {type: "techreborn:large_mixer",
    time: 120,
    power: 32,
    outputs: [
        {id: "jsonreg:sphalerite_clump", count: 1},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:sphalerite_solution"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "jsonreg:salt_dust", count: 1}
    ]
});

<recipetype:techreborn:large_mixer>.addJsonRecipe("large.mixer.general.t15c.recrystallize.sphalerite", {type: "techreborn:large_mixer",
    time: 1600,
    power: 32,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "oritech:still_mineral_slurry"}},
        {id: "jsonreg:sphalerite_gem", count: 10},
        {id: "techreborn:cell", count: 4}
    ],
    ingredients: [
        {count: 5, components: {"techreborn:fluid": "minecraft:water"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "jsonreg:sphalerite_clump", count: 10}
    ]
});

<recipetype:techreborn:large_refinery>.addJsonRecipe("large.refinery.general.t15a.leach.cinnabar", {type: "techreborn:large_refinery",
    time: 512,
    power: 64,
    outputs: [
        {id: "techreborn:cell", count: 4, components: {"techreborn:fluid": "jsonreg:cinnabar_solution"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "oritech:still_mineral_slurry"}}
    ],
    ingredients: [
        {count: 4, components: {"techreborn:fluid": "oritech:still_sulfuric_acid"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {tag: "c:ores/cinnabar", count: 4},
        {count: 1, components: {"techreborn:fluid": "minecraft:empty"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

<recipetype:techreborn:large_mixer>.addJsonRecipe("large.mixer.general.t15b.precipitate.cinnabar", {type: "techreborn:large_mixer",
    time: 120,
    power: 32,
    outputs: [
        {id: "jsonreg:cinnabar_clump", count: 1},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:cinnabar_solution"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "jsonreg:salt_dust", count: 1}
    ]
});

<recipetype:techreborn:large_mixer>.addJsonRecipe("large.mixer.general.t15c.recrystallize.cinnabar", {type: "techreborn:large_mixer",
    time: 1600,
    power: 32,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "oritech:still_mineral_slurry"}},
        {id: "jsonreg:cinnabar_gem", count: 10},
        {id: "techreborn:cell", count: 4}
    ],
    ingredients: [
        {count: 5, components: {"techreborn:fluid": "minecraft:water"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "jsonreg:cinnabar_clump", count: 10}
    ]
});

<recipetype:techreborn:large_refinery>.addJsonRecipe("large.refinery.general.t15a.leach.pyrite", {type: "techreborn:large_refinery",
    time: 512,
    power: 64,
    outputs: [
        {id: "techreborn:cell", count: 4, components: {"techreborn:fluid": "jsonreg:pyrite_solution"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "oritech:still_mineral_slurry"}}
    ],
    ingredients: [
        {count: 4, components: {"techreborn:fluid": "oritech:still_sulfuric_acid"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {tag: "c:ores/pyrite", count: 4},
        {count: 1, components: {"techreborn:fluid": "minecraft:empty"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

<recipetype:techreborn:large_mixer>.addJsonRecipe("large.mixer.general.t15b.precipitate.pyrite", {type: "techreborn:large_mixer",
    time: 120,
    power: 32,
    outputs: [
        {id: "jsonreg:pyrite_clump", count: 1},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:pyrite_solution"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "jsonreg:salt_dust", count: 1}
    ]
});

<recipetype:techreborn:large_mixer>.addJsonRecipe("large.mixer.general.t15c.recrystallize.pyrite", {type: "techreborn:large_mixer",
    time: 1600,
    power: 32,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "oritech:still_mineral_slurry"}},
        {id: "jsonreg:pyrite_gem", count: 10},
        {id: "techreborn:cell", count: 4}
    ],
    ingredients: [
        {count: 5, components: {"techreborn:fluid": "minecraft:water"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "jsonreg:pyrite_clump", count: 10}
    ]
});

<recipetype:techreborn:large_refinery>.addJsonRecipe("large.refinery.general.t15a.leach.sodalite", {type: "techreborn:large_refinery",
    time: 512,
    power: 64,
    outputs: [
        {id: "techreborn:cell", count: 4, components: {"techreborn:fluid": "jsonreg:sodalite_solution"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "oritech:still_mineral_slurry"}}
    ],
    ingredients: [
        {count: 4, components: {"techreborn:fluid": "oritech:still_sulfuric_acid"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {tag: "c:ores/sodalite", count: 4},
        {count: 1, components: {"techreborn:fluid": "minecraft:empty"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

<recipetype:techreborn:large_mixer>.addJsonRecipe("large.mixer.general.t15b.precipitate.sodalite", {type: "techreborn:large_mixer",
    time: 120,
    power: 32,
    outputs: [
        {id: "jsonreg:sodalite_clump", count: 1},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:sodalite_solution"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "jsonreg:salt_dust", count: 1}
    ]
});

<recipetype:techreborn:large_mixer>.addJsonRecipe("large.mixer.general.t15c.recrystallize.sodalite", {type: "techreborn:large_mixer",
    time: 1600,
    power: 32,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "oritech:still_mineral_slurry"}},
        {id: "jsonreg:sodalite_gem", count: 10},
        {id: "techreborn:cell", count: 4}
    ],
    ingredients: [
        {count: 5, components: {"techreborn:fluid": "minecraft:water"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "jsonreg:sodalite_clump", count: 10}
    ]
});

<recipetype:techreborn:large_refinery>.addJsonRecipe("large.refinery.general.t15a.leach.fluorite", {type: "techreborn:large_refinery",
    time: 512,
    power: 64,
    outputs: [
        {id: "techreborn:cell", count: 4, components: {"techreborn:fluid": "jsonreg:fluorite_solution"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "oritech:still_mineral_slurry"}}
    ],
    ingredients: [
        {count: 4, components: {"techreborn:fluid": "oritech:still_sulfuric_acid"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "jsonreg:nether_fluorite_ore", count: 4},
        {count: 1, components: {"techreborn:fluid": "minecraft:empty"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

<recipetype:techreborn:large_mixer>.addJsonRecipe("large.mixer.general.t15b.precipitate.fluorite", {type: "techreborn:large_mixer",
    time: 120,
    power: 32,
    outputs: [
        {id: "jsonreg:fluorite_clump", count: 1},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:fluorite_solution"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "jsonreg:salt_dust", count: 1}
    ]
});

<recipetype:techreborn:large_mixer>.addJsonRecipe("large.mixer.general.t15c.recrystallize.fluorite", {type: "techreborn:large_mixer",
    time: 1600,
    power: 32,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "oritech:still_mineral_slurry"}},
        {id: "jsonreg:fluorite_gem", count: 10},
        {id: "techreborn:cell", count: 4}
    ],
    ingredients: [
        {count: 5, components: {"techreborn:fluid": "minecraft:water"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "jsonreg:fluorite_clump", count: 10}
    ]
});

<recipetype:techreborn:large_refinery>.addJsonRecipe("large.refinery.oil.process.or.desalt.crude.tr", {type: "techreborn:large_refinery",
    time: 160,
    power: 64,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:desalted_crude"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:saline_water"}}
    ],
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "techreborn:oil"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 1, components: {"techreborn:fluid": "minecraft:empty"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

<recipetype:techreborn:large_refinery>.addJsonRecipe("large.refinery.oil.process.or.desalt.crude.or", {type: "techreborn:large_refinery",
    time: 160,
    power: 64,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:desalted_crude"}},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:saline_water"}}
    ],
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "oritech:still_oil"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 1, components: {"techreborn:fluid": "minecraft:empty"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

<recipetype:techreborn:large_refinery>.addJsonRecipe("large.refinery.oil.process.or.vacuum_distillation", {type: "techreborn:large_refinery",
    time: 1280,
    power: 64,
    outputs: [
        {id: "techreborn:cell", count: 3, components: {"techreborn:fluid": "jsonreg:vacuum_diesel"}},
        {id: "techreborn:cell", count: 5, components: {"techreborn:fluid": "jsonreg:vacuum_residue"}}
    ],
    ingredients: [
        {count: 8, components: {"techreborn:fluid": "jsonreg:atmospheric_residue"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

<recipetype:techreborn:large_refinery>.addJsonRecipe("large.refinery.oil.process.or.coking", {type: "techreborn:large_refinery",
    time: 800,
    power: 64,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:coke_gas"}},
        {id: "techreborn:cell", count: 2, components: {"techreborn:fluid": "jsonreg:coker_light_oil"}},
        {id: "jsonreg:petroleum_coke", count: 5},
        {id: "techreborn:cell", count: 2}
    ],
    ingredients: [
        {count: 5, components: {"techreborn:fluid": "jsonreg:vacuum_residue"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

<recipetype:techreborn:large_refinery>.addJsonRecipe("large.refinery.oil.process.or.nitric_acid", {type: "techreborn:large_refinery",
    time: 160,
    power: 64,
    outputs: [
        {id: "techreborn:cell", count: 1},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:nitric_acid"}}
    ],
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:nitrous_gas"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 1, components: {"techreborn:fluid": "minecraft:water"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

<recipetype:techreborn:large_mixer>.addJsonRecipe("large.mixer.oil.other.or.centrifuge_oilsand_low", {type: "techreborn:large_mixer",
    time: 128,
    power: 32,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "techreborn:oil"}},
        {id: "minecraft:sand", count: 2}
    ],
    ingredients: [
        {item: "jsonreg:oil_sand_dust", count: 2},
        {count: 1, components: {"techreborn:fluid": "minecraft:empty"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

<recipetype:techreborn:large_refinery>.addJsonRecipe("large.refinery.nqdh.0b.leach_enriched_naquadah_ore", {type: "techreborn:large_refinery",
    time: 128,
    power: 64,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:impure_enriched_naquadah_solution"}}
    ],
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "oritech:still_sulfuric_acid"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "jsonreg:end_enriched_naquadah_ore", count: 2}
    ]
});

<recipetype:techreborn:large_refinery>.addJsonRecipe("large.refinery.nqdh.3.refinery", {type: "techreborn:large_refinery",
    time: 128,
    power: 64,
    outputs: [
        {id: "techreborn:cell", count: 2, components: {"techreborn:fluid": "jsonreg:impure_enriched_naquadah_solution"}}
    ],
    ingredients: [
        {count: 2, components: {"techreborn:fluid": "oritech:still_sulfuric_acid"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "jsonreg:impure_enriched_naquadah_dust", count: 10}
    ]
});

<recipetype:techreborn:large_refinery>.addJsonRecipe("large.refinery.nqdh.5a.refinery2", {type: "techreborn:large_refinery",
    time: 80,
    power: 64,
    outputs: [
        {id: "techreborn:cell", count: 1},
        {id: "techreborn:cell", count: 3, components: {"techreborn:fluid": "jsonreg:acidic_enriched_naquadah_solution"}}
    ],
    ingredients: [
        {count: 2, components: {"techreborn:fluid": "oritech:still_sulfuric_acid"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 1, components: {"techreborn:fluid": "jsonreg:enriched_naquadah_solution"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 1, components: {"techreborn:fluid": "minecraft:empty"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

<recipetype:techreborn:large_refinery>.addJsonRecipe("large.refinery.nqdria.3.refinery", {type: "techreborn:large_refinery",
    time: 480,
    power: 64,
    outputs: [
        {id: "techreborn:cell", count: 8, components: {"techreborn:fluid": "jsonreg:crude_naquadria_acid_solution"}},
        {id: "techreborn:cell", count: 2, components: {"techreborn:fluid": "jsonreg:insoluble_slurry"}}
    ],
    ingredients: [
        {count: 10, components: {"techreborn:fluid": "jsonreg:hydrofluoric_acid"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "jsonreg:refined_crushed_naquadria_ore", count: 10}
    ]
});

<recipetype:techreborn:large_refinery>.addJsonRecipe("large.refinery.nqdria.5.refinery", {type: "techreborn:large_refinery",
    time: 400,
    power: 64,
    outputs: [
        {id: "techreborn:cell", count: 3, components: {"techreborn:fluid": "jsonreg:ammonium_fluoride_waste"}},
        {id: "jsonreg:naquadria_hydroxide_precipitate", count: 1},
        {id: "techreborn:cell", count: 3}
    ],
    ingredients: [
        {count: 2, components: {"techreborn:fluid": "jsonreg:purified_naquadria_acid_solution"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 4, components: {"techreborn:fluid": "jsonreg:ammonia_solution"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

<recipetype:techreborn:large_refinery>.addJsonRecipe("large.refinery.t2.oritech.refinery/siliconwashing", {type: "techreborn:large_refinery",
    time: 128,
    power: 64,
    outputs: [
        {id: "jsonreg:silicon_boule", count: 1}
    ],
    ingredients: [
        {item: "oritech:silicon", count: 1}
    ]
});

<recipetype:techreborn:large_mixer>.addJsonRecipe("large.mixer.t2.oritech.centrifuge/uu", {type: "techreborn:large_mixer",
    time: 640,
    power: 32,
    outputs: [
        {id: "techreborn:uu_matter", count: 4},
        {id: "techreborn:cell", count: 1}
    ],
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "oritech:still_strange_matter"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {item: "jsonreg:naquadah_rod", count: 1}
    ]
});

<recipetype:techreborn:large_refinery>.addJsonRecipe("large.refinery.water.0a.or.reverse_osmosis", {type: "techreborn:large_refinery",
    time: 240,
    power: 64,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "homeostatic:purified_water"}}
    ],
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "minecraft:water"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});
