// ==========================================================================
// 生魂提取线路 —— 把「主世界空气」变成可再生的三种生魂
// ==========================================================================
// 背景：affinity 的三色生魂物质（inert / wise / vicious）原本只能靠打生魂掉落，
//       没有任何配方能产出，是整条魔法线的瓶颈。本线路让生魂可工业化生产。
//
// 设计思路：生魂以痕量形式弥散在空气里，本身没有属性；
//          「用哪种空气去激发它」才决定它变成哪一种生魂。
//          所以上游是一条与属性无关的通用原液线，下游才按空气分流。
//
//   主世界空气 ─鼓泡吸收─► 含魂水 ─浓缩─► 生魂浓缩液 ─活化─► 生魂原液
//                                                                 │
//                        ┌────────────────────────────────────────┤
//                        │  + 主世界空气 ─► 惰性生魂              │
//                        │  + 下界空气   ─► 凶恶生魂              │
//                        └  + 星光空气   ─► 博识生魂 ─────────────┘
//
// 空气来源：集气室 techreborn:gas_collector（t2.zs），按维度产对应空气，
//          主世界档位 5000 mB / 100t = 每秒 1 B，四种空气口径一致。
//
// ---------------------------------------------------------------------------
// 账本（每 2 个生魂）
//   8B 主世界空气 + 2B 水 ──200t/64──► 10B 含魂水
//   10B 含魂水            ──400t/64──► 1B 生魂浓缩液 + 9B 氮气（放空）
//   1B 浓缩液 + 2 闪烁无烟煤 ──400t/128─► 1B 生魂原液
//   1B 生魂原液 + 4B 对应空气 ──200t/512─► 2 生魂
//
//   合计每 2 个生魂：12B 空气（8 主世界 + 4 对应）、2B 水、2 闪烁无烟煤
//   耗电 192,000 EU；集气室按 1B/s 供 12B 需 240t ≈ 61,440 EU
//   合计 ≈ 253,000 EU / 2 个生魂 ≈ 127,000 EU / 个
//
// 产能：各机器只放一台时，瓶颈在第二、三步（都是 400t 出 2 个生魂）≈ 6 个/分钟。
//      集气室 1B/s 的空气够喂到 ≈ 10 个/分钟，再往上就得并第二、三步的机器。
//
// 注意：浓缩步刻意把 9B 抽出来的气体放成 techreborn:nitrogen 而不是主世界空气。
//      如果放回主世界空气，第一步只需 8B 而浓缩步能吐回 9B，就形成净增空气的
//      永动循环，整条集气室会被架空。
// ==========================================================================

// ========== 第一步：鼓泡吸收 ==========
// 把大量主世界空气鼓进水里，让痕量生魂溶进水相。
// 体积守恒（8B + 2B = 10B），不增不减，只是换了载体。
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("wisp.1.absorb", {type: "techreborn:chemical_reactor",
    time: 200,
    power: 64,
    outputs: [
        {id: "techreborn:cell", count: 10, components: {"techreborn:fluid": "jsonreg:wisp_water"}}
    ],
    ingredients: [
        {count: 8, components: {"techreborn:fluid": "jsonreg:low_oxygen_nitrogen"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 2, components: {"techreborn:fluid": "minecraft:water"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// ========== 第二步：浓缩 ==========
// 离心把 90% 的载气甩掉（放空为氮气），留下一小股浓液。
// 这一步是全线的收率瓶颈：10B 进，1B 出。
<recipetype:techreborn:centrifuge>.addJsonRecipe("wisp.2.concentrate", {type: "techreborn:centrifuge",
    time: 400,
    power: 64,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:wisp_concentrate"}},
        {id: "techreborn:cell", count: 9, components: {"techreborn:fluid": "techreborn:nitrogen"}}
    ],
    ingredients: [
        {count: 10, components: {"techreborn:fluid": "jsonreg:wisp_water"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// ========== 第三步：活化 ==========
// 用闪烁无烟煤混合物当载体把生魂「固定」下来，否则它会在管道里自行衰变掉。
// 这一步之后生魂原液就是稳定的、与属性无关的半成品。
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("wisp.3.activate", {type: "techreborn:chemical_reactor",
    time: 400,
    power: 128,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:wisp_raw_liquid"}}
    ],
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:wisp_concentrate"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 2, item: "affinity:scintillant_anthracite_blend"}
    ]
});

// ========== 第四步：塑魂（按空气分流）==========
// 生魂原液本身无属性，用对应维度的空气去「激发」才决定它凝成哪一种生魂。
// 末地空气刻意不参与（末地已有它自己的定位，避免再来一条分流）。
// 5 个罐进 5 个空罐出，罐子守恒。

// 主世界空气 → 惰性
<recipetype:techreborn:large_chemical_reactor>.addJsonRecipe("wisp.4.soul.inert", {type: "techreborn:large_chemical_reactor",
    time: 200,
    power: 512,
    outputs: [
        {id: "affinity:inert_wisp_matter", count: 2},
        {id: "techreborn:cell", count: 5}
    ],
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:wisp_raw_liquid"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 4, components: {"techreborn:fluid": "jsonreg:low_oxygen_nitrogen"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// 下界空气 → 凶恶
<recipetype:techreborn:large_chemical_reactor>.addJsonRecipe("wisp.4.soul.vicious", {type: "techreborn:large_chemical_reactor",
    time: 200,
    power: 512,
    outputs: [
        {id: "affinity:vicious_wisp_matter", count: 2},
        {id: "techreborn:cell", count: 5}
    ],
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:wisp_raw_liquid"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 4, components: {"techreborn:fluid": "jsonreg:nether_air"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// 星光空气 → 博识
<recipetype:techreborn:large_chemical_reactor>.addJsonRecipe("wisp.4.soul.wise", {type: "techreborn:large_chemical_reactor",
    time: 200,
    power: 512,
    outputs: [
        {id: "affinity:wise_wisp_matter", count: 2},
        {id: "techreborn:cell", count: 5}
    ],
    ingredients: [
        {count: 1, components: {"techreborn:fluid": "jsonreg:wisp_raw_liquid"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"},
        {count: 4, components: {"techreborn:fluid": "jsonreg:starlight_air"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});
