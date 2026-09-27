"""把氟石 → 氟化学的两条配方**追加**到 scripts/t2.zs 末尾。

用追加模式（open "a"）而不是整体重写：t2.zs 正被人类同时编辑，
重写会用陈旧快照覆盖掉对方的改动。
"""
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
ZS = ROOT / "scripts/t2.zs"

MARK = "t2.tr.chemical_reactor/hf_from_fluorite"

BLOCK = '''
// ============================================================
// 氟石 → 氟化学（矿处见 general_ore_process.zs 的 T1 / T1.5）
// ============================================================
// 背景：本包此前**没有独立氟源** —— 氟与氢氟酸只能从超能硅岩线自身的副产
//   里回收（nqdria.4a、nqdh.5b），而 nqdria.3 的氢氟酸浸出一次就吃 10B，
//   是典型的鸡生蛋死锁。下界氟石矿脉 nether_fluorite 补上了这个源头。
//
// 工艺链（两步，并让硫闭环）：
//   ① 氟石粉 + 硫酸 → 氢氟酸 + 石膏粉              CaF₂ + H₂SO₄ → 2HF + CaSO₄
//   ② 石膏粉 →(电高炉煅烧)→ 氧化钙渣 + 三氧化硫     CaSO₄ → CaO + SO₃
//      SO₃ 再走既有的 oil.other.so3_to_h2so4 回到硫酸，抵消 ① 的硫酸消耗。
// ② 顺带给**只注册、零产线**的 jsonreg:calcium_oxide_slag (CaO) 补上来源。
//
// 注：① 的化学计量是 CaF₂ + H₂SO₄ → **2**HF + CaSO₄，但普通化反只有 2 个输出槽，
//   而石膏必须占一个，故按 1:1 压缩（与本包其它反应的槽位妥协一致）。
//   真要多出氟，走 T1.5 的 ×3 粉即可。

// ① 氢氟酸 (TR 化反, 2 进 2 出)
<recipetype:techreborn:chemical_reactor>.addJsonRecipe("t2.tr.chemical_reactor/hf_from_fluorite", {type: "techreborn:chemical_reactor",
    time: 200,
    power: 128,
    outputs: [
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:hydrofluoric_acid"}},
        {id: "jsonreg:calcium_sulfate_dust", count: 1}
    ],
    ingredients: [
        {item: "jsonreg:fluorite_dust", count: 1},
        {count: 1, components: {"techreborn:fluid": "oritech:still_sulfuric_acid"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});

// ② 石膏煅烧 (TR 电高炉)
<recipetype:techreborn:blast_furnace>.addJsonRecipe("t2.tr.blast_furnace/gypsum_calcination", {type: "techreborn:blast_furnace",
    time: 400,
    heat: 1500,
    power: 128,
    outputs: [
        {id: "jsonreg:calcium_oxide_slag", count: 1},
        {id: "techreborn:cell", count: 1, components: {"techreborn:fluid": "jsonreg:sulfur_trioxide"}}
    ],
    ingredients: [
        {item: "jsonreg:calcium_sulfate_dust", count: 1},
        {count: 1, components: {"techreborn:fluid": "minecraft:empty"}, base: {item: "techreborn:cell"}, "fabric:type": "fabric:components"}
    ]
});
'''


def main() -> int:
    text = ZS.read_text(encoding="utf-8")
    if MARK in text:
        print("已存在，跳过")
        return 0

    before = len(text)
    with ZS.open("a", encoding="utf-8", newline="") as f:
        if not text.endswith("\n"):
            f.write("\n")
        f.write(BLOCK)

    after = ZS.read_text(encoding="utf-8")
    if MARK not in after:
        print("!! 追加失败")
        return 1
    print(f"已追加 {len(after) - before} 字符到 {ZS.name}")
    print(f"  新增配方: t2.tr.chemical_reactor/hf_from_fluorite")
    print(f"            t2.tr.blast_furnace/gypsum_calcination")
    return 0


if __name__ == "__main__":
    sys.exit(main())
