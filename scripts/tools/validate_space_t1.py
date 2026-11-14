"""Offline structural/economy check for CmRhSpaceT1; not a live registry test.

Checks actual JSON, priorities against installed TR samples, nested-JAR asset
IDs (including Cinderscapes), registered jsonreg IDs, stack budgets, exact
four-times balance, spacecraft returns, cell accounting and translations.
Assets are evidence of an ID, not a substitute for Minecraft registry loading.
Run: python3 scripts/tools/validate_space_t1.py
"""
import io
import json
import math
import re
import zipfile
from itertools import combinations
from pathlib import Path
import gen_space_t1 as G

ROOT, PACK = G.ROOT, G.PACK
checks = 0


def check(condition, message):
    global checks
    checks += 1
    if not condition:
        raise AssertionError(message)


def load(path):
    return json.loads(path.read_text(encoding="utf-8"))


def asset_ids():
    items, blocks = set(), set()
    def scan(z):
        for n in z.namelist():
            match = re.fullmatch(r"assets/([^/]+)/models/item/(.+)\.json", n)
            if match:
                items.add(f"{match[1]}:{match[2]}")
            match = re.fullmatch(r"assets/([^/]+)/blockstates/(.+)\.json", n)
            if match:
                blocks.add(f"{match[1]}:{match[2]}")
            if n.startswith("META-INF/jars/") and n.endswith(".jar"):
                with zipfile.ZipFile(io.BytesIO(z.read(n))) as nested:
                    scan(nested)
    for jar in (ROOT / "mods").glob("*.jar"):
        with zipfile.ZipFile(jar) as z:
            scan(z)
    jr = load(ROOT / "config/jsonreg_entries.json")
    items.update("jsonreg:" + e["id"] for e in jr["items"] + jr["blocks"])
    blocks.update("jsonreg:" + e["id"] for e in jr["blocks"])
    # Vanilla resource assets are not under mods; this is the explicit small set used.
    vanilla_blocks = {"coal_ore", "copper_ore", "diamond_ore", "emerald_ore", "gold_ore", "iron_ore",
                      "lapis_ore", "redstone_ore", "nether_quartz_ore", "ancient_debris", "gilded_blackstone",
                      "amethyst_cluster", "end_stone", "polished_basalt", "yellow_terracotta", "red_sand",
                      "stone", "glowstone", "moss_block"}
    blocks.update("minecraft:" + x for x in vanilla_blocks)
    items.update("minecraft:" + x for x in vanilla_blocks)
    items.update({"minecraft:redstone", "minecraft:diamond", "minecraft:iron_ingot"})
    # techreborn:cell is a dynamically-modelled item (cell_base/cell_background),
    # so it has no models/item/cell.json. It is used 297 times in the live dump.
    items.add("techreborn:cell")
    return items, blocks


def require_keys(obj, allowed, required, path):
    check(not set(obj) - set(allowed), f"{path}: unknown keys {set(obj)-set(allowed)}")
    check(set(required) <= set(obj), f"{path}: missing keys {set(required)-set(obj)}")


def stacks(stacks, maximum, items, path, key="item"):
    check(len(stacks) <= maximum, f"{path}: inventory entries exceed {maximum}")
    for s in stacks:
        item = s[key]
        check(item in items, f"{path}: no installed item evidence for {item}")
        check(type(s.get("count", 1)) is int and s.get("count", 1) > 0, f"{path}: invalid count")
        check("naquadria" not in item and "neutron" not in item, f"{path}: excluded resource {item}")
        check(not s.get("components"), f"{path}: unexpected components in mission stack")


