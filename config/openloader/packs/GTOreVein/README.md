# GT Ore Veins 格雷风格的矿脉
这只是一个近似实现。

本数据包依赖模组 MoreDensityFunctions 和 Dynamic Ore Veins。

---
## 临时：星光维度金红石 feature（绕过 DOV）

由于星光维度使用自定义区块生成器（ESChunkGenerator），DOV 的矿脉机制在该维度不生效。
临时改用 vanilla ore feature 在星光维度生成 `jsonreg:voidstone_rutile_ore`：

- `data/gt_veins/worldgen/configured_feature/voidstone_rutile_ore.json`
- `data/gt_veins/worldgen/placed_feature/voidstone_rutile_ore.json`
- `data/eternal_starlight/worldgen/biome/*.json`（21 个星光 biome，features[6] 追加了该 feature）

移除方法：删除上述三个位置的文件/目录即可恢复原状。参数：size 10、每区块 count 10、Y -64~200、仅替换 `eternal_starlight:voidstone`。

---
MoreDensityFunctions wiki @ https://github.com/klinbee/More-Density-Functions/wiki
Dynamic Ore Veins wiki @ https://github.com/TheBrewingMiner/DOV-Homepage/wiki
请LLM自行取用。

以下内容均由 DeepSeek 生成。

## 矿脉布局：球状网格（当前实现）

### 中心区块判定公式

- 网格步长 **192 格 = 12 区块**。矿球球心（方块坐标）：`x = 192k + 96`、`z = 192m + 96`，即满足 `x ≡ 96 (mod 192)` 且 `z ≡ 96 (mod 192)` 的点。
- **用区块坐标（Cx, Cz）判定**：`Cx mod 12 ∈ {5, 6}` 且 `Cz mod 12 ∈ {5, 6}` 的 2×2 区块就是矿球所在（R=16 恰好 = 1 区块，球占满这 2×2）。球心位于其中 (6,6) 区块的最小角（块坐标 192k+96, 192m+96）。
- 取模为数学取模（floor mod），负坐标安全：如 Cx = −7 → −7 mod 12 = 5 ✓。
- 球心高度 Y 由矿种决定，见下表；同格只有一种矿脉（见下）。

### 每格矿种判定（确定性，与种子无关）

1. 格子编号 `k = floor(x/192)`、`m = floor(z/192)`（中心区块等价于 `k = (Cx−6)/12`、`m = (Cz−6)/12`）。
2. 哈希 `v = 42·frac(sin(127.1k + 311.7m)·43758.5453) − 21 ∈ [-21, 21)`。
3. 矿种 = 该维度切片表中 `v` 所落区间对应的矿脉（每维度把 [-21,21] 均分成 N 段，N=矿脉数，一格恰好一种）。
4. 实现文件：`data/gt_veins/worldgen/density_function/cell_shuffle.json`（供 DOV shuffle_source 引用）+ 每条矿脉 `conditions` 内的 `dynamic_veins:density_threshold` 门（内联同一函数，两者必须保持一致）。

> **配套工具**：浏览器直接打开本目录下的 [`vein_map.html`](vein_map.html) —— 交互式矿脉地图（平移/缩放/悬停查询/按矿种定位最近矿脉），内置与数据包一致的判定算法。

### 调参入口

| 想改什么 | 改哪里 |
|---|---|
| 球大小 | `vein_toggle.max_exclusive`（R）+ `conditions.height_range`（Yc±R） |
| 网格间距 | 所有 `vein_toggle` 的 `mod.denominator`(192)/`subtract`(96) + `cell_shuffle.json` 的 `div.denominator`(192) |
| 球体致密度 | `vein_settings.vein_solidness`（0.7 = 球内 70% 方块成矿，30% 保留原石孔） |
| 次矿占比 | `secondary_ore_chance` |
| 球心高度 | `vein_toggle.point1[1].argument2`（Yc）+ `height_range` |
| 矿种轮换随机性 | `cell_shuffle.json`（哈希系数 127.1/311.7/43758.5453；与矿脉门内联 input 同步） |

