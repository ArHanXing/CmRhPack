import crafttweaker.api.tag.MCTag;
import crafttweaker.api.ingredient.type.IIngredientEmpty;
import crafttweaker.api.ingredient.IIngredient;


/*
[18:18:04.260][INFO][CraftTweaker-Commands]: Recipe type: '<recipetype:techreborn:wire_mill>'
  <recipetype:techreborn:wire_mill>.addJsonRecipe("techreborn:wire_mill/copper_cable", {type: "techreborn:wire_mill", time: 200, outputs: [{id: "techreborn:copper_cable", count: 6}], power: 2, ingredients: [{tag: "c:ingots/copper"}]});
  <recipetype:techreborn:wire_mill>.addJsonRecipe("techreborn:wire_mill/gold_cable", {type: "techreborn:wire_mill", time: 200, outputs: [{id: "techreborn:gold_cable", count: 6}], power: 2, ingredients: [{tag: "c:ingots/gold"}]});
  <recipetype:techreborn:wire_mill>.addJsonRecipe("techreborn:wire_mill/hv_cable", {type: "techreborn:wire_mill", time: 200, outputs: [{id: "techreborn:hv_cable", count: 6}], power: 2, ingredients: [{item: "techreborn:refined_iron_ingot"}]});
  <recipetype:techreborn:wire_mill>.addJsonRecipe("techreborn:wire_mill/tin_cable", {type: "techreborn:wire_mill", time: 200, outputs: [{id: "techreborn:tin_cable", count: 6}], power: 2, ingredients: [{tag: "c:ingots/tin"}]});
*/
//<recipetype:techreborn:wire_mill>.removeAll();
<recipetype:techreborn:lathe>.removeAll();
//如你所见，我们要把线材轧机的配方全部删除
//它将作为车床重生！

//车床被我造出来了
//线材压机回归
function _rodRecipe(_recipe as string, _output as string, _input as string, _time as int) as void{
    <recipetype:techreborn:lathe>.addJsonRecipe(_recipe, {type: "techreborn:lathe",
        time: _time,
        outputs: [{id: _output, count: 1}],
        power: 8,
        ingredients: [{item: _input}]
    });
}

_rodRecipe("lathe.steel", "jsonreg:steel_rod", "techreborn:steel_ingot", 20);
_rodRecipe("lathe.aluminum", "jsonreg:aluminum_rod", "techreborn:aluminum_ingot", 20);
_rodRecipe("lathe.copper", "jsonreg:copper_rod", "minecraft:copper_ingot", 20);
_rodRecipe("lathe.bronze", "jsonreg:bronze_rod", "techreborn:bronze_ingot", 20);
_rodRecipe("lathe.invar", "jsonreg:invar_rod", "techreborn:invar_ingot", 20);
_rodRecipe("lathe.refined_iron", "jsonreg:refined_iron_rod", "techreborn:refined_iron_ingot", 20);
_rodRecipe("lathe.iron", "jsonreg:iron_rod", "minecraft:iron_ingot", 20);
_rodRecipe("lathe.tungsten_steel", "jsonreg:tungsten_steel_rod", "techreborn:tungstensteel_ingot", 40);
_rodRecipe("lathe.naquadah", "jsonreg:naquadah_rod", "jsonreg:naquadah_ingot", 40);
_rodRecipe("lathe.enriched_naquadah", "jsonreg:enriched_naquadah_rod", "jsonreg:enriched_naquadah_ingot", 40);
_rodRecipe("lathe.naquadria", "jsonreg:naquadria_rod", "jsonreg:naquadria_ingot", 40);
_rodRecipe("lathe.titanium", "jsonreg:titanium_rod", "techreborn:titanium_ingot", 20);
_rodRecipe("lathe.duratium", "jsonreg:duratium_rod", "oritech:duratium_ingot", 40);
_rodRecipe("lathe.electrum", "jsonreg:electrum_rod", "techreborn:electrum_ingot", 20);
_rodRecipe("lathe.unrealium", "jsonreg:unrealium_rod", "eternal_starlight:unrealium_ingot", 40);

//部分具有工作台配方的：铜，铁，钢，殷钢，青铜，精炼铁。
//由ctgui管理了，累了