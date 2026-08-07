import crafttweaker.api.tag.MCTag;
import crafttweaker.api.recipe.type.Recipe;

//岩石
craftingTable.addShapeless("t0.dirt_to_stone", <item:earlystage:rock>, [
    <tag:item:minecraft:dirt>
]);

//沙砾......?
craftingTable.addShaped("t0.dirt_to_gravel", <item:minecraft:gravel>, [
    [<tag:item:minecraft:dirt>, <tag:item:minecraft:dirt>],
    [<tag:item:minecraft:dirt>, <item:minecraft:stick>]]);

//EarlyStage钢不准造
<tag:item:earlystage:steel_ingot>.add(<item:techreborn:steel_ingot>);
furnace.removeByName("earlystage:steel_nugget_from_smelting");
<recipetype:minecraft:blasting_extra>.removeByName("earlystage:steel_ingot_from_blasting");
furnace.addRecipe("t0.earlystage.steel_nugget_from_smelting", <item:techreborn:steel_nugget>, 
    <item:earlystage:steel_pickaxe> | <item:earlystage:steel_shovel> | <item:earlystage:steel_axe> |
    <item:earlystage:steel_hoe> | <item:earlystage:steel_sword> | <item:earlystage:steel_helmet> |
    <item:earlystage:steel_chestplate> | <item:earlystage:steel_leggings> | <item:earlystage:steel_boots> |
    <item:earlystage:steel_horse_armor> | <item:minecraft:chainmail_helmet> | <item:minecraft:chainmail_chestplate> |
    <item:minecraft:chainmail_leggings> | <item:minecraft:chainmail_boots>, 0.1, 200);

craftingTable.addShapeless("t0.esteel", <item:earlystage:steel_ingot>, [
    <item:techreborn:steel_ingot>
]);
craftingTable.addShapeless("t0.esteel_turinglove", <item:techreborn:steel_ingot>, [
    <item:earlystage:steel_ingot>
]);