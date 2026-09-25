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
<tag:block:c:ores>.add(<block:jsonreg:rock_salt_ore>);
<tag:block:c:ores>.add(<block:jsonreg:end_naquadah_ore>);
<tag:block:c:ores>.add(<block:jsonreg:end_enriched_naquadah_ore>);
<tag:block:c:ores>.add(<block:jsonreg:voidstone_rutile_ore>);

<tag:item:c:small_dusts>.add(<item:oritech:small_platinum_dust>);
<tag:item:c:small_dusts/platinum>.add(<item:oritech:small_platinum_dust>);

<tag:item:c:small_dusts>.add(<item:oritech:small_nickel_dust>);
<tag:item:c:small_dusts/nickel>.add(<item:oritech:small_nickel_dust>);


// ===== basic ore concentrates (general_ore_process.zs T1.5) =====
// clump/gem 命名与 Oritech 既有标签对齐（c:clumps/iron 等），
// 使新链的配方可以用 tag 统一书写，不必逐个矿物写死 item。
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

// 泛化标签：便于「任意浓缩物」类配方与 EMI 归类
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
