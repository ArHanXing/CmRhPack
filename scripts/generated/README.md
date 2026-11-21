# scripts/generated/ —— 自动生成脚本区

本目录下的 `.zs` **全部由 `scripts/tools/` 里的 Python 生成器产出，请勿手改**。
改了会在下次重跑生成器时被覆盖。

## 文件 ↔ 生成器

| 产物 | 生成器 | 说明 |
|---|---|---|
| `grinder_parity.zs` | `tools/grind_parity_gen.py` | OR 粉碎机 ↔ TR 磨粉机配方互通（仅 1 输出配方） |
| `large_machine_compat.zs` | `tools/gen_large_machine_compat.py` | OR 流体离心/精炼厂 → TR 大搅拌机/大精炼厂 |
| `assembler_compat.zs` | `tools/gen_assembler_compat.py` | OR 装配机 → TR 精密组装机（0.8× 耗时） |