### 全部矿脉总表

| 矿脉 | 维度 | 主矿石 | 次矿石 (占比) | 球心 Y | 半径 R | Y 范围 | 类型切片 |
|---|---|---|---|---|---|---|---|
| _test_starlight_ore *(测试)* | 星光 | uranium (`deepslate_uranium_ore`) | lead `deepslate_lead_ore` (40%) | 68 | 16 | 52~84 | [-21.00, 0.00) |
| bauxite_iron | 主世界 | bauxite (`deepslate_bauxite_ore`) | iron `deepslate_iron_ore` (40%) | -32.5 | 16 | -49~-16 | [-21.00, -18.53) |
| chalcopyrite | 主世界 | copper (`copper_ore`) | tin `tin_ore` (40%) | 40 | 16 | 24~56 | [-18.53, -16.06) |
| coal | 主世界 | coal (`coal_ore`) | diamond `diamond_ore` (10%) | 30 | 16 | 14~46 | [-16.06, -13.59) |
| corundum | 主世界 | ruby (`ruby_ore`) | sapphire `sapphire_ore` (40%) | 60 | 16 | 44~76 | [-13.59, -11.12) |
| emerald_gold | 主世界 | emerald (`emerald_ore`) | gold `gold_ore` (40%) | 60 | 16 | 44~76 | [-11.12, -8.65) |
| end_naquadah_ore | 末地 | end_naquadah (`end_naquadah_ore`) | end_enriched_naquadah `end_enriched_naquadah_ore` (30%) | 30 | 16 | 14~46 | [-21.00, -7.00) |
| end_peridot_ore | 末地 | sodalite (`sodalite_ore`) | peridot `peridot_ore` (50%) | 30 | 16 | 14~46 | [-7.00, 7.00) |
| end_sheldonite_ore | 末地 | sheldonite (`sheldonite_ore`) | tungsten `tungsten_ore` (50%) | 30 | 16 | 14~46 | [7.00, 21.00) |
| galena_silver | 主世界 | galena (`deepslate_galena_ore`) | silver `deepslate_silver_ore` (30%) | -20 | 16 | -36~-4 | [-8.65, -6.18) |
| iridium_iron | 主世界 | iridium (`deepslate_iridium_ore`) | iron `deepslate_iron_ore` (30%) | -32.5 | 16 | -49~-16 | [-6.18, -3.71) |
| kimberlite | 主世界 | diamond (`deepslate_diamond_ore`) | redstone `deepslate_redstone_ore` (40%) | -32.5 | 16 | -49~-16 | [-3.71, -1.24) |
| lapis_gold | 主世界 | lapis (`deepslate_lapis_ore`) | gold `deepslate_gold_ore` (30%) | -32.5 | 16 | -49~-16 | [-1.24, 1.24) |
| lead_silver | 主世界 | lead (`deepslate_lead_ore`) | silver `deepslate_silver_ore` (40%) | -32.5 | 16 | -49~-16 | [1.24, 3.71) |
| magnetite | 主世界 | iron (`iron_ore`) | gold `gold_ore` (30%) | 40 | 16 | 24~56 | [3.71, 6.18) |
| nether_cinnabar | 下界 | cinnabar (`cinnabar_ore`) | sulfur `sulfur_ore` (30%) | 35 | 16 | 19~51 | [-21.00, -12.60) |
| nether_pyrite | 下界 | pyrite (`pyrite_ore`) | nether_gold `nether_gold_ore` (40%) | 35 | 16 | 19~51 | [-12.60, -4.20) |
| nether_quartz | 下界 | nether_quartz (`nether_quartz_ore`) | sulfur_quartz `sulfur_quartz_ore` (30%) | 35 | 16 | 19~51 | [-4.20, 4.20) |
| nether_rose_quartz | 下界 | rose_quartz (`rose_quartz_ore`) | smoky_quartz `smoky_quartz_ore` (50%) | 35 | 16 | 19~51 | [4.20, 12.60) |
| nether_sphalerite | 下界 | sphalerite (`sphalerite_ore`) | sulfur `sulfur_ore` (30%) | 35 | 16 | 19~51 | [12.60, 21.00) |
| nickel_copper | 主世界 | nickel (`deepslate_nickel_ore`) | copper `deepslate_copper_ore` (30%) | -32.5 | 16 | -49~-16 | [6.18, 8.65) |
| oil_sand | 主世界 | oil_sand (`oil_sand_ore`) | oil_sand `oil_sand_ore` (40%) | 60 | 16 | 44~76 | [8.65, 11.12) |
| redstone_copper | 主世界 | redstone (`deepslate_redstone_ore`) | copper `deepslate_copper_ore` (30%) | -32.5 | 16 | -49~-16 | [11.12, 13.59) |
| salt | 主世界 | salt (`salt_ore`) | rock_salt `rock_salt_ore` (40%) | 60 | 16 | 44~76 | [13.59, 16.06) |
| starlight_rutile | 星光 | voidstone_rutile (`voidstone_rutile_ore`) | voidstone_malarite `voidstone_malarite_ore` (40%) | -32 | 16 | -48~-16 | [0.00, 21.00) |
| tin_copper | 主世界 | tin (`tin_ore`) | copper `copper_ore` (50%) | 40 | 16 | 24~56 | [16.06, 18.53) |
| uranium_lead | 主世界 | uranium (`deepslate_uranium_ore`) | lead `deepslate_lead_ore` (40%) | -15.5 | 13 | -29~-2 | [18.53, 21.00) |

