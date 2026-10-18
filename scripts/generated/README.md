# scripts/generated/ —— 自动生成脚本区

本目录下的 `.zs` **全部由 `scripts/tools/` 里的 Python 生成器产出，请勿手改**。
改了会在下次重跑生成器时被覆盖。

CraftTweaker 用 `Files.walkFileTree(..., Integer.MAX_VALUE, ...)` + `glob:**.zs`
递归扫描 `scripts/`，所以本目录会被正常加载，不需要额外配置。

## 文件 ↔ 生成器

| 产物 | 生成器 | 说明 |
|---|---|---|
| `grinder_parity.zs` | `tools/grind_parity_gen.py` | OR 粉碎机 ↔ TR 磨粉机配方互通（仅 1 输出配方） |
| `large_machine_compat.zs` | `tools/gen_large_machine_compat.py` | OR 流体离心/精炼厂 → TR 大搅拌机/大精炼厂 |
| `assembler_compat.zs` | `tools/gen_assembler_compat.py` | OR 装配机 → TR 精密组装机（0.8× 耗时） |

## 重跑

```bash
python3 scripts/tools/grind_parity_gen.py
python3 scripts/tools/gen_large_machine_compat.py
python3 scripts/tools/gen_assembler_compat.py
```

⚠️ **`grind_parity_gen.py` 读的是 `scripts/!recipedump.txt`（易变快照）**，
重跑前先确认 dump 是最新的，否则会按旧状态生成。
`gen_large_machine_compat.py` 同样读 dump。
`gen_assembler_compat.py` 读的是 **Oritech jar 内的配方 JSON**（权威，不受 dump 影响）。

## 没搬进来的

`general_ore_process.zs` 虽然也被 `gen_t15_recipes.py` / `gen_t2_recipes.py` 改写，
但它**大部分是手写骨架**（生成器只替换其中的 T1.5 / T2 段落），因此留在 `scripts/` 根目录。
搬它会让人误以为整个文件都是生成物。
