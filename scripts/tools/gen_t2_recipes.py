"""生成 T2（工业分离与副产物）配方段，替换 general_ore_process.zs 里的 T2 占位块。

设计前提（用户明确）：**dust 永远是最终产物**，中间产物与加工链条只决定
一个矿石最终能产出多少粉。因此 T2 不是"比 dust 更高一级"，而是提高产粉量。

链条：
  T2a 浓缩化  TR 化反(2进2出)  X碎块 ×3 + 硫酸单元 → X浓缩物 ×1 + 空单元
  T2b 高纯粉  TR 工业磨粉机     X浓缩物 + 水|汞|过硫酸钠 → X粉 ×N + 0~2 副产

三分支**互斥**（不可叠加最大倍率），按 plan §Tier 2：
  水        粉 ×5                     —— 主产物最高
  汞        粉 ×4 + 副产 ×1            —— 兼顾
  过硫酸钠  粉 ×3 + 副产 ×2            —— 副产最多（与 TR 既有工艺一致：过硫酸钠的价值是改副产结构）

产出阶梯核账（每 1 个矿石）：
  T1   粗矿 ×2
  T1.5 石 → 粉 ×3                      3 倍
  T2   碎块 ×3 → 浓缩物 ×1 → 粉 ×5      5 倍（水支路）
"""
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
TARGET = ROOT / "scripts/general_ore_process.zs"

# mineral, 中文, clump, concentrate, dust, 副产1, 副产2(可 None)
M = [
    ("copper", "铜", 'oritech:copper_clump', 'jsonreg:copper_concentrate', 'oritech:copper_dust',
     'minecraft:raw_gold', 'techreborn:nickel_dust'),
    ("gold", "金", 'oritech:gold_clump', 'jsonreg:gold_concentrate', 'oritech:gold_dust',
     'minecraft:raw_copper', 'techreborn:nickel_dust'),
    ("iron", "铁", 'oritech:iron_clump', 'jsonreg:iron_concentrate', 'oritech:iron_dust',
     'techreborn:nickel_dust', 'techreborn:tin_nugget'),
    ("nickel", "镍", 'oritech:nickel_clump', 'jsonreg:nickel_concentrate', 'techreborn:nickel_dust',
     'techreborn:platinum_dust', 'minecraft:raw_copper'),
    ("platinum", "铂", 'oritech:platinum_clump', 'jsonreg:platinum_concentrate', 'techreborn:platinum_dust',
     'techreborn:nickel_dust', 'techreborn:iridium_nugget'),
    ("lead", "铅", 'jsonreg:lead_clump', 'jsonreg:lead_concentrate', 'jsonreg:lead_dust',
     'techreborn:galena_small_dust', 'techreborn:sulfur_dust'),
    ("silver", "银", 'jsonreg:silver_clump', 'jsonreg:silver_concentrate', 'jsonreg:silver_dust',
     'techreborn:galena_small_dust', 'techreborn:sulfur_dust'),
    ("tin", "锡", 'jsonreg:tin_clump', 'jsonreg:tin_concentrate', 'jsonreg:tin_dust',
     'minecraft:iron_nugget', 'techreborn:zinc_dust'),
    ("tungsten", "钨", 'jsonreg:tungsten_clump', 'jsonreg:tungsten_concentrate', 'jsonreg:tungsten_dust',
     'minecraft:iron_nugget', 'techreborn:manganese_small_dust'),
    ("iridium", "铱", 'jsonreg:iridium_clump', 'jsonreg:iridium_concentrate', 'jsonreg:iridium_dust',
     'techreborn:platinum_small_dust', None),
    ("uranium", "铀", 'jsonreg:uranium_clump', 'jsonreg:uranium_concentrate', 'oritech:uranium_dust',
     'techreborn:raw_lead', None),          # 铀铅共生：放射成因铅，地质上成立；不产钚
    ("aluminum", "铝", 'jsonreg:aluminum_clump', 'jsonreg:aluminum_concentrate', 'techreborn:aluminum_dust',
     'oritech:iron_dust', 'jsonreg:gallium_dust'),
    ("galena", "方铅", 'jsonreg:galena_clump', 'jsonreg:galena_concentrate', 'techreborn:galena_dust',
     'techreborn:sulfur_dust', 'techreborn:raw_silver'),
    ("sphalerite", "闪锌", 'jsonreg:sphalerite_clump', 'jsonreg:sphalerite_concentrate', 'techreborn:sphalerite_dust',
     'techreborn:sulfur_dust', 'techreborn:zinc_dust'),
    ("cinnabar", "朱砂", 'jsonreg:cinnabar_clump', 'jsonreg:cinnabar_concentrate', 'techreborn:cinnabar_dust',
     'techreborn:sulfur_dust', None),
    ("pyrite", "黄铁", 'jsonreg:pyrite_clump', 'jsonreg:pyrite_concentrate', 'techreborn:pyrite_dust',
     'techreborn:sulfur_dust', None),
    ("sodalite", "方钠", 'jsonreg:sodalite_clump', 'jsonreg:sodalite_concentrate', 'techreborn:sodalite_dust',
     'techreborn:aluminum_dust', None),
]

