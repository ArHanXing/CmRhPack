# CmRhPack Agent笔记（CrT / Json-Registered / 材质生成 / GTOreVein）

> 面向LLM的本整合包内容制作的速查与流程文档。一切以仓库内现状为准，官方文档为辅。

## 参考文档

- CraftTweaker 官方文档（1.21.1）：<https://docs.blamejared.com/1.21.1/en/>
  - 通用配方操作（Generic Recipe Manipulation）：<https://docs.blamejared.com/1.21.1/en/mods/other_mods/>
  - `IRecipeManager`（`<recipetype>` 的公共接口）：<https://docs.blamejared.com/1.21.1/en/vanilla/api/recipe/manager/IRecipeManager/>
- Lychee 官方文档（1.21）：<https://lycheetweaker.readthedocs.io/en/1.21/>
- 本包速查：
  - `scripts/example.md` —— 各机器 `addJsonRecipe` 配方模板（含流体坑）
  - `scripts/!recipedump.txt` —— `/ct` 导出的全量配方 dump（addJsonRecipe 形式，可当字典查）
  - `config/jsonreg_entries.json.md` —— jsonreg 注册内容设计稿（色号、产线、材料分级）
  - `config/openloader/packs/GTOreVein/README.md` —— 矿脉参数说明

---

## 1. CraftTweaker 脚本规范

### 1.1 总原则

这是 **CraftTweaker 21（MC 1.21.1 / Fabric）** 的 ZenCode 脚本集。与老式 CrT 最大的区别：

1. **不用 `mods.xxx.addRecipe(...)`**（全库 0 处），因为这版本根本没有模组去适配CrT，必须使用数据包写法。
2. 机器配方统一走 **`<recipetype:xxx>.addJsonRecipe(name, {...})`**：第二个参数是**该 mod 数据包 JSON 的字面量**（ZenCode MapData），必须自带 `type` 字段。全库共 326 处 `addJsonRecipe`，而 fluent 式 `addRecipe` 只有 3 处（原版熔炉/高炉）。
3. 官方依据：所有 `<recipetype>` 都实现 `IRecipeManager`，只要 mod 支持数据包就能用 `addJsonRecipe(name as string, mapData as MapData)`；**每个 mod 的 JSON 格式各不相同**，以 mod 自带的 `data/<mod>/recipe/` 里现成 JSON 为准。
4. 删除/查询用 `IRecipeManager` 公共方法：`removeByName(names)`、`remove(output)`、`removeByInput(input)`、`removeByModid`、`removeByRegex`、`removeAll()`、`getRecipeByName`、`recipeMap()`。
5. 作者不会 onEvent 逻辑，如果LLM会可以写一些仅服务端逻辑。
6. 一切机器都要考证其**最大输入输出槽位数**，例如蒸馏塔是4输入6输出；对其编写超过6个输出的配方不会有ZS显式编译错误，但是配方执行就 NPE 。
7. **空流体单元作为输入，一定要写 `components: {"techreborn:fluid": "minecraft:empty"}`**。也就是 `{count: 2, base: {item: "techreborn:cell"}, components: {"techreborn:fluid": "minecraft:empty"},  "fabric:type": "fabric:components"}`。否则会导致数据匹配的 Bug
原版配方有快捷全局对象（等价于对应 recipetype）：

```zenscript
craftingTable.addShaped/addShapeless/remove/removeByName   // <recipetype:minecraft:crafting>
furnace.addRecipe/remove/removeByName                      // <recipetype:minecraft:smelting>
blastFurnace.addRecipe/remove/removeByName                 // <recipetype:minecraft:blasting>
```

### 1.2 Bracket Handler 一览

