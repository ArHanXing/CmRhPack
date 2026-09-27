"""新增下界氟石矿脉，并把下界 6 条矿脉重算为 42/6 = 7 的等宽切片。

切片机制（与 vein_map.html 的 veinOf() 一致）：
  k = floor(x/192), m = floor(z/192)
  h = frac(sin(127.1k + 311.7m) * 43758.5453) * 42 - 21   ∈ [-21, 21)
  维度内 N 条矿脉等分 42，第 i 条占 [ -21 + i*42/N, -21 + (i+1)*42/N )

下界原先 5 条（w=8.4），加入氟石后 6 条（w=7），故 5 条老脉的阈值必须整体重算。
⚠ 老脉概率由 1/5 降为 1/6。
"""
import json
import re
import shutil
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
VEINS = ROOT / "config/openloader/packs/GTOreVein/data/gt_veins/worldgen/ore_vein"

# 顺序即切片顺序，氟石追加在末尾（对老脉顺序扰动最小）
ORDER = [
    "nether_cinnabar",
    "nether_pyrite",
    "nether_quartz",
    "nether_rose_quartz",
    "nether_sphalerite",
    "nether_fluorite",
]

THRESH = re.compile(r'("min_threshold":\s*)(-?[\d.]+)(,\s*"max_threshold":\s*)(-?[\d.]+)')


def slices(n):
    w = 42.0 / n
    return [(-21.0 + i * w, -21.0 + (i + 1) * w) for i in range(n)]


def main() -> int:
    bounds = slices(len(ORDER))
    print(f"{len(ORDER)} 条矿脉，每条宽度 {42.0/len(ORDER):.4f}")
    for name, (lo, hi) in zip(ORDER, bounds):
        print(f"  {name:<22} [{lo:>7.3f}, {hi:>6.3f})")

    # ---------- 1. 以辰砂脉为模板生成氟石脉 ----------
    new_path = VEINS / "nether_fluorite.json"
    if not new_path.is_file():
        shutil.copyfile(VEINS / "nether_cinnabar.json", new_path)
        print(f"\n以 nether_cinnabar.json 为模板创建 {new_path.name}")

    # ---------- 2. 重算 6 条脉的阈值 ----------
    for name, (lo, hi) in zip(ORDER, bounds):
        p = VEINS / f"{name}.json"
        if not p.is_file():
            print(f"!! 缺失 {p.name}")
            return 1
        text = p.read_text(encoding="utf-8")
        hits = THRESH.findall(text)
        if len(hits) != 1:
            print(f"!! {p.name} 匹配到 {len(hits)} 处阈值，预期 1 处")
            return 1
        text = THRESH.sub(lambda m: f"{m.group(1)}{lo}{m.group(3)}{hi}", text, count=1)
        p.write_text(text, encoding="utf-8")

    # ---------- 3. 改写氟石脉的矿石与副矿 ----------
    d = json.loads(new_path.read_text(encoding="utf-8"))
    d["ore"] = "jsonreg:nether_fluorite_ore"
    d["secondary_ore"] = "jsonreg:rock_salt_ore"     # 岩盐：氟石-岩盐是真实共生组合，
    d["secondary_ore_chance"] = 0.4                  # 且盐粉正是 T1.5b 析出步的试剂
    new_path.write_text(json.dumps(d, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")

    # ---------- 4. 复核 ----------
    print()
    ok = True
    for name, (lo, hi) in zip(ORDER, bounds):
        txt = (VEINS / f"{name}.json").read_text(encoding="utf-8")
        m = THRESH.search(txt)
        got = (float(m.group(2)), float(m.group(4)))
        exp = (round(lo, 6), round(hi, 6))
        flag = "✓" if (round(got[0], 6), round(got[1], 6)) == exp else "✗"
        if flag == "✗":
            ok = False
        j = json.loads(txt)
        print(f"  {flag} {name:<22} 阈值 [{got[0]:>7.3f}, {got[1]:>6.3f})  ore={j['ore']}")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
