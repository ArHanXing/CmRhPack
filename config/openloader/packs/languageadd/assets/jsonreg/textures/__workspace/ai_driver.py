#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""ai_driver.py —— 给 LLM 用的极薄驱动层

assetsgen.py / another_assetsgen.py / genfluid.py **保持零改动**。
它们本身逻辑很简单，只是有两个对 LLM 不友好的地方：
  1. 交互式：按顺序 input() 读 stdin（类别 / N 个子材质 / 色号 / 逐个新名）；
  2. 假成功：校验失败走 `return` 而非 sys.exit(1)，退出码恒为 0。
本文件只做四件事：拼 stdin → 调 subprocess → 按「应产出哪些文件」校验 → 真退出码。
外加一个 Windows 专属补丁：经管道/重定向捕获时强制 UTF-8，否则中文提示乱码
（Kubuntu 无此问题，故原脚本没考虑）。

用法（一条命令一次生成，不需要写任何表格 / 清单 / 候选目录）：

  python ai_driver.py item  <类别> <色号> <子材质[=新名]> [<子材质[=新名]> ...] [--overlay]
  python ai_driver.py fluid <色号> <thick|thin> <新名> [<新名> ...]
  python ai_driver.py list  [类别]

例：
  python ai_driver.py item metallic e4007f ingot=naquadah_ingot plate=naquadah_plate
  python ai_driver.py item metallic e4007f ingot          # 不写 =新名 就用原名，便于先看效果
  python ai_driver.py item shiny  e4007f ingot --overlay  # 叠 overlay（走 another_assetsgen.py）
  python ai_driver.py fluid e4007f thick argon
  python ai_driver.py list metallic

通用开关：
  --force     产物已存在也重新生成（默认跳过已齐的）
  --dry-run   只打印将做什么
  --install   顺手复制进资源树（item → textures/item，fluid → textures/block）