| 语法 | 用途 | 示例 |
|---|---|---|
| `<item:mod:id>` | 物品 | `<item:jsonreg:naquadah_dust>` |
| `<block:mod:id>` | 方块 | `<block:jsonreg:salt_ore>` |
| `<blockstate:mod:id>` | 方块状态，可改属性 | `<blockstate:oritech:resource_node_tin>.destroySpeed = 10` |
| `<tag:item:...>` / `<tag:block:...>` | 标签增删 | `<tag:item:c:dusts>.add(...)`、`<tag:block:c:ores>.add(...)` |
| `<recipetype:...>` | 配方管理器 | `<recipetype:techreborn:industrial_grinder>` |
| `<componenttype:...>` | 物品组件类型 | `<componenttype:minecraft:custom_model_data>` |
| `IIngredientEmpty.getInstance()` | 工作台空格 | CTGUI 导出中大量使用 |
| `<item:x> * N` | 数量 | `<item:refinedstorage:cable> * 16` |
| `<item:a> | <item:b>` | 输入并集（任一） | t0 钢工具回收配方 |
| `.withJsonComponent(comp, value)` | 给产物写组件 | 稀有度 / lore / 流体 / NBT |

### 1.3 流体约定（本包最容易踩的坑）

TR 机器里的流体用 **单元（cell）+ 组件** 表示，且**输入和输出格式不对称**（`example.md` 开头专门强调）：

- **输入**（消耗带流体单元）：
  ```json
  {count: 16, components: {"techreborn:fluid": "命名空间:流体"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
  ```
- **输出**（产出带流体单元）：直接 `{id: "techreborn:cell", count: 15, components: {"techreborn:fluid": "..."}}`，**没有** `base` / `fabric:type`。
- 空单元（消耗容器）用 `"techreborn:fluid": "minecraft:empty"`。

单位换算：

- **Oritech 流体单位是 81 倍**：`81000 = 1000 mB`。OR 机器 `fluidInput` / `fluidOutputs` 里的 `amount` 直接写这个单位（如 `8100` = 100 mB）。
- TR 工业磨粉机是嵌套结构：`fluid: {fluid: {fluid: "minecraft:water"}, amount: {value: 81000}}`。

常见手法：OR 与 TR 同名流体互相打通（统一硫酸、统一 still_oil/TR oil、TR 柴油），同一反应写两条（一条 OR、一条 TR）。

### 1.4 各机器配方模板（字段速查）

| 机器 | recipetype / type | 关键字段 | 出处 |
|---|---|---|---|
| TR 工业磨粉机 | `techreborn:industrial_grinder` | `outputs` / `time` / `power` / `ingredients` / 嵌套 `fluid` | example.md |
| TR 离心机 | `techreborn:centrifuge` | `outputs` / `time` / `power` / `ingredients` | example.md |
| TR 蒸馏塔 | `techreborn:distillation_tower` | cell+components 输入输出 | example.md |
| TR 电高炉 | `techreborn:blast_furnace` | 带 `heat` | example.md |
| TR 真空冷冻机 | `techreborn:vacuum_freezer` | 基础 | example.md |
| TR 化学反应釜 | `techreborn:chemical_reactor` | 基础 | example.md |
| TR 工业电解 | `techreborn:industrial_electrolyzer` | cell 输出 | example.md |
| TR 聚爆压缩机 | `techreborn:implosion_compressor` | 多输出 | example.md |
| TR 装配机 | `techreborn:assembling_machine` | 基础 | example.md |
| TR 合金炉 | `techreborn:alloy_smelter` | 基础 | example.md |
| TR 压缩机/磨粉机/线材轧机 | `techreborn:compressor` / `grinder` / `wire_mill` | 基础 | example.md / wiremill2lathe.zs |
| TR 发电机 | `gas_generator` / `semi_fluid_generator` / `diesel_generator` | `power` + `fluid`（无 ingredients） | oil_chemistry.zs |
| OR 精炼机 | `oritech:refinery` | `results` / `fluidOutputs` / `fluidInput` | example.md |
| OR 组装机 | `oritech:assembler` | **`fluidInput`/`fluidOutput` 即使空也要写** `{fluid: "minecraft:empty", amount: 0}` | example.md |
| OR 离心机 | `oritech:centrifuge` / `centrifuge_fluid` | 后者带 `fluidOutputs` | example.md |
| OR 原子锻炉 | `oritech:atomic_forge` | 基础 | example.md |
| OR 铸造炉 | `oritech:foundry` | `fluidInput`/`fluidOutput` 同组装机 | uni.zs |
| OR 深钻 | `oritech:deep_drill` | `results` / `ingredients` | misc.zs（表驱动生成） |
| OR 燃料发电机 | `oritech:fuel_generator` | `fluidInput` + `time` | oil_chemistry.zs |
| Botania 魔力灌注 | `botania:mana_infusion` | `input` / `output` / `catalyst` / `mana` | example.md |
| Affinity 杜鹃灌注 | `affinity:aspen_infusion` | `primary_input` / `inputs` / `output` / `duration` / `flux_cost_per_tick` / `transfer_components` | etst&magic.zs |
| Avaritia 无尽工作台 | `avaritia:extreme_crafting`（`type: "avaritia:extreme_shaped"`） | **9 行 pattern** 字符串 + `key` | t2/t3.zs |
| Lychee | `lychee:block_interacting` / `block_clicking` / `item_inside` | JSON 原样；`item_inside` 的 `time` 单位是 **tick**（20/s） | refinedstorage.zs / misc.zs / bio_chemistry.zs |

