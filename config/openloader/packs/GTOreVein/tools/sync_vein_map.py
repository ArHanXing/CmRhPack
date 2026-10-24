#!/usr/bin/env python3
"""
把 data/gt_veins/worldgen/ore_vein/*.json 的当前内容同步进 vein_map.html。

用法（在整合包 minecraft 目录下）：
    python3 config/openloader/packs/GTOreVein/tools/sync_vein_map.py

做的事：
  1. 读取所有矿脉 JSON：维度、主/次矿、次矿占比、球心 Yc、半径 R、Y 范围、类型切片阈值 lo/hi
  2. 按维度分组，组内按文件名排序（与数据包写入切片时的顺序一致）
  3. 校验每维度切片是否无缝铺满 [-21,21)：报告间隙/重叠/覆盖率（有间隙 = 该维度存在空矿格）
  4. 重写 vein_map.html 中 `// === VEIN DATA BEGIN/END ===` 之间的数据块
"""
import json
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
PACK = os.path.dirname(HERE)
MC_ROOT = os.path.abspath(os.path.join(PACK, "..", "..", "..", ".."))
VEIN_DIR = os.path.join(PACK, "data", "gt_veins", "worldgen", "ore_vein")
HTML = os.path.join(PACK, "vein_map.html")
DIM_KEY = {
    "minecraft:overworld": "overworld",
    "minecraft:the_nether": "nether",
    "minecraft:the_end": "end",
    "eternal_starlight:starlight": "starlight",
}
DIM_ORDER = ["overworld", "nether", "end", "starlight"]
DIM_LABEL = {
    "overworld": "主世界", "nether": "下界", "end": "末地",
    "starlight": "星光（DOV 不生效，仅参考）",
}
HASH_LO, HASH_HI = -21.0, 21.0


def load():
    data = {}
    if not os.path.isdir(VEIN_DIR):
        sys.exit(f"找不到矿脉目录: {VEIN_DIR}")
    for fn in sorted(os.listdir(VEIN_DIR)):
        if not fn.endswith(".json"):
            continue
        with open(os.path.join(VEIN_DIR, fn), encoding="utf-8") as f:
            d = json.load(f)
        raw = d.get("dimension")
        dim = raw[0] if isinstance(raw, list) else raw
        dim = DIM_KEY.get(dim, dim)
        conds = d.get("conditions", {}).get("conditions", [])
        gate = next((c for c in conds if c.get("type") == "dynamic_veins:density_threshold"), None)
        hr = next((c for c in conds if c.get("type") == "dynamic_veins:height_range"), None)
        tog = d["vein_toggle"]
        data.setdefault(dim, []).append({
            "n": fn[:-5],
            "ore": d["ore"],
            "sec": d["secondary_ore"],
            "pct": round(float(d.get("secondary_ore_chance", 0.3)), 4),
            "yc": float(tog["input"]["point1"][1]["argument2"]),
            "r": float(tog["max_exclusive"]),
            "lo": float(gate["min_threshold"]) if gate else HASH_LO,
            "hi": float(gate["max_threshold"]) if gate else HASH_HI,
            "y0": hr["min_inclusive"]["absolute"] if hr else None,
            "y1": hr["max_inclusive"]["absolute"] if hr else None,
            "grid": float(tog["input"]["point1"][0]["argument1"]["denominator"]),
        })
    return data


def js_num(v):
    s = repr(round(float(v), 10))
    return s if ("." in s or "e" in s) else s + ".0"


def build_block(data):
    out = ["// === VEIN DATA BEGIN (由 tools/sync_vein_map.py 生成，请勿手改) ==="]
    out.append("const VEIN_DATA = {")
    ordered = [d for d in DIM_ORDER if d in data] + [d for d in data if d not in DIM_ORDER]
    for dim in ordered:
        items = data[dim]
        out.append(f'  {dim}: {{')
        out.append(f'    label: {json.dumps(DIM_LABEL.get(dim, dim), ensure_ascii=False)},')
        out.append("    veins: [")
        for it in items:
            out.append(
                "      { n: %s, ore: %s, sec: %s, pct: %s, lo: %s, hi: %s, yc: %s, r: %s },"
                % (json.dumps(it["n"]), json.dumps(it["ore"]), json.dumps(it["sec"]),
                   js_num(it["pct"]), js_num(it["lo"]), js_num(it["hi"]),
                   js_num(it["yc"]), js_num(it["r"])))
        out.append("    ],")
        out.append("  },")
    out.append("};")
    out.append("// === VEIN DATA END ===")
    return "\n".join(out)


def report(data):
    print(f"{'维度':<10} {'矿脉数':>6} {'覆盖':>8} {'空格率':>8}  状态")
    ordered = [d for d in DIM_ORDER if d in data] + [d for d in data if d not in DIM_ORDER]
    for dim in ordered:
        items = data[dim]
        iv = sorted((i["lo"], i["hi"], i["n"]) for i in items)
        covered = sum(max(0.0, min(b, HASH_HI) - max(a, HASH_LO)) for a, b, _ in iv)
        gaps = [(iv[j][2], iv[j][1], iv[j + 1][2], iv[j + 1][0])
                for j in range(len(iv) - 1) if iv[j][1] < iv[j + 1][0] - 1e-9]
        overlaps = [(iv[j][2], iv[j][1], iv[j + 1][2], iv[j + 1][0])
                    for j in range(len(iv) - 1) if iv[j][1] > iv[j + 1][0] + 1e-9]
        status = []
        if gaps:
            status.append(f"{len(gaps)} 处间隙(空矿格)")
        if overlaps:
            status.append(f"{len(overlaps)} 处重叠(需靠乱序决胜负)")
        if not status:
            status.append("无缝铺满")
        print(f"{dim:<10} {len(items):>6} {covered / 42 * 100:>7.1f}% "
              f"{(1 - covered / 42) * 100:>7.1f}%  " + "; ".join(status))
        for a, ah, b, bh in gaps:
            print(f"           间隙 {a}(末 {ah:+.2f}) → {b}(起 {bh:+.2f})")


def main():
    data = load()
    if not data:
        sys.exit("没有读到任何矿脉 JSON")
    total = sum(len(v) for v in data.values())
    grids = {it["grid"] for items in data.values() for it in items}
    if len(grids) > 1:
        print(f"⚠ 警告: 检测到多种网格步长 {sorted(grids)}，地图按 VEIN_DATA 阈值判定，网格 192 假设可能不成立")
    block = build_block(data)
    with open(HTML, encoding="utf-8") as f:
        html = f.read()
    pat = re.compile(r"// === VEIN DATA BEGIN.*?// === VEIN DATA END ===", re.S)
    if not pat.search(html):
        sys.exit("vein_map.html 里找不到 VEIN DATA 标记区间")
    with open(HTML, "w", encoding="utf-8") as f:
        f.write(pat.sub(lambda _: block, html))
    print(f"已同步 {total} 条矿脉 → vein_map.html\n")
    report(data)


if __name__ == "__main__":
    main()