FLUIDS = [("water", "minecraft:water", 5, 0),          # 名称, 流体, 主产物数, 副产数
          ("mercury", "techreborn:mercury", 4, 1),
          ("persulfate", "techreborn:sodium_persulfate", 3, 2)]

L = []
A = L.append
A("// ============================================================")
A("// T2：工业分离与副产物")
A("// ============================================================")
A("// 前提：**dust 是永远的最终产物** —— 中间产物与加工链条只决定一个矿石最终能产出多少粉。")
A("// 所以 T2 不是「比 dust 更高一级的产物」，而是把产粉量从 T1.5 的 3 倍推到 5 倍。")
A("//")
A("//   T2a 浓缩化  TR 化反(2进2出)  X碎块 ×1 + 硫酸单元 → X浓缩物 ×1 + 空单元")
A("//   T2b 高纯粉  TR 工业磨粉机     X浓缩物 + 流体 → X粉 ×N + 0~2 副产")
A("//")
A("// 注：T2a 在 **TR 化反**上，不受「OR 离心机只支持 1 输入」的限制；")
A("//     碎块取 1 个，使 1 矿石 → 1 碎块 → 1 浓缩物 → 5 粉（水支路）成立。")
A("//")
A("// 三条流体分支**互斥**，不可叠加最大倍率：")
A("//   水       粉 ×5              主产物最高")
A("//   汞       粉 ×4 + 副产 ×1     兼顾")
A("//   过硫酸钠 粉 ×3 + 副产 ×2     副产最多（与 TR 既有工艺一致：")
A("//                                过硫酸钠的价值是改变副产结构而非拉高主产物）")
A("//")
A("// 产出阶梯（每 1 个矿石）：T1 粗矿 ×2 → T1.5 石 → 粉 ×3 → T2 水支路 粉 ×5")
A("//")
A("// 副产依据（每种矿物 0~2 类，均有矿物学理由）：")
A("//   铜→金/镍   金→铜/镍   铁→镍/锡   镍→铂/铜   铂→镍/铱   铱→铂")
A("//   铅→方铅/硫 银→方铅/硫 锡→铁/锌   钨→铁/锰   铀→铅（放射成因，**不产钚**）")
A("//   铝→铁/镓   方铅→硫/银 闪锌→硫/锌 朱砂→硫    黄铁→硫     方钠→铝")
A("")
for key, cn, clump, con, dust, by1, by2 in M:
    A(f"// ---------- {cn} ----------")
    A(f'<recipetype:techreborn:chemical_reactor>.addJsonRecipe("general.t2a.concentrate.{key}", {{type: "techreborn:chemical_reactor",')
    A(f'    time: 400,')
    A(f'    power: 128,')
    A(f'    outputs: [')
    A(f'        {{id: "{con}", count: 1}},')
    A(f'        {{id: "techreborn:cell", count: 1}}')
    A(f'    ],')
    A(f'    ingredients: [')
    A(f'        {{item: "{clump}", count: 1}},')
    A(f'        {{count: 1, components: {{"techreborn:fluid": "oritech:still_sulfuric_acid"}}, base: {{item: "techreborn:cell"}}, "fabric:type": "fabric:components"}}')
    A(f'    ]')
    A(f'}});')
    for fname, fluid, n_main, n_by in FLUIDS:
        outs = [f'        {{id: "{dust}", count: {n_main}}}']
        if n_by >= 1 and by1:
            outs.append(f'        {{id: "{by1}", count: 2}}')
        if n_by >= 2 and by2:
            outs.append(f'        {{id: "{by2}", count: 1}}')
        body = ",\n".join(outs)
        A(f'<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t2b.{fname}.{key}", {{type: "techreborn:industrial_grinder",')
        A(f'    outputs: [')
        A(body)
        A(f'    ],')
        A(f'    time: 200,')
        A(f'    power: 128,')
        A(f'    fluid: {{fluid: {{fluid: "{fluid}"}}, amount: {{value: 81000}}}},')
        A(f'    ingredients: [{{item: "{con}"}}]')
        A(f'}});')
    A("")