### 1.5 脚本即"配方生成器"

本包大量使用 ZenCode 编程能力批量生成配方：

- `function _rodRecipe(...) as void`（wiremill2lathe.zs）：`<recipetype:techreborn:wire_mill>.removeAll()` 后曾把线材轧机改造成"车床"，函数化产出棒材。注意：现在已经有了真正的车床，不再需要这一项修改，但是wiremill依旧没有配方。
- `misc.zs`：`vanillaNodes` / `customNodes` 两张表 + `for` 循环，批量生成深钻节点配方、装配器节点配方、标签收录、`destroySpeed` 修改。
- `oil_chemistry.zs`：4 种发电机 `removeAll()` 后重建石化燃料体系（155 条配方）。
- `t1/t2/t3.zs` 里的 `_smd_assembler` / `_reactor` / `_fuelrod` 等函数。

配套语法：`val` 常量数组、`node[0] as string` 强转、`"prefix" + name` 拼接、`<block:${ns}:${name}>` 插值。**配方名必须全局唯一**，且遵循包内前缀。

### 1.6 文件组织与配方 ID 前缀

| 文件 | 职责 | addJsonRecipe 数 |
|---|---|---|
| `t0.zs` / `t1.zs` / `t2.zs` / `t3.zs` | 科技树分阶段 | 0 / 15 / 37 / 24 |
| `oil_chemistry.zs` | 石油化工（最大） | 136 |
| `bio_chemistry.zs` | 生物化工（发酵制乙烯 + 生物塑料） | 4 |
| `process_naquadah.zs` | 硅岩/超能硅岩处理线 | 37 |
| `refinedstorage.zs` | RS 线（处理器、机壳、创造控制器） | 8 |
| `uni.zs` | 材料统一化 + 修复（钢、硅、硫酸、机器核心） | 13 |
| `misc.zs` | 杂项 + 深钻/资源节点生成器 | 8 |
| `etst&magic.zs` | 永恒星光 + Affinity/Botania 魔法线 | 24 |
| `wiremill2lathe.zs` | 车床配方 | 5 |
| `tooltip.zs` | 元素符号/化学式/梗 tooltip | 0 |
| `material_tags.zs` | 把 jsonreg 物品收编进 `c:` 标签 | 0 |
| `ctgui_generated.zs` | CTGUI 导出（**不要手改**） | 0（108 处 craftingTable 修改） |

配方 ID 前缀：`t0.` / `t1.` / `t2.` / `t3.` / `oil.` / `bio.` / `nqdh.` / `rs.` / `uni.` / `misc.` / `fix.` / `magic.` / `etst.` / `ctgui/`。

### 1.7 Tooltip 与物品组件

```zenscript
<item:minecraft:gold_ingot>.addTooltip("§e§lAu§r");
<item:oritech:super_ai_chip>.addTooltip("Tier-§e3§r");

// 合成产物带组件（1.20.5+ 组件系统）
<item:minecraft:amethyst_shard>
    .withJsonComponent(<componenttype:minecraft:custom_model_data>, 90001)
    .withJsonComponent(<componenttype:minecraft:rarity>, "uncommon")
    .withJsonComponent(<componenttype:minecraft:lore>, [...]);
```

