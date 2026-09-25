"""重写 general_ore_process.zs 的两段：

1) T1 清退块 —— 补全为**全部 88 条**旧的矿石配方（原先只清退了小磨粉侧 46 条，
   TR 工业磨粉机的 39 条「矿石直接出粉/粗矿 + 副产」仍在，会绕过新链）。
2) T1.5 —— 重调产出并把终点改为 dust：

   a 浸出      OR 精炼厂    粗矿 ×2 + 硫酸 → X盐溶液[主] + 矿物浆液[副]
   b 选择性析出 OR 流体离心  X盐溶液(1桶) + 盐粉 ×1 → X碎块 ×1
   c 重结晶    OR 流体离心  X碎块 ×1 + 硫酸 → X石(gem) ×1 + 矿物浆液
   d 石磨粉    TR 磨粉机    X石 ×1 → X高纯粉(dust) ×3      ← 1 输出槽，安全

   **OR 离心机只支持大小为 1 的输入**（物品 count 与流体桶数都必须是 1），
   所以 b/c 两步的进料永远是 1 桶溶液 / 1 个碎块，倍率只能靠**产出侧**做文章：
   d 步 1 石 → 3 粉 就是唯一的倍增点。

   产出核账（每 1 个矿石）：1 矿 → T1 粗矿 ×2 → 1 批浸出 → 1 碎块 → 1 石 → 3 粉
   ⇒ **3 倍**。

   浓缩物（jsonreg:*_concentrate）已从 T1.5 移除，留待 T2 作为 dust 之上的进一步提纯产物。
"""
import json
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import fuel_ledger as L

ROOT = Path(__file__).resolve().parents[2]
TARGET = ROOT / "scripts/general_ore_process.zs"

# mineral, 中文, T1 粗矿/初级料, clump, gem, 终端 dust
M = [
    ("copper", "铜", 'minecraft:raw_copper', 'oritech:copper_clump', 'oritech:copper_gem', 'oritech:copper_dust'),
    ("gold", "金", 'minecraft:raw_gold', 'oritech:gold_clump', 'oritech:gold_gem', 'oritech:gold_dust'),
    ("iron", "铁", 'minecraft:raw_iron', 'oritech:iron_clump', 'oritech:iron_gem', 'oritech:iron_dust'),
    ("nickel", "镍", 'oritech:raw_nickel', 'oritech:nickel_clump', 'oritech:nickel_gem', 'techreborn:nickel_dust'),
    ("platinum", "铂", 'oritech:raw_platinum', 'oritech:platinum_clump', 'oritech:platinum_gem', 'techreborn:platinum_dust'),
    ("lead", "铅", 'techreborn:raw_lead', 'jsonreg:lead_clump', 'jsonreg:lead_gem', 'jsonreg:lead_dust'),
    ("silver", "银", 'techreborn:raw_silver', 'jsonreg:silver_clump', 'jsonreg:silver_gem', 'jsonreg:silver_dust'),
    ("tin", "锡", 'techreborn:raw_tin', 'jsonreg:tin_clump', 'jsonreg:tin_gem', 'jsonreg:tin_dust'),
    ("tungsten", "钨", 'techreborn:raw_tungsten', 'jsonreg:tungsten_clump', 'jsonreg:tungsten_gem', 'jsonreg:tungsten_dust'),
    ("iridium", "铱", 'techreborn:raw_iridium', 'jsonreg:iridium_clump', 'jsonreg:iridium_gem', 'jsonreg:iridium_dust'),
    ("uranium", "铀", 'oritech:raw_uranium', 'jsonreg:uranium_clump', 'jsonreg:uranium_gem', 'oritech:uranium_dust'),
]

# 这 6 种在原 mod 里没有 raw 形态，T1 的产物就是其 *_dust（最终产物）。
# 因此**不能拿 dust 去浸出**（那是把最终产物当粗矿用），T1.5a 改用原矿直接研磨。
ORE_INPUT = {
    "aluminum": ('c:ores/bauxite', 'tag'),
    "galena": ('c:ores/galena', 'tag'),
    "sphalerite": ('c:ores/sphalerite', 'tag'),
    "cinnabar": ('c:ores/cinnabar', 'tag'),
    "pyrite": ('c:ores/pyrite', 'tag'),
    "sodalite": ('c:ores/sodalite', 'tag'),
}
# 移除原先以 dust 为粗矿的 6 条定义，改由 ORE_INPUT 提供
M = [m for m in M if m[0] not in ORE_INPUT]
for key, (tag, kind) in ORE_INPUT.items():
    CN = {"aluminum": "铝", "galena": "方铅", "sphalerite": "闪锌",
          "cinnabar": "朱砂", "pyrite": "黄铁", "sodalite": "方钠"}[key]
    DUST = {"aluminum": "techreborn:aluminum_dust", "galena": "techreborn:galena_dust",
            "sphalerite": "techreborn:sphalerite_dust", "cinnabar": "techreborn:cinnabar_dust",
            "pyrite": "techreborn:pyrite_dust", "sodalite": "techreborn:sodalite_dust"}[key]
    M.append((key, CN, tag, f'jsonreg:{key}_clump', f'jsonreg:{key}_gem', DUST))

