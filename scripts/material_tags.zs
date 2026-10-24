import crafttweaker.api.tag.MCTag;
import crafttweaker.api.ingredient.type.IIngredientEmpty;
import crafttweaker.api.ingredient.IIngredient;
/*
<tag:item:cmrh:rubber>.add(<item:space:rubber>);
<tag:item:cmrh:rubber>.add(<item:techreborn:rubber>);
<tag:item:cmrh:rubber_sapling>.add(<item:techreborn:rubber_sapling>);
<tag:item:cmrh:rubber_sapling>.add(<item:space:rubber_sapling>);
<tag:item:cmrh:rubber_leaves>.add(<item:techreborn:rubber_leaves>);
<tag:item:cmrh:rubber_leaves>.add(<item:space:rubber_leaves>);
*/
// 低优先度

<tag:item:c:raw_ores>.add(<item:jsonreg:raw_naquadah>);

<tag:item:c:dusts>.add(<item:jsonreg:naquadah_dust>);
<tag:item:c:dusts>.add(<item:jsonreg:enriched_naquadah_dust>);
<tag:item:c:dusts>.add(<item:jsonreg:stabilized_enriched_naquadah_dust>);
<tag:item:c:dusts>.add(<item:jsonreg:enriched_naquadah_sulfate_dust>);
<tag:item:c:dusts>.add(<item:jsonreg:depleted_uranium_slag>);
<tag:item:c:dusts>.add(<item:jsonreg:insoluble_residue>);
<tag:item:c:dusts>.add(<item:jsonreg:calcium_oxide_slag>);
<tag:item:c:dusts>.add(<item:jsonreg:sublimation_residue>);
<tag:item:c:dusts>.add(<item:jsonreg:naquadria_hydroxide_precipitate>);
<tag:item:c:dusts>.add(<item:jsonreg:naquadria_oxide_dust>);
<tag:item:c:dusts>.add(<item:jsonreg:naquadria_dust>);
<tag:item:c:dusts>.add(<item:jsonreg:sponge_naquadria>);

<tag:item:c:ingots>.add(<item:jsonreg:naquadah_ingot>);
<tag:item:c:ingots/naquadah>.add(<item:jsonreg:naquadah_ingot>);
<tag:item:c:ingots>.add(<item:jsonreg:hot_enriched_naquadah_ingot>);
<tag:item:c:ingots/hot>.add(<item:jsonreg:hot_enriched_naquadah_ingot>);
<tag:item:c:ingots/hot>.add(<item:techreborn:hot_tungstensteel_ingot>);
<tag:item:c:ingots/hot/enriched_naquadah>.add(<item:jsonreg:hot_enriched_naquadah_ingot>);
<tag:item:c:ingots>.add(<item:jsonreg:enriched_naquadah_ingot>);
<tag:item:c:ingots/enriched_naquadah>.add(<item:jsonreg:enriched_naquadah_ingot>);
<tag:item:c:ingots>.add(<item:jsonreg:naquadria_ingot>);
<tag:item:c:ingots/naquadria>.add(<item:jsonreg:naquadria_ingot>);
<tag:item:c:ingots>.add(<item:jsonreg:hot_naquadria_ingot>);
<tag:item:c:ingots/hot>.add(<item:jsonreg:hot_naquadria_ingot>);
<tag:item:c:ingots/hot/naquadria>.add(<item:jsonreg:hot_naquadria_ingot>);
<tag:item:c:ingots>.add(<item:toneko:neko_ingot>);
<tag:item:c:ingots/neko>.add(<item:toneko:neko_ingot>);