### 1.8 已知坑

- 多人游戏下 CrT tooltip 不显示（README）。
- Affinity 杜鹃灌注/强化组装**不要用 CrT**，走数据包：`config/openloader/packs/languageadd/data/...`（`affinity:assembly_shaped` 等）。
- `<recipetype:minecraft:blasting_extra>` 是本包特例（t0.zs，1 次），不是标准管理器名。 注：该配方类型源自 EarlyStage mod，具体定义的是具有两个输入的原版高炉配方。没有用处
- `craftingTable.remove(<item>)` 删的是"以该物品为输出的所有工作台配方"，机器配方要上对应 recipetype。
- 注意：空气的注册名是 *低氧氮气*（来自jsonreg），氧气的注册名是 *压缩空气*（来自TR）。
- Lychee 1.21 坑（实测/源码确认）：
  - `item_inside` 的 `time` 单位是 **tick** 不是秒（`LycheeCounter` 每 tick +1，`count >= time` 触发）。
  - 本版本 `execute` 等 post_action 有 bug，**只用 `drop_item`**（`{type, id, count, components}`，Fabric 组件可直接写 `techreborn:fluid`）。
  - `item_in` 只支持 item/tag 精确匹配，**不支持 components 匹配**；要限带流体单元输入只能用桶/专用物品，或用 `count` 做批量。

---

## 2. 注册自定义物品 / 方块 / 流体（Json-Registered）

### 2.1 `config/jsonreg_entries.json`

三段结构，注册后命名空间统一为 `jsonreg:<id>`：

| 段 | 数量 | 字段 |
|---|---|---|
| `items` | 115 | `id` / `name`（直接是显示名）/ `max_count` |
| `blocks` | 17 | `id` / `name` / `hardness` / `resistance` / `requires_tool` / `has_item` |
| `fluids` | 76 | `id` / `name` / `has_bucket_item` / `has_block` |

示例：

```json
{"id": "naquadah_ingot", "name": "硅岩锭", "max_count": 64},
{"id": "salt_ore", "name": "盐矿石", "hardness": 2.5, "resistance": 10.0, "requires_tool": false, "has_item": true},
{"id": "desalted_crude", "name": "脱盐原油", "has_bucket_item": false, "has_block": true}
```

`config/jsonreg_entries.json.md` 是配套设计稿：流体/材料的色号表、富集硅岩线/超能硅岩线/石化产线说明、T1~T3 材料分级。

添加新的材料**必须为其指定色号**。

### 2.2 自动生成的资源

Json-Registered（`jsonreg` 0.6，基于 YARRP）会自动生成：

- 物品模型：`minecraft:item/generated` → `jsonreg:item/<id>` 材质
- 方块模型 / 方块 blockstate / 方块物品模型（`cube_all` → `jsonreg:block/<id>` 材质）
- 桶模型、流体方块模型 / blockstate

所以**手动只需要提供材质**：

```
config/openloader/packs/languageadd/assets/jsonreg/
├── textures/
│   ├── block/<id>.png         # 方块/矿石贴图
│   ├── item/<id>.png          # 物品贴图
│   └── fluid/<name>_still.png / <name>_flow.png
└── models/                    # 一般不需要，mod 自动生成
```

### 2.3 材质生成工作流（`__workspace`）

工作目录：`config/openloader/packs/languageadd/assets/jsonreg/textures/__workspace/`

`material_set/` 是 GTM 材质库：按质感分类（`dull` / `shiny` / `metallic` / `magnetic` / `rough` / `fine` / `radioactive` / `quartz` / `gem*` / `fluid` 等），每个子材质有主图 + `_overlay` + `_secondary` 变体；`material_set/__models/<类别>/` 有对应物品模型模板。

三个生成脚本：

**`assetsgen.py`（不叠加 overlay）**

交互式流程：选材质类别 → 选子材质（可多个）→ 输入 6 位色号 → 逐个改新名。

- 把所有变体（含 `_overlay` / `_secondary`）按"灰度 × 目标色"**分别着色保存**（不合成）。
- 复制 `.mcmeta`，并从 `__models/<类别>/` 复制模型到输出。
- 输出：`textures/{item|fluid}/` + `models/{item|fluid}/`。