# ---------- 1) 读取**冻结的**清退清单 ----------
# ⚠ 不能从 !recipedump.txt 现场枚举清退目标：
#   dump 是「当前生效配方」的快照。一旦脚本里的清退生效、dump 被重新导出，
#   那些旧配方就不在 dump 里了 → 再枚举得到 0 条 → **整段清退丢失**。
#   （2026-09-25 实际踩过一次：dump 从 09-04 更新到 09-25，清退从 142 条变 0 条。）
# 因此清单冻结在 frozen_removals.json，来源是 2026-09-04 的 dump + 下述谓词：
#   机器 ∈ 旧矿处机器集合；输入匹配 ores/raw_materials/clump；排除油砂/金红石/硅岩特殊线；
#   排除 c:raw_materials/dyes/*（那是植物→染料，不是矿处）。
FROZEN = json.loads(
    (Path(__file__).resolve().parent / "frozen_removals.json").read_text(encoding="utf-8"))
removals = sorted((t, n) for t, n in FROZEN)

# ---------- 2) 组装文件 ----------
text = TARGET.read_text(encoding="utf-8")

rem_lines = ["// ============================================================",
             "// T1 清退：旧的矿石入口配方",
             "// ============================================================",
             "// 被清退的是「矿石 → 直接出粉/出粗矿 + 副产」的整条旧入口，共 %d 条。" % len(removals),
             "// 它们的问题：",
             "//   · 绕过 T1.5 的浸出/析出/重结晶工序，矿石一步就变高纯粉或粗矿；",
             "//   · 副产结构由 base mod 决定，与本包「每种矿物 0~2 类有依据副产」冲突；",
             "//   · 两套体系对同一矿石给出不同产物，玩家按机器不同拿到不同东西。",
             "// 下列配方全部由 T1 + T1.5 的新链取代。",
             "// **油砂 / 金红石 / 硅岩系属特殊线，不在清退范围。**",
             ""]
cur = None
for ty, n in removals:
    if ty != cur:
        cur = ty
        rem_lines.append(f"// —— {ty} ——")
    rem_lines.append(f'<recipetype:{ty}>.removeByName("{n}");')
rem_lines.append("")
rem_block = "\n".join(rem_lines)

# ---------- 3) T1.5 ----------
L15 = []
A = L15.append

# ---- T1b：粗矿制粉（早期干法，两台研磨机都有）----
A("// ============================================================")
A("// T1b：粗矿制粉（早期干法路线）")
A("// ============================================================")
A("// 「不搞化学也能出粉」的基础路线：**1 粗矿 → 1 粉**。")
A("//   产出核账：1 矿石 →(T1) 粗矿 ×2 →(T1b) 粉 ×2   ⇒ **2 倍**")
A("//   阶梯关系：T1b 2×  <  T1.5 湿法 3×  <  T2 浓缩 5×")
A("//")
A("// ⚠ 不要写成 `1 粗矿 → 2 粉`：那会让 1 矿石 = 4 粉，直接超过 T1.5 的 3 倍，")
A("//   使整套湿法化学失去意义。")
A("//")
A("// 两台机器都是 1 进 1 出，安全：TR 磨粉机只有 1 个输出槽；OR 粉碎机在本包内也只用单输出")
A("// （其原版 5 条 2 输出的 raw/* 配方已清退，且若移植到 TR 磨粉机会 NPE）。")
A("//")
A("// ⚠ 配方名必须带机器后缀（.tr. / .or.）：CrT 的配方名是**全局唯一**的，")
A("//   两台机器用同名会导致 SynchronizeRecipes 包 duplicate key 报错、客户端连不上服务器。")
A("")
for key, cn, raw, clump, gem, dust in M:
    if raw.startswith("c:"):
        continue                      # 这 6 种没有粗矿形态，T1 直接出粉
    A(f'<recipetype:techreborn:grinder>.addJsonRecipe("general.t1b.grind_raw.tr.{key}", {{type: "techreborn:grinder",')
    A(f'    time: 100, power: 16,')
    A(f'    outputs: [{{id: "{dust}", count: 1}}],')
    A(f'    ingredients: [{{item: "{raw}"}}]')
    A(f'}});')
    A(f'<recipetype:oritech:pulverizer>.addJsonRecipe("general.t1b.grind_raw.or.{key}", {{type: "oritech:pulverizer",')
    A(f'    time: 100,')
    A(f'    results: [{{id: "{dust}", count: 1}}],')
    A(f'    ingredients: [{{item: "{raw}"}}]')
    A(f'}});')
A("")

