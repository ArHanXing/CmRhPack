"""Build CmRhPack's T1 solar-system catalogue (Minecraft 1.21.1).

Run from any directory: python3 scripts/tools/gen_space_t1.py
Only writes this pack's seven bodies, its two language files and pack.mcmeta.
Spacecraft recipes are independent hand-authored JSON under data/cmrh/recipe/.

Balance contract confirmed by the pack author:
- ordinary Oritech deep drill with ONE unupgraded laser arm (64 EU/t);
- 20 work steps * 1536 EU = 30,720 EU/batch => 480 ticks/batch;
- T1 outpost: 240 ticks and 2x corresponding batch count => 4x item rate;
- compare item counts only: ore-processing multiplication is deliberately extra;
- unbased mining uses Java's time*5 and count//5, not a second configurable rate.
No vanilla ore-processing assumption is applied to the mod-specific ores.
"""
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
PACK = ROOT / "config/openloader/packs/CmRhSpaceT1"
MINING_TICKS = 240
DRILL_TICKS = 480

# Stable resource IDs, representative ore blocks, baseline drill batch count.
# Entries without a deep-drill recipe use an explicit analogue, not a measured rate.
ORES = {
    "coal": ("minecraft:coal_ore", 16, "node:coal"),
    "copper": ("minecraft:copper_ore", 8, "node:copper"),
    "diamond": ("minecraft:diamond_ore", 8, "node:diamond"),
    "emerald": ("minecraft:emerald_ore", 6, "node:emerald"),
    "gold": ("minecraft:gold_ore", 8, "node:gold"),
    "iron": ("minecraft:iron_ore", 8, "node:iron"),
    "lapis": ("minecraft:lapis_ore", 16, "node:lapis"),
    "redstone": ("minecraft:redstone_ore", 16, "node:redstone"),
    "quartz": ("minecraft:nether_quartz_ore", 8, "analogue:common_mineral"),
    "ancient_debris": ("minecraft:ancient_debris", 12, "node:fossil"),
    "gilded_blackstone": ("minecraft:gilded_blackstone", 8, "analogue:gold"),
    "nickel": ("oritech:nickel_ore", 8, "node:nickel"),
    "platinum": ("oritech:deepslate_platinum_ore", 8, "node:platinum"),
    "uranium": ("oritech:deepslate_uranium_ore", 10, "node:uranium"),
    "bauxite": ("techreborn:bauxite_ore", 8, "node:bauxite"),
    "cinnabar": ("techreborn:cinnabar_ore", 8, "analogue:common_mineral"),
    "galena": ("techreborn:galena_ore", 8, "analogue:lead"),
    "iridium": ("techreborn:iridium_ore", 8, "node:iridium"),
    "lead": ("techreborn:lead_ore", 8, "node:lead"),
    "peridot": ("techreborn:peridot_ore", 8, "analogue:gem"),
    "pyrite": ("techreborn:pyrite_ore", 8, "analogue:common_mineral"),
    "ruby": ("techreborn:ruby_ore", 12, "node:gem"),
    "sapphire": ("techreborn:sapphire_ore", 12, "analogue:ruby"),
    "sheldonite": ("techreborn:sheldonite_ore", 8, "analogue:platinum"),
    "silver": ("techreborn:silver_ore", 16, "node:silver"),
    "sodalite": ("techreborn:sodalite_ore", 8, "analogue:common_mineral"),
    "sphalerite": ("techreborn:sphalerite_ore", 16, "node:sphalerite"),
    "tin": ("techreborn:tin_ore", 8, "node:tin"),
    "tungsten": ("techreborn:tungsten_ore", 8, "node:tungsten"),
    "oil_sand": ("jsonreg:oil_sand_ore", 8, "analogue:common_mineral"),
    "naquadah": ("jsonreg:end_naquadah_ore", 12, "node:naquadah"),
    "enriched_naquadah": ("jsonreg:end_enriched_naquadah_ore", 8, "analogue:rare_mineral"),
    "salt": ("jsonreg:salt_ore", 8, "analogue:common_mineral"),
    "rock_salt": ("jsonreg:rock_salt_ore", 8, "analogue:common_mineral"),
    "rutile": ("jsonreg:end_rutile_ore", 8, "analogue:common_mineral"),
    "fluorite": ("jsonreg:nether_fluorite_ore", 8, "analogue:common_mineral"),
    "vanadium_magnetite": ("jsonreg:nether_vanadium_magnetite_ore", 8, "analogue:iron"),
    "pyrolusite": ("jsonreg:nether_pyrolusite_ore", 8, "analogue:common_mineral"),
    "chromite": ("jsonreg:nether_chromite_ore", 8, "analogue:common_mineral"),
    "hausmannite": ("jsonreg:nether_hausmannite_ore", 8, "analogue:common_mineral"),
    "sulfur": ("cinderscapes:sulfur_ore", 8, "analogue:common_mineral"),
    "rose_quartz": ("cinderscapes:rose_quartz_ore", 8, "analogue:quartz"),
    "smoky_quartz": ("cinderscapes:smoky_quartz_ore", 8, "analogue:quartz"),
    "sulfur_quartz": ("cinderscapes:sulfur_quartz_ore", 8, "analogue:quartz"),
    "starcore": ("eternal_starlight:voidstone_starcore_ore", 8, "analogue:gem"),
    "starlit_diamond": ("eternal_starlight:voidstone_starlit_diamond_ore", 8, "analogue:diamond"),
    "deepsilver": ("eternal_starlight:voidstone_deepsilver_ore", 8, "analogue:common_mineral"),
    "malarite": ("eternal_starlight:voidstone_malarite_ore", 8, "analogue:common_mineral"),
    "saltpeter": ("eternal_starlight:voidstone_saltpeter_ore", 8, "analogue:common_mineral"),
    "thermal_springstone": ("eternal_starlight:thermal_springstone", 8, "analogue:common_mineral"),
    "dimslag": ("eternal_starlight:dimslag", 8, "analogue:common_mineral"),
    "peculiar_clump": ("affinity:peculiar_clump", 8, "analogue:common_mineral"),
    "amethyst": ("minecraft:amethyst_cluster", 8, "analogue:gem"),
    "thioquartz": ("eternal_starlight:thioquartz_cluster", 8, "analogue:quartz"),
    "red_starlight_crystal": ("eternal_starlight:red_starlight_crystal_cluster", 8, "analogue:gem"),
    "blue_starlight_crystal": ("eternal_starlight:blue_starlight_crystal_cluster", 8, "analogue:gem"),
}

