"""校验一个 .zs 里引用的所有物品/流体 ID 是否真实存在。

- jsonreg:*       -> 查 config/jsonreg_entries.json
- 其他命名空间    -> 查 /ct dump（!recipedump.txt）里出现过的 id
用于在无法开游戏时提前抓出拼写错误。
"""
import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
DUMP = ROOT / "scripts/!recipedump.txt"


def known_namespaces() -> set:
    """dump 里出现过的所有 `ns:path` 字符串。"""
    txt = DUMP.read_text(encoding="utf-8", errors="ignore")
    return set(re.findall(r'"([a-z0-9_]+:[a-z0-9_/]+)"', txt))


def main(paths) -> int:
    reg = json.loads((ROOT / "config/jsonreg_entries.json").read_text(encoding="utf-8"))
    jr = {e["id"] for k in reg for e in reg[k]}
    ns = known_namespaces()

    bad = 0
    for rel in paths:
        p = ROOT / rel
        text = p.read_text(encoding="utf-8")
        ids = set(re.findall(r'"((?:jsonreg|techreborn|oritech|minecraft):[a-z0-9_/]+)"', text))
        ids |= set(re.findall(r'<(?:item|block|fluid):([a-z0-9_]+:[a-z0-9_/]+)>', text))
        print(f"=== {rel}  引用 {len(ids)} 个 ID ===")
        for i in sorted(ids):
            ok = (i.split(":")[1] in jr) if i.startswith("jsonreg:") else (i in ns)
            if not ok:
                print("   ✗ 未找到:", i)
                bad += 1
        print(f"   {'全部存在 ✓' if not bad else ''}")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:] or ["scripts/nuclear_fuel.zs"]))