想挑观感：换新名多生成几份（如 `ingot=nq_a` / `ingot=nq_b`），对着 textures/ 里的 png 挑，
挑中的名字再跑一次即可 —— 所以这里不需要候选/清单那套东西。
"""
from __future__ import annotations

import argparse
import os
import re
import shutil
import subprocess
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
ASSETSGEN = HERE / "assetsgen.py"
ANOTHER = HERE / "another_assetsgen.py"
GENFLUID = HERE / "genfluid.py"

MATERIAL_SET = HERE / "material_set"
STAGE_TEX = HERE / "textures"                 # 原脚本的落盘位置
STAGE_MOD = HERE / "models"

ASSETS_ROOT = HERE.parent.parent              # .../assets/jsonreg
# 注意：HERE 是 .../jsonreg/textures/__workspace，所以要上跳两级才是 jsonreg。
# 上一级是 textures，写成 HERE.parent 会装到 textures/textures/ 去。
ITEM_DEST = ASSETS_ROOT / "textures" / "item"
# 仓库现状：流体 still/flow 都在 textures/block/（如 desalted_crude_flow.png），
# 而原脚本写的是 textures/fluid/。安装时按仓库现状走。
FLUID_DEST = ASSETS_ROOT / "textures" / "block"

SUFFIXES = ("", "_overlay", "_secondary")


# ── 环境 ──────────────────────────────────────────────────────────────────────
def bootstrap_encoding() -> None:
    """真控制台交给 Python 自己处理（Windows 走 WriteConsoleW，本来就对）；
    被管道/重定向捕获时才强制 UTF-8，免得按 GBK 解码成乱码。"""
    for stream in (sys.stdout, sys.stderr):
        try:
            if not stream.isatty():
                stream.reconfigure(encoding="utf-8", errors="replace")
        except Exception:
            pass


def run_script(script: Path, argv: list[str] | None = None, stdin_text: str | None = None):
    env = dict(os.environ, PYTHONIOENCODING="utf-8", PYTHONUTF8="1")
    return subprocess.run(
        [sys.executable, str(script), *(argv or [])],
        input=stdin_text, text=True, encoding="utf-8", errors="replace",
        capture_output=True, env=env, cwd=str(HERE),
    )


# ── material_set 查询 ─────────────────────────────────────────────────────────
def categories() -> list[str]:
    if not MATERIAL_SET.is_dir():
        return []
    return sorted(p.name for p in MATERIAL_SET.iterdir() if p.is_dir() and p.name != "__models")


def subs_of(cat: str) -> list[str]:
    d = MATERIAL_SET / cat
    if not d.is_dir():
        return []
    names = set()
    for f in d.glob("*.png"):
        n = f.stem.lower()
        for sfx in ("_overlay", "_secondary"):
            if n.endswith(sfx):
                n = n[: -len(sfx)]
                break
        names.add(n)
    return sorted(names)


def variants_of(cat: str, sub: str) -> list[str]:
    return [s for s in SUFFIXES if (MATERIAL_SET / cat / f"{sub}{s}.png").exists()]


# ── 应产出哪些文件（替代原脚本不可靠的退出码）────────────────────────────────
def expected_item(cat: str, sub: str, name: str, overlay: bool) -> list[Path]:
    v = variants_of(cat, sub)
    out = [STAGE_TEX / "item" / f"{name}{s}.png" for s in v]
    out += [STAGE_TEX / "item" / f"{name}{s}.png.mcmeta" for s in v
            if (MATERIAL_SET / cat / f"{sub}{s}.png.mcmeta").exists()]
    if not overlay and (MATERIAL_SET / "__models" / cat / f"{sub}.json").exists():
        out.append(STAGE_MOD / "item" / f"{name}.json")
    return out


def expected_fluid(name: str, thick: bool) -> list[Path]:
    src = MATERIAL_SET / "fluid"
    pre = "thick" if thick else "thin"
    out: list[Path] = []
    for kind in ("still", "flow"):
        if not (src / f"{pre}_fluid_{kind}.png").exists():
            continue
        out.append(STAGE_TEX / "fluid" / f"{name}_{kind}.png")
        if (src / f"{pre}_fluid_{kind}.png.mcmeta").exists():
            out.append(STAGE_TEX / "fluid" / f"{name}_{kind}.png.mcmeta")
    return out


# ── 输出与安装 ────────────────────────────────────────────────────────────────
def rel(p: Path) -> str:
    """统一用正斜杠输出，跨平台且方便 LLM 直接拿去当路径用。"""
    try:
        return p.relative_to(HERE).as_posix()
    except ValueError:
        return p.as_posix()


def last_error(proc) -> str:
    for line in reversed((proc.stdout or "").splitlines()):
        if "错误" in line or "Error" in line or "Traceback" in line:
            return line.strip()
    lines = [l.strip() for l in (proc.stdout or "").splitlines() if l.strip()]
    return lines[-1] if lines else "(脚本无输出)"


def install(files: list[Path], dest: Path) -> tuple[int, int]:
    """复制进资源树；.json 模型不装（YARRP 自动生成物品模型，且模板里写的是 gtceu: 路径）。"""
    tex = skipped = 0
    for src in files:
        if not src.exists():
            continue
        if src.suffix == ".json":
            skipped += 1
            continue
        dest.mkdir(parents=True, exist_ok=True)
        shutil.copy2(src, dest / src.name)
        print(f"  安装 {dest.name}/{src.name}")
        tex += 1
    return tex, skipped


def finish(files: list[Path], dest: Path | None, dry: bool) -> None:
    print("\n产出：")
    for p in files:
        print(f"  {rel(p)}")
    if dest is not None:
        if dry:
            print(f"\n（dry-run）将安装 {sum(1 for p in files if p.suffix != '.json')} 个文件 → {dest}")
        else:
            tex, skipped = install(files, dest)
            note = f"，跳过 {skipped} 个 .json 模型" if skipped else ""
            print(f"\n已安装 {tex} 个文件 → {dest}{note}")


# ── item ──────────────────────────────────────────────────────────────────────
def cmd_item(a) -> int:
    cat = a.category.strip().lower()
    if cat not in categories():
        raise SystemExit(f"[错误] 未知材质类别 '{cat}'；可用: {', '.join(categories())}")

    pairs: list[tuple[str, str]] = []
    for tok in a.pairs:
        if "=" in tok:
            sub, name = tok.split("=", 1)
        else:
            sub = name = tok
        sub, name = sub.strip().lower(), name.strip()
        if sub not in subs_of(cat):
            near = [s for s in subs_of(cat) if sub in s or s in sub][:6]
            hint = f"；相近的: {', '.join(near)}" if near else ""
            raise SystemExit(f"[错误] 类别 {cat} 下没有子材质 '{sub}'{hint}")
        pairs.append((sub, name))

    files: list[Path] = []
    for sub, name in pairs:
        files += expected_item(cat, sub, name, a.overlay)

    label = f"{'another_assetsgen' if a.overlay else 'assetsgen'} · {cat} · #{a.color.upper()} · " + \
            ", ".join(f"{s}→{n}" for s, n in pairs)
    print(f"[item] {label}")
    dest = (Path(a.dest) if a.dest else ITEM_DEST) if (a.install or a.dest) else None

    if not a.force and not [p for p in files if not p.exists()]:
        print("\n全部产物已存在，跳过生成（--force 可强制重生成）。")
        finish(files, dest, a.dry_run)
        return 0
    if a.dry_run:
        print("\n（dry-run）将产出：")
        for p in files:
            print(f"  {rel(p)}")
        return 0

    stdin_text = "\n".join([cat,
                            f"{len(pairs)} " + " ".join(s for s, _ in pairs),
                            a.color,
                            *[n for _, n in pairs]]) + "\n"
    proc = run_script(ANOTHER if a.overlay else ASSETSGEN, stdin_text=stdin_text)
    missing = [p for p in files if not p.exists()]
    if missing:
        print(f"\n[FAIL] 缺 {len(missing)}/{len(files)} 个产物：{', '.join(rel(p) for p in missing[:5])}")
        print(f"       脚本说：{last_error(proc)}")
        return 1
    finish(files, dest, a.dry_run)
    return 0


# ── fluid ─────────────────────────────────────────────────────────────────────
def cmd_fluid(a) -> int:
    state = a.state.strip().lower()
    if state not in ("thick", "thin"):
        raise SystemExit(f"[错误] state 只能是 thick / thin，收到 '{a.state}'")
    thick = state == "thick"

    all_files: list[Path] = []
    failed = 0
    for name in a.names:
        name = name.strip()
        files = expected_fluid(name, thick)
        if not files:
            print(f"[FAIL] {name}：material_set/fluid 下没有 {'thick' if thick else 'thin'}_fluid_* 模板")
            failed += 1
            continue
        print(f"[fluid] genfluid · {state} · #{a.color.upper()} · {name}")
        if not a.force and not [p for p in files if not p.exists()]:
            print("  已存在，跳过（--force 可强制重生成）")
            all_files += files
            continue
        if a.dry_run:
            print("  （dry-run）将产出：" + ", ".join(rel(p) for p in files))
            continue
        proc = run_script(GENFLUID, argv=[name, "1" if thick else "0", a.color])
        missing = [p for p in files if not p.exists()]
        if missing:
            print(f"  [FAIL] 缺 {len(missing)} 个产物：{', '.join(rel(p) for p in missing)}")
            print(f"         脚本说：{last_error(proc)}")
            failed += 1
            continue
        for p in files:
            print(f"  {rel(p)}")
        all_files += files

    if failed:
        return 1
    dest = (Path(a.dest) if a.dest else FLUID_DEST) if (a.install or a.dest) else None
    if dest is not None and all_files:
        if a.dry_run:
            print(f"\n（dry-run）将安装 {sum(1 for p in all_files if p.suffix != '.json')} 个文件 → {dest}")
        else:
            tex, _ = install(all_files, dest)
            print(f"\n已安装 {tex} 个文件 → {dest}")
    return 0


# ── list ──────────────────────────────────────────────────────────────────────
def cmd_list(a) -> int:
    if not a.category:
        cats = categories()
        print(f"material_set 共 {len(cats)} 个类别：")
        for c in cats:
            print(f"  {c:<16} {len(subs_of(c))} 个子材质")
        print("\n用 `ai_driver.py list <类别>` 看子材质。流体模板固定为 material_set/fluid/{thick,thin}_fluid_{still,flow}.png")
        return 0
    cat = a.category.strip().lower()
    if cat not in categories():
        raise SystemExit(f"[错误] 未知材质类别 '{cat}'；可用: {', '.join(categories())}")
    items = subs_of(cat)
    print(f"{cat}：{len(items)} 个子材质（ovl=有 _overlay，sec=有 _secondary，model=有模型模板）")
    for s in items:
        tags = [t for t, f in (("ovl", "_overlay"), ("sec", "_secondary")) if (MATERIAL_SET / cat / f"{s}{f}.png").exists()]
        if (MATERIAL_SET / "__models" / cat / f"{s}.json").exists():
            tags.append("model")
        print(f"  {s:<24} {' '.join(tags)}")
    return 0


# ── 入口 ──────────────────────────────────────────────────────────────────────
def main() -> int:
    bootstrap_encoding()
    doc = __doc__ or ""
    ap = argparse.ArgumentParser(
        prog="ai_driver.py",
        description="给 LLM 用的 jsonreg 材质生成驱动（包装原脚本，不改动它们）",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog=doc.split("用法（", 1)[1] if "用法（" in doc else None,
    )
    sub = ap.add_subparsers(dest="cmd", required=True)

    def common(p):
        p.add_argument("--force", action="store_true", help="产物已存在也重新生成")
        p.add_argument("--dry-run", action="store_true", help="只打印将做什么")
        p.add_argument("--install", action="store_true", help="复制进资源树")
        p.add_argument("--dest", default=None, help="--install 的目标目录（默认按类型决定）")
        return p

    p = common(sub.add_parser("item", help="物品材质：一个类别 + 一个色号 + N 个子材质"))
    p.add_argument("category", help="material_set 下的类别，如 metallic")
    p.add_argument("color", help="6 位十六进制色号，如 e4007f")
    p.add_argument("pairs", nargs="+", metavar="子材质[=新名]", help="如 ingot=naquadah_ingot")
    p.add_argument("--overlay", action="store_true", help="走 another_assetsgen.py（把 overlay 原样叠上）")
    p.set_defaults(func=cmd_item)

    p = common(sub.add_parser("fluid", help="流体材质：一个色号 + thick/thin + N 个新名"))
    p.add_argument("color", help="6 位十六进制色号")
    p.add_argument("state", help="thick 或 thin")
    p.add_argument("names", nargs="+", metavar="新名")
    p.set_defaults(func=cmd_fluid)

    p = sub.add_parser("list", help="列类别 / 某类别的子材质")
    p.add_argument("category", nargs="?", default=None)
    p.set_defaults(func=cmd_list)

    args = ap.parse_args()
    if getattr(args, "color", None) and not re.fullmatch(r"[0-9a-fA-F]{6}", args.color):
        raise SystemExit(f"[错误] 色号应为 6 位十六进制，收到 '{args.color}'")
    if getattr(args, "color", None):
        args.color = args.color.lower()
    return args.func(args)


if __name__ == "__main__":
    sys.exit(main())
