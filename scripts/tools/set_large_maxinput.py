"""把 config/techreborn/machines.json 里所有 large_* 机器的 MaxInput 改成 8192 EU/t（1A IV）。

用定向文本替换而不是 json.dump 重写：NightConfig 把 '>' 转义成 \\u003e，
而 Python 的 json.dump 不会，整份重写会产生大量无关 diff。
"""
import json
import re
import shutil
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
CFG = ROOT / "config/techreborn/machines.json"
TARGET = 8192


def main() -> int:
    raw = CFG.read_text(encoding="utf-8")
    d = json.loads(raw)

    # 找出所有 large_* 机器及其 MaxInput 字段名
    targets = {}
    for key, fields in d.items():
        if not key.startswith("large_"):
            continue
        for fname in fields:
            if fname.endswith("MaxInput"):
                targets[key] = (fname, fields[fname]["value"])

    print("将修改 %d 台 large_* 机器：\n" % len(targets))
    text = raw
    for key in sorted(targets):
        fname, old = targets[key]
        pat = re.compile(
            r'("%s"\s*:\s*\{\s*"comment"\s*:\s*"[^"]*"\s*,\s*"value"\s*:\s*)(-?\d+)'
            % re.escape(fname))
        hits = pat.findall(text)
        if len(hits) != 1:
            print(f"  !! {fname} 匹配 {len(hits)} 处，预期 1")
            return 1
        text = pat.sub(lambda m: m.group(1) + str(TARGET), text, count=1)
        print("  %-26s %-42s %6s -> %d" % (key, fname, old, TARGET))

    # 校验
    after = json.loads(text)
    bad = 0
    for key in sorted(targets):
        fname = targets[key][0]
        got = after[key][fname]["value"]
        if got != TARGET:
            print(f"  !! {key}.{fname} = {got}")
            bad += 1

    # 确认除目标行外无任何改动
    if len(raw.splitlines()) != len(text.splitlines()):
        print("!! 行数变化，未写入")
        return 1
    diff = [i for i, (a, b) in enumerate(zip(raw.splitlines(), text.splitlines())) if a != b]
    print(f"\n改动行数 = {len(diff)}（预期 {len(targets)}）")
    if bad or len(diff) != len(targets):
        print("未写入")
        return 1

    shutil.copyfile(CFG, CFG.with_suffix(".json.bak_maxinput"))
    CFG.write_text(text, encoding="utf-8")
    print(f"已写入 {CFG}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