# Mission materials are consumed only once per team/body/stage, spacecraft return.
# All entries <=64, all phases <=9 input entries. Cores are consumed at outposts.
BODIES = {
    "moon": {
        "name": ("月球", "Moon"), "type": "barren", "parent": "sol:earth", "order": 21,
        "marker": "minecraft:end_stone", "scale": 0.8,
        "physical": [1737.4, 0.00257, 42, 220, 655.728, 27.322],
        "description": (
            "地月运输线。铁、铜、锡与铝土构成首个工业补给站，另有金红石和晶洞资源。建立据点后可稳定回收三种选定矿物。",
            "The first Earth-Moon supply route: iron, copper, tin, bauxite, rutile and geode minerals. An outpost supports continuous extraction of up to three chosen resources."),
        "resources": "iron copper tin coal redstone lapis bauxite rutile salt amethyst".split(),
        "survey": [("jsonreg:mv_sensor", 2)],
        "land": [("techreborn:aluminum_plate", 16), ("jsonreg:steel_frame", 8)],
        "outpost": [("jsonreg:large_scale_assembling_casing", 16), ("jsonreg:steel_frame", 32),
                    ("techreborn:advanced_circuit", 16), ("techreborn:basic_solar_panel", 8),
                    ("techreborn:insulated_gold_cable", 32)],
    },
    "mercury": {
        "name": ("水星", "Mercury"), "type": "barren", "parent": "sol:sun", "order": 10,
        "marker": "minecraft:polished_basalt", "scale": 0.9,
        "physical": [2439.7, 0.3871, 15, 440, 1407.6, 87.969],
        "description": (
            "高金属丰度的内侧岩质行星。钨、铱、镍、铂族与合金矿是主产物；温差要求额外耐压外壳和冷却结构。",
            "A metal-rich inner planet supplying tungsten, iridium, nickel, platinum-group ores and alloy minerals. Thermal cycling requires pressure casings and cooling structures."),
        "resources": "iron nickel tungsten iridium platinum sheldonite gold vanadium_magnetite pyrolusite chromite hausmannite".split(),
        "survey": [("jsonreg:mv_sensor", 4)],
        "land": [("techreborn:tungstensteel_plate", 16), ("jsonreg:stress_proof_casing", 8)],
        "outpost": [("jsonreg:stress_proof_casing", 24), ("jsonreg:machine_casing_pipe_tungstensteel", 8),
                    ("jsonreg:steel_frame", 32), ("techreborn:advanced_circuit", 24),
                    ("techreborn:basic_solar_panel", 16), ("techreborn:insulated_gold_cable", 32)],
    },
    "venus": {
        "name": ("金星", "Venus"), "type": "toxic", "parent": "sol:sun", "order": 15,
        "marker": "minecraft:yellow_terracotta", "scale": 1.0,
        "physical": [6051.8, 0.7233, 90, 737, -5832.5, 224.701],
        "description": (
            "高温、高压、腐蚀性大气下的化工矿源。硫、汞锌矿、盐类、萤石、石英和油砂丰富，前哨必须配置氟聚合物衬里。",
            "Hot, high-pressure chemical deposits: sulfur, mercury/zinc ores, salts, fluorite, quartz and oil sand. The outpost requires fluoropolymer-lined reaction casings."),
        "resources": "sulfur sulfur_quartz oil_sand pyrite sphalerite cinnabar galena lead rock_salt fluorite saltpeter thermal_springstone gilded_blackstone".split(),
        "survey": [("jsonreg:mv_sensor", 4)],
        "land": [("jsonreg:reaction_safe_mixing_casing", 8), ("jsonreg:tetrafluoroethylene_plate", 16)],
        "outpost": [("jsonreg:reaction_safe_mixing_casing", 24), ("jsonreg:machine_casing_pipe_steel", 16),
                    ("jsonreg:steel_frame", 32), ("techreborn:advanced_circuit", 24),
                    ("techreborn:basic_machine_casing", 16), ("techreborn:insulated_gold_cable", 32)],
    },
    "mars": {
        "name": ("火星", "Mars"), "type": "barren", "parent": "sol:sun", "order": 30,
        "marker": "minecraft:red_sand", "scale": 0.9,
        "physical": [3389.5, 1.5237, 210, 210, 24.623, 686.98],
        "description": (
            "综合工业与结晶矿床。银、铀、刚玉宝石、方钠石与星光矿床分布于地下；矿产分布是整合包设定，并非真实火星勘探结论。",
            "Industrial and crystalline deposits: silver, uranium, corundum, sodalite and starlight ores. Mineral deposits are fictional pack content, not real Martian survey results."),
        "resources": "iron copper silver uranium ruby sapphire peridot sodalite quartz rose_quartz smoky_quartz deepsilver malarite".split(),
        "survey": [("jsonreg:mv_sensor", 3)],
        "land": [("techreborn:aluminum_plate", 24), ("jsonreg:steel_frame", 16)],
        "outpost": [("jsonreg:large_scale_assembling_casing", 24), ("jsonreg:steel_frame", 32),
                    ("techreborn:advanced_circuit", 24), ("techreborn:basic_solar_panel", 16),
                    ("techreborn:insulated_gold_cable", 32)],
    },
    "asteroid_belt": {
        "name": ("小行星带", "Asteroid Belt"), "type": "asteroid_belt", "parent": "sol:sun", "order": 40,
        "marker": "minecraft:stone", "scale": 0.6,
        "physical": [473, 2.77, 280, 167, 9.074, 1681.63],
        "description": (
            "谷神星尺度的带内前哨，使用登陆舱锚定矿体后建设永久据点。主产普通及富集硅岩、远古残骸和异质结晶；不产超能硅岩或中子素。",
            "A Ceres-scale belt outpost: anchor a lander before building a permanent base. Supplies naquadah, enriched naquadah, ancient debris and exotic crystals; excludes naquadria and neutronium."),
        "resources": "naquadah enriched_naquadah ancient_debris diamond emerald starcore starlit_diamond dimslag peculiar_clump thioquartz red_starlight_crystal blue_starlight_crystal nickel platinum".split(),
        "survey": [("jsonreg:mv_sensor", 4)],
        "land": [("jsonreg:stress_proof_casing", 16), ("jsonreg:steel_frame", 16)],
        "outpost": [("jsonreg:stress_proof_casing", 32), ("jsonreg:large_scale_assembling_casing", 16),
                    ("jsonreg:steel_frame", 32), ("techreborn:advanced_circuit", 32),
                    ("techreborn:basic_solar_panel", 16), ("techreborn:insulated_gold_cable", 32)],
    },
}