**`another_assetsgen.py`（叠加 overlay）**

同样的交互式入口，区别是：

- 主图着色后，把 `_overlay` / `_secondary` **原样（不上色）粘贴合成到主图上**，输出烘焙后的 `name.png` / `name_overlay.png` / `name_secondary.png`。
- 只输出材质，**不输出模型**。

**`genfluid.py`（流体材质）**

```bash
python genfluid.py <name> <state> <color>
# state: 1 = thick, 0 = thin；color: 6 位十六进制
```

从 `material_set/fluid/{thick|thin}_fluid_{still|flow}.png` 着色，输出 `textures/fluid/<name>_still.png` + `<name>_flow.png`（mcmeta 为 `{"animation": {}}`）。

**其他工具**：`recolor.py`（HSV 保明暗批量换色，`python recolor.py <RRGGBB> [dir] [-r]`）；`makestate.py`（`python makestate.py <block_name>` 生成 blockstate）。

**矿石方块贴图**：`material_set/` 根部的 `stone.png` / `end_stone.png` / `netherrack.png` / `voidstone.png` / `grimstone.png` / `blank.png` 是围岩基底，把着色后的矿粒/overlay 手动合成到基底上，存到 `textures/block/<id>.png`。**选哪个材质类别、叠不叠加 overlay 按个人观感决定**（dull 哑光、shiny 高光、rough 粗糙、radioactive 放射性、magnetic 磁化等），不是硬规则。

### 2.4 收尾

- 进游戏验证；脚本侧引用 `jsonreg:` 物品（`<item:jsonreg:...>`），并记得在 `scripts/material_tags.zs` 收编进 `c:` 标签。
- 流体注册后配方里用的是 `jsonreg:<fluid_id>`（cell 组件 / OR 流体单位），见第 1.3 节。

---

## 3. GTOreVein（GT 风格团簇矿脉）

位置：`config/openloader/packs/GTOreVein/`（OpenLoader 数据包），依赖 **MoreDensityFunctions**（`moredfs:` 提供 `mod` / `subtract` / `x` / `z`）与 **Dynamic Ore Veins**（`dynamic_veins:`）。

### 3.1 数据包结构

```
GTOreVein/
├── data/gt_veins/worldgen/ore_vein/*.json      # 29 个矿脉定义
├── data/dynamic_veins/config/vein_settings/settings.json
│      # {"vanilla_veins_enabled": false, "vanilla_priority": false, ...} 禁用原版大型矿脉
├── data/minecraft/worldgen/noise_settings/{nether,end}.json
├── data/eternal_starlight/worldgen/noise_settings/starlight.json
│      # 给无矿脉的维度注入 vein_gap / vein_ridged / vein_toggle + "ore_veins_enabled": true
└── README.md                                   # 调参说明
```

主世界**不需要**覆盖 noise_settings（原版 overworld 自带 `vein_*`）；下界/末地/星光维度需要把 vein 噪声函数贴进 `noise_router`（**必须保留维度文件其余内容，否则报错**）。注意原版噪声矿脉高度上限 `y=+51`。

### 3.2 矿脉文件字段

| 字段 | 含义 |
|---|---|
| `ore` / `secondary_ore` | 主/副矿石（`jsonreg:` 自定义矿直接引用） |
| `secondary_ore_chance` | 副矿概率 |
| `filler_block` | 围岩（stone / end_stone / grimstone…） |
| `vein_toggle` | 网格激活函数（moredfs 网格，决定矿团位置与形状） |
| `vein_ridged` / `vein_gap` | 矿脉内部密度函数（本包用 `ore_vein_a/b` + `ore_gap`） |
| `vein_settings` | `min/max_ore_richness`、`min/max_richness_threshold`、`vein_solidness` |
| `dimension` | 生成维度 |
| `conditions` | `dynamic_veins:all_of` + `height_range`（分层）/ `density_threshold`（概率） |

### 3.3 调参速查（详见 GTOreVein/README.md）