<tag:block:c:ores>.add(<block:jsonreg:salt_ore>);
<tag:block:c:ores/salt>.add(<block:jsonreg:salt_ore>);
<tag:block:c:ores>.add(<block:jsonreg:rock_salt_ore>);
<tag:block:c:ores/rock_salt>.add(<block:jsonreg:rock_salt_ore>);
<tag:block:c:ores>.add(<block:jsonreg:end_naquadah_ore>);
<tag:block:c:ores/naquadah>.add(<block:jsonreg:end_naquadah_ore>);
<tag:block:c:ores>.add(<block:jsonreg:end_enriched_naquadah_ore>);
<tag:block:c:ores/enriched_naquadah>.add(<block:jsonreg:end_enriched_naquadah_ore>);
<tag:block:c:ores>.add(<block:jsonreg:voidstone_rutile_ore>);
<tag:block:c:ores/rutile>.add(<block:jsonreg:voidstone_rutile_ore>);
<tag:block:c:ores>.add(<block:jsonreg:nether_fluorite_ore>); 
<tag:block:c:ores/fluorite>.add(<block:jsonreg:nether_fluorite_ore>);

<tag:item:c:small_dusts>.add(<item:oritech:small_platinum_dust>);
<tag:item:c:small_dusts/platinum>.add(<item:oritech:small_platinum_dust>);

<tag:item:c:small_dusts>.add(<item:oritech:small_nickel_dust>);
<tag:item:c:small_dusts/nickel>.add(<item:oritech:small_nickel_dust>);

// ===== basic ore concentrates (scripts/ore_process/02_t15.zs) =====
<tag:item:c:clumps/lead>.add(<item:jsonreg:lead_clump>);
<tag:item:c:gems/lead>.add(<item:jsonreg:lead_gem>);
<tag:item:c:concentrates/lead>.add(<item:jsonreg:lead_concentrate>);
<tag:item:c:clumps/silver>.add(<item:jsonreg:silver_clump>);
<tag:item:c:gems/silver>.add(<item:jsonreg:silver_gem>);
<tag:item:c:concentrates/silver>.add(<item:jsonreg:silver_concentrate>);
<tag:item:c:clumps/tin>.add(<item:jsonreg:tin_clump>);
<tag:item:c:gems/tin>.add(<item:jsonreg:tin_gem>);
<tag:item:c:concentrates/tin>.add(<item:jsonreg:tin_concentrate>);
<tag:item:c:clumps/tungsten>.add(<item:jsonreg:tungsten_clump>);
<tag:item:c:gems/tungsten>.add(<item:jsonreg:tungsten_gem>);
<tag:item:c:concentrates/tungsten>.add(<item:jsonreg:tungsten_concentrate>);
<tag:item:c:clumps/iridium>.add(<item:jsonreg:iridium_clump>);
<tag:item:c:gems/iridium>.add(<item:jsonreg:iridium_gem>);
<tag:item:c:concentrates/iridium>.add(<item:jsonreg:iridium_concentrate>);
<tag:item:c:clumps/aluminum>.add(<item:jsonreg:aluminum_clump>);
<tag:item:c:gems/aluminum>.add(<item:jsonreg:aluminum_gem>);
<tag:item:c:concentrates/aluminum>.add(<item:jsonreg:aluminum_concentrate>);
<tag:item:c:clumps/uranium>.add(<item:jsonreg:uranium_clump>);
<tag:item:c:gems/uranium>.add(<item:jsonreg:uranium_gem>);
<tag:item:c:concentrates/uranium>.add(<item:jsonreg:uranium_concentrate>);
<tag:item:c:clumps/galena>.add(<item:jsonreg:galena_clump>);
<tag:item:c:gems/galena>.add(<item:jsonreg:galena_gem>);
<tag:item:c:concentrates/galena>.add(<item:jsonreg:galena_concentrate>);
<tag:item:c:clumps/sphalerite>.add(<item:jsonreg:sphalerite_clump>);
<tag:item:c:gems/sphalerite>.add(<item:jsonreg:sphalerite_gem>);
<tag:item:c:concentrates/sphalerite>.add(<item:jsonreg:sphalerite_concentrate>);
<tag:item:c:clumps/cinnabar>.add(<item:jsonreg:cinnabar_clump>);
<tag:item:c:gems/cinnabar>.add(<item:jsonreg:cinnabar_gem>);
<tag:item:c:concentrates/cinnabar>.add(<item:jsonreg:cinnabar_concentrate>);
<tag:item:c:clumps/pyrite>.add(<item:jsonreg:pyrite_clump>);
<tag:item:c:gems/pyrite>.add(<item:jsonreg:pyrite_gem>);
<tag:item:c:concentrates/pyrite>.add(<item:jsonreg:pyrite_concentrate>);
<tag:item:c:clumps/sodalite>.add(<item:jsonreg:sodalite_clump>);
<tag:item:c:gems/sodalite>.add(<item:jsonreg:sodalite_gem>);
<tag:item:c:concentrates/sodalite>.add(<item:jsonreg:sodalite_concentrate>);
<tag:item:c:concentrates/copper>.add(<item:jsonreg:copper_concentrate>);
<tag:item:c:concentrates/gold>.add(<item:jsonreg:gold_concentrate>);
<tag:item:c:concentrates/iron>.add(<item:jsonreg:iron_concentrate>);
<tag:item:c:concentrates/nickel>.add(<item:jsonreg:nickel_concentrate>);
<tag:item:c:concentrates/platinum>.add(<item:jsonreg:platinum_concentrate>);