def main():
    items, blocks = asset_ids()
    meta = load(PACK / "pack.mcmeta")
    check(meta["pack"]["pack_format"] == 48, "1.21 data pack format")
    check("filter" not in meta, "override pack must not declare a filter section")
    bodies = {"sol:" + p.stem: load(p) for p in (PACK / "data/sol/techreborn/planet").glob("*.json")}
    check(set(bodies) == {"sol:" + x for x in [*G.BODIES, "sun", "earth"]}, "seven-body catalogue")
    translations = [load(PACK / f"assets/cmrh/lang/{locale}.json") for locale in ("zh_cn", "en_us")]
    resource_map = {}
    for identifier, body in bodies.items():
        require_keys(body, ["type", "tier", "system", "from_system", "parent", "sort_order", "display", "marker_block",
                            "marker_scale", "time", "physical", "missions", "resources", "visibility", "dimension", "tags"],
                     ["type", "tier", "system", "from_system", "parent", "display", "marker_block", "time", "physical", "missions"], identifier)
        check(body["tier"] == 1 and body["system"] == "sol", identifier + " tier/system")
        check(body["from_system"] == "sol:sun", identifier + " star")
        check(body["parent"] is None or body["parent"] in bodies, identifier + " missing parent")
        seen = set()
        node = identifier
        while node is not None:
            check(node not in seen, identifier + " orbital cycle")
            seen.add(node)
            node = bodies[node]["parent"]
        check(body["marker_block"] in blocks, identifier + " invalid marker " + body["marker_block"])
        check(math.isfinite(body["marker_scale"]) and body["marker_scale"] > 0, identifier + " marker scale")
        for key, value in body["physical"].items():
            if key != "orbit_features":
                check(type(value) in (int, float) and math.isfinite(value), identifier + " physical " + key)
        if body["parent"]:
            check(body["physical"]["orbit_radius_au"] > 0, identifier + " positive orbit radius")
        # name_key reuses a key TR already ships in both locales.
        check(body["display"]["name_key"] == "gui.techreborn.space.body." + identifier.split(":")[1],
              identifier + " name key must reuse TR's built-in body key")
        for lang in translations:
            check(body["display"]["description_key"] in lang,
                  identifier + " missing description translation")
        ids = set()
        for ore in body["resources"]:
            require_keys(ore, ["id", "item", "count", "components", "order"], ["id", "item", "count"], identifier)
            check(ore["id"] not in ids, identifier + " duplicate resource")
            ids.add(ore["id"])
            stacks([ore], 1, items, identifier + "/resources")
            check(ore["item"] in blocks, identifier + " resource must be a block")
            check("budding" not in ore["item"], identifier + " renewable budding block forbidden")
            item, baseline, source = G.ORES[ore["id"]]
            check(item == ore["item"] and ore["count"] == baseline * 2, identifier + " resource balance")
            check((ore["count"] / body["time"]) / (baseline / G.DRILL_TICKS) == 4,
                  identifier + " exact 4x baseline")
            resource_map[ore["id"]] = ore
        for phase, mission in body["missions"].items():
            allowed = ["enabled", "requires_landing", "variants"] if phase == "mining" else ["enabled", "time", "variants"]
            require_keys(mission, allowed, ["enabled"], identifier + "/" + phase)
            if not mission["enabled"]:
                check(identifier in {"sol:sun", "sol:earth"}, identifier + " unexpected disabled mission")
                continue
            check(mission.get("time", body["time"]) > 0, identifier + " mission time")
            check([v["tier"] for v in mission["variants"]] == [1, 2, 3], identifier + " explicit three equipment tiers")
            for v in mission["variants"]:
                require_keys(v, ["tier", "inputs", "outputs"], ["tier", "inputs", "outputs"], identifier + "/variant")
                stacks(v["inputs"], 4 if phase == "mining" else 9, items, identifier + "/inputs")
                stacks(v["outputs"], 6 if phase == "mining" else 9, items, identifier + "/outputs")
                check(all(s["count"] <= 64 for s in v["inputs"] + v["outputs"]), identifier + " physical input stacks")
                tier = v["tier"]
                kind = "probe" if phase == "survey" else "drone" if phase == "mining" else "lander"
                craft = f"techreborn:space_{kind}_mk{tier}"
                check(v["inputs"][0] == G.stack(craft + "_powered"), identifier + " powered spacecraft required")
                check(v["outputs"] == [G.stack(craft)], identifier + " exact spacecraft return")
                if phase == "outpost":
                    check(G.stack(f"techreborn:core_mk{tier}") in v["inputs"], identifier + " consume correct-tier core")
            if phase == "mining":
                check(mission["requires_landing"], identifier + " landing required")
                check(body["missions"]["land"]["enabled"] and body["missions"]["outpost"]["enabled"], identifier + " stage dependencies")
                # All combinations: 3 ore stacks + one returned drone fit six outputs.
                for chosen in combinations(body["resources"], min(3, len(body["resources"]))):
                    slots = 1 + sum(math.ceil(x["count"] / 64) for x in chosen)
                    check(slots <= 6, identifier + " mining output overflow")
                check(body["time"] // 16 >= 1, identifier + " T3 time positive")
    check(set(resource_map) == set(G.ORES), "ore coverage incomplete")
    tr = next((ROOT / "mods").glob("TechReborn-*.jar"))
    with zipfile.ZipFile(tr) as z:
        for n in z.namelist():
            if n.startswith("data/sol/techreborn/planet/") and n.endswith(".json"):
                check((PACK / n).is_file(), "TR built-in body not overridden: " + n)
    zs = (ROOT / "scripts/space_t1_recipes.zs").read_text(encoding="utf-8")
    import sys
    sys.path.insert(0, str(ROOT / "scripts/tools"))
    import audit_recipes as A
    text = A.L.strip_comments(zs)
    found = {n: b for n, b in A.L.iter_recipes(text)}
    check(len(found) == 10, f"expected 4 fabrication + 6 refuelling recipes, got {len(found)}")
    for name, body in found.items():
        ty = re.search(r'type:\s*"([^"]+)"', body).group(1)
        check(ty in {"techreborn:space_elevator_assembler", "techreborn:precise_assembler"}, name)
        power = int(re.search(r'power:\s*(\d+)', body).group(1))
        time = int(re.search(r'time:\s*(\d+)', body).group(1))
        check(power == 512 and time > 0, name + " HV recipe")
        for item in re.findall(r'item:\s*"([^"]+)"', body):
            check(item in items or item == "techreborn:cell", name + " ingredient " + item)
        for out in re.findall(r'id:\s*"([^"]+)"', body):
            check(out in items or out == "techreborn:cell", name + " output " + out)
        if "powered" in body and "drone_mk1_powered" in body or "probe_mk1_powered" in body or "lander_mk1_powered" in body:
            if time == 100:
                check("jsonreg:rocket_fuel_rp1" in body or "jsonreg:rocket_fuel_methane" in body, name + " fuel")
                check("fabric:type" in body, name + " exact fluid matcher")
                check("minecraft:empty" in body, name + " return empty cell")
    check('removeByName("techreborn:space_elevator_assembler/test")' in zs, "legacy assembler test not removed")
    check('removeByName("techreborn:space_elevator_miner/test")' in zs, "legacy miner test not removed")
    print(f"PASS {checks} checks: seven bodies, {len(resource_map)} resources, three equipment tiers, 10 recipes, slot budgets, nested-JAR IDs, translations, 4x baseline.")
    print("LIMIT: static asset/JSON verification; Minecraft/Fabric registry codecs and in-game pack priority still need a client/server load.")


if __name__ == "__main__":
    main()