- **矿脉间距**：`denominator: 48` = 每 3 区块一个网格中心；`argument2` **必须等于 `denominator / 2`**（当前 48 / 24）。
- **矿团大小**：`range_choice` 的 `min_exclusive` / `max_inclusive`（当前 ±3 → 7×7）；**矿团边长 ≤ 网格步长一半**，否则粘连。
- **生成频率**：`dynamic_veins:density_threshold` + `minecraft:noise(ore_veininess)`，`max_threshold: 0.7` ≈ 70% 网格有矿。
- **分层**：不相交的 `height_range` 之间不冲突，可在同一网格内按 Y 分多种矿。

### 3.4 本包自定义矿

- `salt.json`：`jsonreg:salt_ore` + `jsonreg:rock_salt_ore`，主世界 0~120。
- `end_naquadah_ore.json`：`jsonreg:end_naquadah_ore` + `jsonreg:end_enriched_naquadah_ore`，末地。
- `oil_sand.json`：`jsonreg:oil_sand_ore`（主/副都是油砂），主世界 0~120。
- `_test_starlight_ore.json`：星光维度测试矿（`eternal_starlight:grimstone` 填充）。

对应矿石的注册在 `config/jsonreg_entries.json`，材质/blockstate 走第 2 节流程（如 `end_naquadah_ore.png`、`voidstone_rutile_ore.png`、`oil_sand_ore.png`）。

---

## 4. Lychee 速查（官方 1.21）

配方放在数据包 `data/<ns>/recipe/` 或经 CrT 注入。公共字段：`type` / `if`（条件）/ `post`（动作）/ `ghost` / `hide_in_viewer` / `group` / `max_repeats`；Fabric 加载条件为 `fabric:load_conditions`。

### 常用类型

**`lychee:block_interacting`**（对方块使用物品）与 **`lychee:block_clicking`**（点击方块）：

```json
{
  "type": "lychee:block_interacting",
  "item_in": "refinedstorage:quartz_enriched_iron",
  "block_in": "techreborn:basic_machine_frame",
  "post": ["place refinedstorage:machine_casing"]
}
```

- `item_in`：SizedIngredient，可传数组 `[主手, 副手]`；`{}` 表示空手；`lychee:always_true` 匹配任意物品。
- `block_in`：BlockPredicate（支持方块状态，如 `water_cauldron[level=3]`）。
- 默认消耗物品；`prevent_default` 可阻止默认行为/消耗。
- 官方警告：`block_interacting` 里尽量别用 contextual 条件；目前不支持与流体方块交互。

**`lychee:item_inside`**（物品实体待在方块内，每秒判定）：`item_in` + `block_in` + `time`（秒）。

### 常用 post 动作

`prevent_default` / `drop <item> [概率]` / `place <block>` / `set_block` / `damage_item` / `run "<命令>"`（官方文档写法）/ `if-then-else`（配合 `location` 条件）。

> 注意：本包 `misc.zs` 的虚空传送门配方用的是 `{"type": "execute", "command": "..."}` 形式（Lychee 的 `execute` post action），与官方文档示例里的 `run "..."` 是两种写法，复制时留意版本。

```zenscript
<recipetype:lychee:block_clicking>.addJsonRecipe("misc.enter_void_dimension", {
  "type": "lychee:block_clicking",
  "item_in": {},
  "block_in": "minecraft:obsidian",
  "post": [
    {"type": "if", "contextual": {"type": "location", "predicate": {"dimension": "d4r4_dimension:void_dimension"}},
     "then": [{"type": "execute", "command": "execute in minecraft:overworld run tp @p 0 100 0", "hide": true}, ...],
     "else": [...]},
    {"type": "prevent_default"}
  ]
});
```

---

## 5. 常用命令

- `/ct dump recipetype` —— 列出全部可用 recipetype（官方文档确认所有 `<recipetype>` 由此得到）。
- `/ct recipes` 类导出 —— 输出每个 recipetype 的现成配方为 `addJsonRecipe` 形式（`scripts/!recipedump.txt` 即此产物，可全文检索配方名与 JSON 结构）。
- `/reload` —— 重载数据包/脚本；多人下 CrT tooltip 不显示属已知限制。