<tag:item:c:concentrates>.add(<item:jsonreg:lead_concentrate>);
<tag:item:c:concentrates>.add(<item:jsonreg:silver_concentrate>);
<tag:item:c:concentrates>.add(<item:jsonreg:tin_concentrate>);
<tag:item:c:concentrates>.add(<item:jsonreg:tungsten_concentrate>);
<tag:item:c:concentrates>.add(<item:jsonreg:iridium_concentrate>);
<tag:item:c:concentrates>.add(<item:jsonreg:aluminum_concentrate>);
<tag:item:c:concentrates>.add(<item:jsonreg:uranium_concentrate>);
<tag:item:c:concentrates>.add(<item:jsonreg:galena_concentrate>);
<tag:item:c:concentrates>.add(<item:jsonreg:sphalerite_concentrate>);
<tag:item:c:concentrates>.add(<item:jsonreg:cinnabar_concentrate>);
<tag:item:c:concentrates>.add(<item:jsonreg:pyrite_concentrate>);
<tag:item:c:concentrates>.add(<item:jsonreg:sodalite_concentrate>);
<tag:item:c:concentrates>.add(<item:jsonreg:copper_concentrate>);
<tag:item:c:concentrates>.add(<item:jsonreg:gold_concentrate>);
<tag:item:c:concentrates>.add(<item:jsonreg:iron_concentrate>);
<tag:item:c:concentrates>.add(<item:jsonreg:nickel_concentrate>);
<tag:item:c:concentrates>.add(<item:jsonreg:platinum_concentrate>);

<tag:item:c:ores/fluorite>.add(<item:jsonreg:nether_fluorite_ore>);
<tag:item:c:clumps/fluorite>.add(<item:jsonreg:fluorite_clump>);
<tag:item:c:gems/fluorite>.add(<item:jsonreg:fluorite_gem>);
<tag:item:c:dusts>.add(<item:jsonreg:fluorite_dust>);
<tag:item:c:dusts/fluorite>.add(<item:jsonreg:fluorite_dust>);
<tag:item:c:dusts>.add(<item:jsonreg:calcium_sulfate_dust>);
<tag:item:c:dusts/calcium_sulfate>.add(<item:jsonreg:calcium_sulfate_dust>);

<tag:item:c:dusts>.add(<item:jsonreg:lead_dust>);
<tag:item:c:dusts/lead>.add(<item:jsonreg:lead_dust>);
<tag:item:c:dusts>.add(<item:jsonreg:silver_dust>);
<tag:item:c:dusts/silver>.add(<item:jsonreg:silver_dust>);
<tag:item:c:dusts>.add(<item:jsonreg:tin_dust>);
<tag:item:c:dusts/tin>.add(<item:jsonreg:tin_dust>);
<tag:item:c:dusts>.add(<item:jsonreg:tungsten_dust>);
<tag:item:c:dusts/tungsten>.add(<item:jsonreg:tungsten_dust>);
<tag:item:c:dusts>.add(<item:jsonreg:iridium_dust>);
<tag:item:c:dusts/iridium>.add(<item:jsonreg:iridium_dust>);