def stack(item, count=1):
    return {"item": item, "count": count}


def stage_variants(kind, materials, outpost=False):
    result = []
    for tier in (1, 2, 3):
        inputs = [stack(f"techreborn:space_{kind}_mk{tier}_powered")]
        if outpost:
            inputs.append(stack(f"techreborn:core_mk{tier}"))
        inputs += [stack(item, count) for item, count in materials]
        result.append({"tier": tier, "inputs": inputs,
                       "outputs": [stack(f"techreborn:space_{kind}_mk{tier}")]})
    return result


def build_body(key, spec):
    r, orbit, phase, temp, rotation, period = spec["physical"]
    return {
        "type": spec["type"], "tier": 1, "system": "sol", "from_system": "sol:sun",
        "parent": spec["parent"], "sort_order": spec["order"],
        # TR already ships zh_cn/en_us for gui.techreborn.space.body.* (all seven
        # Sol bodies), so reuse them instead of duplicating names.
        "display": {"name_key": f"gui.techreborn.space.body.{key}",
                    "description_key": f"planet.cmrh.sol.{key}.desc"},
        "marker_block": spec["marker"], "marker_scale": spec["scale"], "time": MINING_TICKS,
        "physical": {"radius_km": r, "orbit_radius_au": orbit, "orbit_phase_deg": phase,
                     "temperature_k": temp, "rotation_period_hours": rotation, "orbital_period_days": period,
                     "orbit_features": []},
        "missions": {
            "survey": {"enabled": True, "time": 6000, "variants": stage_variants("probe", spec["survey"])},
            "land": {"enabled": True, "time": 6000, "variants": stage_variants("lander", spec["land"])},
            "outpost": {"enabled": True, "time": 24000, "variants": stage_variants("lander", spec["outpost"], True)},
            "mining": {"enabled": True, "requires_landing": True, "variants": stage_variants("drone", [])},
        },
        "resources": [{"id": ore, "item": ORES[ore][0], "count": ORES[ore][1] * 2, "order": i * 10}
                      for i, ore in enumerate(spec["resources"], 1)],
        "visibility": {"name": "always", "physical": "after_survey", "resources": "after_survey"},
        "tags": ["cmrh_t1", "inner_system", "outpost_mining"],
    }


