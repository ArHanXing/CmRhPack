# GT Ore Veins 格雷风格的矿脉
这只是一个近似实现。

本数据包依赖模组 MoreDensityFunctions 和 Dynamic Ore Veins。

以下内容均由 DeepSeek 生成。

## 配置矿脉的间隔与生成频率

### 1. 控制矿脉中心间距（网格步长）

核心参数是 `denominator`（网格单元尺寸）和对应的 `subtract` 值。当前配置中：

```json
"denominator": 48.0,
"argument2": 24.0
```

- `denominator` 表示每隔多少格划出一个网格单元。例如 `48.0` 意味着矿脉中心每 48 格（3 区块）出现一个。
- `argument2` **必须等于 `denominator / 2`**，才能将网格原点对齐到每个单元的中心。修改举例：
  - 想要更稀疏的矿脉：改为 `96.0` 和 `48.0`，矿脉间距变为 6 区块。
  - 想要更密集的矿脉：改为 `32.0` 和 `16.0`，每 2 区块一个中心。

> 注意：修改间距时，请保持 `argument2 = denominator / 2`，否则矿脉会偏离网格中心，造成分布不均。

---

### 2. 控制单个矿团尺寸

在你的矩形 `vein_toggle` 中，激活区域由 `range_choice` 的边界决定：

```json
"min_exclusive": -5.0,
"max_inclusive": 5.0
```

这产生了一个 **11×11 格**的方形矿团（中心 5 格，向四个方向各延伸 5 格，加上中心本身共 11 格）。  
- 想要更大矿团：扩大范围，如 `-8.0` 到 `8.0` → 17×17。
- 想要更小矿团：缩小范围，如 `-3.0` 到 `3.0` → 7×7。

**重要**：矿团尺寸必须小于网格间距，否则相邻矿团会粘连在一起。建议 **矿团边长 ≤ 网格步长的 1/2**。

---

### 3. 控制生成频率（特定区域是否一定有矿脉）

共享相同 `vein_toggle`（相同网格）的多个矿脉，会在每个网格单元中**随机抽选一个**符合条件的生成。  
如果希望某些网格单元**完全不生成矿脉**，可以添加一个概率条件。例如，让只有 70% 的网格单元有矿脉：

```json
"conditions": [
  ...,
  {
    "type": "dynamic_veins:density_threshold",
    "input": {
      "type": "minecraft:noise",
      "noise": "minecraft:ore_veininess",
      "xz_scale": 10.0,
      "y_scale": 10.0
    },
    "max_threshold": 0.7
  }
]
```

原理：用低频噪声采样，小于 0.7 才生成，等效于 70% 的矿脉出现概率。

---

### 4. 按高度段分层

通过 `height_range` 条件，可以将不同矿脉限制在特定 Y 层。例如：

```json
"min_inclusive": { "absolute": -64 },
"max_inclusive": { "absolute": -1 }
```

高度段不相交的矿脉之间**不会发生冲突**，因为它们永远不会在同一位置同时满足条件。这让你可以在一个网格单元内，根据高度放置不同种类的矿脉（如浅层铜、深层铁）。

---

### 5. 实际调整流程示例

1. **确定想要的矿脉密度**：假设希望每 4 区块出现一个矿脉，设置 `denominator: 64`、`argument2: 32`。
2. **确定矿团尺寸**：希望矿团为 15×15，设置 `min_exclusive: -7.0`、`max_inclusive: 7.0`。
3. **检查尺寸与间距比例**：15 / 64 ≈ 0.23，小于 0.5，安全。

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