// ===== 核燃料产线（见 scripts/nuclear_design.md）=====
<tag:item:c:dusts>.add(<item:jsonreg:enriched_uranium_dust>);
<tag:item:c:dusts/enriched_uranium>.add(<item:jsonreg:enriched_uranium_dust>);
<tag:item:c:dusts>.add(<item:jsonreg:uranium_dioxide_dust>);
<tag:item:c:dusts/uranium_dioxide>.add(<item:jsonreg:uranium_dioxide_dust>);
<tag:item:c:dusts>.add(<item:jsonreg:mox_blend_dust>);
<tag:item:c:dusts/mox>.add(<item:jsonreg:mox_blend_dust>);
<tag:item:c:plates>.add(<item:jsonreg:depleted_uranium_dense_plate>);
<tag:item:c:plates/depleted_uranium>.add(<item:jsonreg:depleted_uranium_dense_plate>);

// ===== 硅岩合金 / 高速钢-G（见 scripts/t2.zs 末尾）=====
<tag:item:c:dusts>.add(<item:jsonreg:naquadah_alloy_dust>);
<tag:item:c:dusts/naquadah_alloy>.add(<item:jsonreg:naquadah_alloy_dust>);
<tag:item:c:dusts>.add(<item:jsonreg:hssg_dust>);
<tag:item:c:dusts/hssg>.add(<item:jsonreg:hssg_dust>);

<tag:item:c:ingots>.add(<item:jsonreg:hot_naquadah_alloy_ingot>);
<tag:item:c:ingots/hot>.add(<item:jsonreg:hot_naquadah_alloy_ingot>);
<tag:item:c:ingots/hot/naquadah_alloy>.add(<item:jsonreg:hot_naquadah_alloy_ingot>);
<tag:item:c:ingots>.add(<item:jsonreg:naquadah_alloy_ingot>);
<tag:item:c:ingots/naquadah_alloy>.add(<item:jsonreg:naquadah_alloy_ingot>);
<tag:item:c:ingots>.add(<item:jsonreg:hot_hssg_ingot>);
<tag:item:c:ingots/hot>.add(<item:jsonreg:hot_hssg_ingot>);
<tag:item:c:ingots/hot/hssg>.add(<item:jsonreg:hot_hssg_ingot>);
<tag:item:c:ingots>.add(<item:jsonreg:hssg_ingot>);
<tag:item:c:ingots/hssg>.add(<item:jsonreg:hssg_ingot>);

<tag:item:c:plates>.add(<item:jsonreg:naquadah_alloy_plate>);
<tag:item:c:plates/naquadah_alloy>.add(<item:jsonreg:naquadah_alloy_plate>);
<tag:item:c:plates>.add(<item:jsonreg:hssg_plate>);
<tag:item:c:plates/hssg>.add(<item:jsonreg:hssg_plate>);

<tag:item:c:rods>.add(<item:jsonreg:naquadah_alloy_rod>);
<tag:item:c:rods/naquadah_alloy>.add(<item:jsonreg:naquadah_alloy_rod>);
<tag:item:c:rods>.add(<item:jsonreg:hssg_rod>);
<tag:item:c:rods/hssg>.add(<item:jsonreg:hssg_rod>);
// ===== 下界钒磁铁 / 软锰矿 / 铬铁矿 / 硬锰矿（见 scripts/ore_process/ 各 tier 文件）=====
// 钒：完整金属
<tag:item:c:dusts>.add(<item:jsonreg:vanadium_dust>);
<tag:item:c:dusts/vanadium>.add(<item:jsonreg:vanadium_dust>);
<tag:item:c:ingots>.add(<item:jsonreg:vanadium_ingot>);
<tag:item:c:ingots/vanadium>.add(<item:jsonreg:vanadium_ingot>);
<tag:item:c:plates>.add(<item:jsonreg:vanadium_plate>);
<tag:item:c:plates/vanadium>.add(<item:jsonreg:vanadium_plate>);