section = "\n".join(L)

# ---------- T2.3：魔法催化 ----------
L23 = []
B = L23.append
B("// ============================================================")
B("// T2.3：魔法催化（灵魂注入催化剂）")
B("// ============================================================")
B("// 定位：**强化 Tier 2 的既有步骤**，不新增并行倍增链。")
B("//")
B("// 为什么是「第四个分支」而不是「给旧分支加催化剂」：")
B("//   TR 工业磨粉机只有 **1 个流体 + 1 个物品**输入槽，催化剂只能**取代**")
B("//   水 / 汞 / 过硫酸钠，物理上无法叠加 ——")
B("//   机器的槽位限制本身就天然保证了 plan 里「不叠加最大倍率」这条要求。")
B("//")
B("// 四条分支互斥（同一批浓缩物只能选一条）：")
B("//   水        粉 ×5")
B("//   汞        粉 ×4 + 副产 ×1")
B("//   过硫酸钠   粉 ×3 + 副产 ×2")
B("//   催化剂    粉 ×6 + 副产 ×2      ← 本层；产出最高，代价在魔法侧")
B("//")
B("// 产出核账：1 矿石 → 碎块 ×1 → 浓缩物 ×1 → 粉 ×6  ⇒ **6 倍**（T2 水支路为 5 倍）")
B("// 完整阶梯：T1b 2×  <  T1.5 3×  <  T2 5×  <  T2.3 6×")
B("//")
B("// 门槛不在矿物侧而在魔法侧：jsonreg:soul_injection_catalyst 由 etst&magic.zs 的")
B("//   `etst.tr.lcr/soul_injection` 生产（需 永恒星光以太 + Affinity 结晶尘），")
B("//   属 T2.3 魔法线，故不会让基础矿处提前起飞。")
B("//")
B("// 催化剂按**消耗品**计价：每批吃 1 单元（空单元归还），不把催化剂价值算进产出。")
B("")
for key, cn, clump, con, dust, by1, by2 in M:
    outs = [f'        {{id: "{dust}", count: 6}}']
    if by1:
        outs.append(f'        {{id: "{by1}", count: 2}}')
    if by2:
        outs.append(f'        {{id: "{by2}", count: 1}}')
    B(f'<recipetype:techreborn:industrial_grinder>.addJsonRecipe("general.t23.catalyzed.{key}", {{type: "techreborn:industrial_grinder",')
    B(f'    outputs: [')
    B(",\n".join(outs))
    B(f'    ],')
    B(f'    time: 200,')
    B(f'    power: 256,')
    B(f'    fluid: {{fluid: {{fluid: "jsonreg:soul_injection_catalyst"}}, amount: {{value: 81000}}}},')
    B(f'    ingredients: [{{item: "{con}"}}]')
    B(f'}});')
B("")
section23 = "\n".join(L23)

text = TARGET.read_text(encoding="utf-8")
s = text.index("// ============================================================\n// T2：")
# T2.3 是文件最后一段，直接截到末尾（旧占位段一并丢弃）
e = text.index("// ============================================================\n// T2.3：")
text = text[:s] + section + "\n" + section23
TARGET.write_text(text, encoding="utf-8")

print(f"T2 写入 {len(M)} 种金属 × (1 浓缩 + {len(FLUIDS)} 分支) = {len(M)*(1+len(FLUIDS))} 条配方")
print(f"T2.3 写入 {len(M)} 条催化高纯粉配方")
print(f"文件行数: {len(text.splitlines())}")