def dump(path, data):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(data, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")


def main():
    used = {ore for spec in BODIES.values() for ore in spec["resources"]}
    assert used == set(ORES), (set(ORES) - used, used - set(ORES))
    assert all("naquadria" not in item and "neutron" not in item for item, _, _ in ORES.values())
    dump(PACK / "pack.mcmeta", {
        "pack": {"pack_format": 48, "supported_formats": {"min_inclusive": 34, "max_inclusive": 48},
                 "description": "CmRhPack · T1 Solar Missions / T1 太阳系开拓与采矿"},
        # NOTE: the `filter` section means "this pack steps aside for a
        # lower-priority pack", which is the opposite of an override. Getting
        # priority right is handled by pack ordering, not by a filter here.
    })
    for body, spec in BODIES.items():
        dump(PACK / f"data/sol/techreborn/planet/{body}.json", build_body(body, spec))
    # Override the two existing display nodes too: every built-in sol entry is owned by this pack.
    for key in ("sun", "earth"):
        is_sun = key == "sun"
        name = ("太阳", "Sun") if is_sun else ("地球", "Earth")
        desc = ("太阳系的中央恒星，仅展示。", "The Solar System's central star; display only.") if is_sun else (
            "我们的家园，也是月球轨道的中心。太空电梯在主世界运行；地球本身不提供采矿任务。",
            "Our home and the Moon's orbital parent. The elevator operates in the Overworld; Earth has no mining missions.")
        spec = {"name": name, "description": desc, "type": "star" if is_sun else "continental",
                "parent": None if is_sun else "sol:sun", "order": 0 if is_sun else 20,
                "marker": "minecraft:glowstone" if is_sun else "minecraft:moss_block", "scale": 1,
                "physical": [696340, 0, 0, 5772, 609.12, 0] if is_sun else [6371, 1, 155, 288, 23.934, 365.256],
                "survey": [], "land": [], "outpost": [], "resources": []}
        body = build_body(key, spec)
        body["missions"] = {x: {"enabled": False} for x in ("survey", "land", "outpost")}
        body["missions"]["mining"] = {"enabled": False, "requires_landing": False}
        body["visibility"] = {"name": "always", "physical": "always", "resources": "always"}
        body["tags"] = ["cmrh_t1", "display_only"]
        dump(PACK / f"data/sol/techreborn/planet/{key}.json", body)
        BODIES[key] = spec
    for idx, locale in enumerate(("zh_cn", "en_us")):
        lang = {}
        for key, spec in BODIES.items():
            lang[f"planet.cmrh.sol.{key}.desc"] = spec["description"][idx]
        dump(PACK / f"assets/cmrh/lang/{locale}.json", lang)
    print(f"Generated 7 celestial bodies, {len(ORES)} unique resource entries, and zh_cn/en_us translations.")
    for key, spec in BODIES.items():
        if spec["resources"]:
            print(f"  sol:{key}: {len(spec['resources'])} resources; T1 outpost {MINING_TICKS} ticks/round")


if __name__ == "__main__":
    main()