// 中间体：碎块 / 石 / 浓缩物
<tag:item:c:clumps>.add(<item:jsonreg:vanadium_magnetite_clump>);
<tag:item:c:clumps>.add(<item:jsonreg:pyrolusite_clump>);
<tag:item:c:clumps>.add(<item:jsonreg:chromite_clump>);
<tag:item:c:clumps>.add(<item:jsonreg:hausmannite_clump>);
<tag:item:c:gems>.add(<item:jsonreg:vanadium_magnetite_gem>);
<tag:item:c:gems>.add(<item:jsonreg:pyrolusite_gem>);
<tag:item:c:gems>.add(<item:jsonreg:chromite_gem>);
<tag:item:c:gems>.add(<item:jsonreg:hausmannite_gem>);

// 矿石方块（下界岩形态 + 末地金红石）
<tag:item:c:ores>.add(<item:jsonreg:nether_vanadium_magnetite_ore>);
<tag:item:c:ores/vanadium_magnetite>.add(<item:jsonreg:nether_vanadium_magnetite_ore>);
<tag:item:c:ores>.add(<item:jsonreg:nether_pyrolusite_ore>);
<tag:item:c:ores/pyrolusite>.add(<item:jsonreg:nether_pyrolusite_ore>);
<tag:item:c:ores>.add(<item:jsonreg:nether_chromite_ore>);
<tag:item:c:ores/chromite>.add(<item:jsonreg:nether_chromite_ore>);
<tag:item:c:ores>.add(<item:jsonreg:nether_hausmannite_ore>);
<tag:item:c:ores/hausmannite>.add(<item:jsonreg:nether_hausmannite_ore>);
<tag:item:c:ores>.add(<item:jsonreg:nether_rock_salt_ore>);
<tag:item:c:ores/rock_salt>.add(<item:jsonreg:nether_rock_salt_ore>);
<tag:item:c:ores>.add(<item:jsonreg:end_rutile_ore>);
<tag:item:c:ores/rutile>.add(<item:jsonreg:end_rutile_ore>);

// ===== 太空电梯：强化硅岩合金 / UHPC 建材（见 scripts/space_elevator.zs 末段）=====
<tag:item:c:dusts>.add(<item:jsonreg:reinforced_naquadah_alloy_dust>);
<tag:item:c:dusts/reinforced_naquadah_alloy>.add(<item:jsonreg:reinforced_naquadah_alloy_dust>);
<tag:item:c:ingots>.add(<item:jsonreg:hot_reinforced_naquadah_alloy_ingot>);
<tag:item:c:ingots/hot>.add(<item:jsonreg:hot_reinforced_naquadah_alloy_ingot>);
<tag:item:c:ingots/hot/reinforced_naquadah_alloy>.add(<item:jsonreg:hot_reinforced_naquadah_alloy_ingot>);
<tag:item:c:ingots>.add(<item:jsonreg:reinforced_naquadah_alloy_ingot>);
<tag:item:c:ingots/reinforced_naquadah_alloy>.add(<item:jsonreg:reinforced_naquadah_alloy_ingot>);
<tag:item:c:plates>.add(<item:jsonreg:reinforced_naquadah_alloy_plate>);
<tag:item:c:plates/reinforced_naquadah_alloy>.add(<item:jsonreg:reinforced_naquadah_alloy_plate>);
<tag:item:c:rods>.add(<item:jsonreg:reinforced_naquadah_alloy_rod>);
<tag:item:c:rods/reinforced_naquadah_alloy>.add(<item:jsonreg:reinforced_naquadah_alloy_rod>);