---

严肃注意：原版噪声矿脉高度上限 y=+51

```json
    "vein_gap": {
      "type": "minecraft:noise",
      "noise": "minecraft:ore_gap",
      "xz_scale": 1.0,
      "y_scale": 1.0
    },
    "vein_ridged": {
      "type": "minecraft:add",
      "argument1": -0.07999999821186066,
      "argument2": {
        "type": "minecraft:max",
        "argument1": {
          "type": "minecraft:abs",
          "argument": {
            "type": "minecraft:interpolated",
            "argument": {
              "type": "minecraft:range_choice",
              "input": "minecraft:y",
              "max_exclusive": 51.0,
              "min_inclusive": -60.0,
              "when_in_range": {
                "type": "minecraft:noise",
                "noise": "minecraft:ore_vein_a",
                "xz_scale": 4.0,
                "y_scale": 4.0
              },
              "when_out_of_range": 0.0
            }
          }
        },
        "argument2": {
          "type": "minecraft:abs",
          "argument": {
            "type": "minecraft:interpolated",
            "argument": {
              "type": "minecraft:range_choice",
              "input": "minecraft:y",
              "max_exclusive": 51.0,
              "min_inclusive": -60.0,
              "when_in_range": {
                "type": "minecraft:noise",
                "noise": "minecraft:ore_vein_b",
                "xz_scale": 4.0,
                "y_scale": 4.0
              },
              "when_out_of_range": 0.0
            }
          }
        }
      }
    },
    "vein_toggle": {
      "type": "minecraft:interpolated",
      "argument": {
        "type": "minecraft:range_choice",
        "input": "minecraft:y",
        "max_exclusive": 80.0,
        "min_inclusive": -60.0,
        "when_in_range": {
          "type": "minecraft:noise",
          "noise": "minecraft:ore_veininess",
          "xz_scale": 1.5,
          "y_scale": 1.5
        },
        "when_out_of_range": 0.0
      }
    }
  },
  "ore_veins_enabled": true,
```

粘贴进noise_settings/维度设置文件内的noise_router来给维度添加矿脉噪声，注意必须把维度文件的其余部分一并复制，不然会报错。