A("// ============================================================")
A("// T1.5：湿法处理与初级浓缩")
A("// ============================================================")
A("// 每个矿石走五步，浓缩物必须有明确来源：")
A("//   a 浸出      OR 精炼厂    粗矿 ×2 + 硫酸 → X盐溶液[主] + 矿物浆液[副]")
A("//   b 选择性析出 OR 流体离心  X盐溶液(1桶) + 盐粉 ×1 → X碎块 ×1")
A("//   c 重结晶    OR 流体离心  X碎块 ×1 + 硫酸 → X石(gem) ×1 + 矿物浆液")
A("//   d 石磨粉    TR 磨粉机    X石 ×1 → X高纯粉 ×3")
A("//")
A("// ⚠ **OR 离心机只支持大小为 1 的输入**（物品 count 与流体桶数都必须是 1，见 CrTNOTE）。")
A("//   所以 b/c 的进料恒为 1 桶溶液 / 1 个碎块，倍率只能靠产出侧：d 步 1 石 → 3 粉是唯一倍增点。")
A("//   （精炼厂不受此限：naquadah 线在用 count 10/4/2，故 a 步的 粗矿 ×2 安全。）")
A("//")
A("// 产出核账（以 1 个矿石计）：")
A("//   1 矿 --T1--> 粗矿 ×2 --a--> 1 桶盐溶液 --b--> 碎块 ×1 --c--> 石 ×1 --d--> **粉 ×3**")
A("//   ⇒ T1.5 终点为 **3 倍**矿物产出。")
A("//")
A("// 槽位：精炼厂 1流体+1物品→2流体；流体离心 1流体+1物品→1流体+1物品；")
A("//       TR 磨粉机 1 进 1 出（**只有 1 个输出槽，绝不能多输出**）。")
A("// 精炼厂只用 2 个流体输出位：放弃第 3 位会让第 1 位增产，与「浸出率」设定方向一致，")
A("// 且不虚构并不存在的回收液。")
A("//")
A("// 浓缩物（jsonreg:*_concentrate）留待 T2 —— 它是 dust 之上的进一步提纯产物，")
A("// 不在 T1.5 出现。")
A("")
for key, cn, raw, clump, gem, dust in M:
    sol = f"jsonreg:{key}_solution"
    # 有粗矿的用粗矿 ×2；没有粗矿形态的（6 种）直接用原矿 tag ×1
    if raw.startswith("c:"):
        feed = f'{{tag: "{raw}", count: 1}}'
    else:
        feed = f'{{item: "{raw}", count: 2}}'
    A(f"// ---------- {cn} ----------")
    A(f'<recipetype:oritech:refinery>.addJsonRecipe("general.t15a.leach.{key}", {{type: "oritech:refinery",')
    A(f'    results: [],')
    A(f'    fluidOutputs: [')
    A(f'        {{fluid: "{sol}", amount: 81000}},')
    A(f'        {{fluid: "oritech:still_mineral_slurry", amount: 20250}}')
    A(f'    ],')
    A(f'    time: 160,')
    A(f'    fluidInput: {{fluid: "oritech:still_sulfuric_acid", amount: 81000}},')
    A(f'    ingredients: [{feed}]')
    A(f'}});')
    A(f'<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15b.precipitate.{key}", {{type: "oritech:centrifuge_fluid",')
    A(f'    results: [{{id: "{clump}", count: 1}}],')
    A(f'    time: 150,')
    A(f'    fluidInput: {{fluid: "{sol}", amount: 81000}},')
    A(f'    ingredients: [{{item: "jsonreg:salt_dust", count: 1}}]')
    A(f'}});')
    A(f'<recipetype:oritech:centrifuge_fluid>.addJsonRecipe("general.t15c.recrystallize.{key}", {{type: "oritech:centrifuge_fluid",')
    A(f'    results: [{{id: "{gem}", count: 1}}],')
    A(f'    fluidOutputs: [{{fluid: "oritech:still_mineral_slurry", amount: 8100}}],')
    A(f'    time: 200,')
    A(f'    fluidInput: {{fluid: "oritech:still_sulfuric_acid", amount: 40500}},')
    A(f'    ingredients: [{{item: "{clump}", count: 1}}]')
    A(f'}});')
    A(f'<recipetype:techreborn:grinder>.addJsonRecipe("general.t15d.grind_gem.{key}", {{type: "techreborn:grinder",')
    A(f'    time: 200, power: 32,')
    A(f'    outputs: [{{id: "{dust}", count: 3}}],')
    A(f'    ingredients: [{{item: "{gem}"}}]')
    A(f'}});')
    A("")
l15_block = "\n".join(L15)

# 替换清退块
s = text.index("// ============================================================\n// T1 清退")
e = text.index("// ============================================================\n// T1：")
text = text[:s] + rem_block + "\n" + text[e:]
# 替换 T1b+T1.5 块（首次运行时 T1b 尚不存在，从 T1.5 标记处插入）
try:
    s = text.index("// ============================================================\n// T1b：")
except ValueError:
    s = text.index("// ============================================================\n// T1.5：")
e = text.index("// ============================================================\n// T2：")
text = text[:s] + l15_block + "\n" + text[e:]
TARGET.write_text(text, encoding="utf-8")

print(f"清退 {len(removals)} 条旧矿石配方")
print(f"T1.5 写入 {len(M)} 种金属 × 4 步 = {len(M)*4} 条配方")
print(f"文件行数: {len(text.splitlines())}")
