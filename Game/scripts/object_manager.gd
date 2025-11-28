extends Node

enum types {  
	SPRITE,      
	SCENE  
} 

var objects = { #name : [texture / source, throwing damage, health boost]
	"default" : ["res://icon.svg", 0, 0],
	"knife" : ["res://scenes/knife.tscn", 5, 0],
	"test" : ["res://assets/sprites/tiles/tiletest2.png", 0, 0],
	"pot" : ["res://assets/sprites/items/pot_empty.png", 3, 0],
	"pot_water" : ["res://assets/sprites/items/pot_water.png", 3, 0],
	"bone_soup_raw" : ["res://assets/sprites/items/bone_soup_raw.png", 3, 0],
	"bone_soup" : ["res://assets/sprites/items/bone_soup.png", 5, 35], #1
	"bone" : ["res://assets/sprites/items/bone.png", 1, 0],
	"mace" : ["res://scenes/knife.tscn", 10, 0],
	"snakeskin" : ["res://assets/sprites/items/snakeskin.png", 0, 0],
	"snakeskin_powder" : ["res://assets/sprites/items/snakeskin_powder.png", 0, 0],
	"bone_soup_seasoned" : ["res://assets/sprites/items/bone_soup_seasoned.png", 2, 65], #2
	"ratmeat" : ["res://assets/sprites/items/ratmeat.png", 1, 0],
	"rat_nuggets_raw" : ["res://assets/sprites/items/rat_nuggets_raw.png", 1, 0],
	"rat_nuggets" : ["res://assets/sprites/items/rat_nuggets.png", 2, 10], #2
	"ground_meat_raw" : ["res://assets/sprites/items/mincemeat.png", 0, 0],
	"ground_meat" : ["res://assets/sprites/items/ground_meat.png", 0, 0],
	"burrito" : ["res://assets/sprites/items/burrito.png", 4, 25], #3
	"rat_stew_raw" : ["res://assets/sprites/items/rat_stew_raw.png", 3, 0],
	"rat_stew" : ["res://assets/sprites/items/rat_stew.png", 5, 45], #4
	"rat_stew_seasoned" : ["res://assets/sprites/items/rat_stew_seasoned.png", 5, 75], #5
	"bone_dust" : ["res://assets/sprites/items/bone_dust.png", 0, 0],
	"bone_jelly" : ["res://assets/sprites/items/bone_jelly.png", 2, 20], #6
}

var weapon_stats = {
	"knife" : ["res://assets/sprites/items/knife.png", 0.5, 10], #sprite, cooldown, damage
	"mace" : ["res://assets/sprites/items/mace.png", 2, 20],
}

var conversions = {
	"fireplace" : { #name of converter
		"default" : ["knife", 3], #input item : [output item, conversion time]
		"example input" : ["example output", 5],
		"bone_soup_raw" : ["bone_soup", 5],
		"rat_nuggets_raw" : ["rat_nuggets", 3],
		"ground_meat_raw" : ["ground_meat", 4],
		"rat_stew_raw" : ["rat_stew", 5],
	},
	
	"fountain" : {
		"default" : ["knife", 3],
		"example input" : ["example output", 5],
		"pot" : ["pot_water", 2],
		"bone_dust" : ["bone_jellyssaw", 2],
	}
}

var combinations = {
	"default+knife" : "test", #type1+type2 : output
	"pot_water+bone" : "bone_soup_raw",
	"pot_water+rat_nuggets_raw" : "rat_stew_raw",
	"bone_soup+snakeskin_powder" : "bone_soup_seasoned",
	"rat_stew+snakeskin_powder" : "rat_stew_seasoned",
	"ground_meat+snakeskin" : "burrito",
}

var tool_conversions = {
	"default" : {"knife" : "test"}, #item : {tool : output, tool2 : output2}
	"snakeskin" : {"mace" : "snakeskin_powder"},
	"ratmeat" : {"knife" : "rat_nuggets_raw","mace" : "ground_meat_raw"},
	"bone" : {"mace" : "bone_dust"},
}

var mobs = { #speed, health, damage, drops, animation, flip sprite
	"skeleton" : [100, 40, 8, ["bone"], "res://assets/sprites/skeleton.tres", false],
	"rat" : [200, 5, 5, ["ratmeat"], "res://assets/sprites/rat.tres", true],
	"snake" : [120, 25, 8, ["snakeskin"], "res://assets/sprites/snake.tres", true],
	"knight" : [50, 40, 10, ["pot"], "res://assets/sprites/knight.tres", false],
}

func get_resource(item_name):
	return objects[item_name][0]

func get_resource_type(item_name):
	var filetype = get_resource(item_name).split(".")[1]
	if filetype == "tscn": return types.SCENE
	else: return types.SPRITE
	#return objects[item_name][1]
	
func get_toss_damage(item_name):
	return objects[item_name][1]
	
func get_health_boost(item_name):
	return objects[item_name][2]

func get_combo(typeA, typeB):
	var output = null
	var key1 = typeA + "+" + typeB
	var key2 = typeB + "+" + typeA
	if combinations.has(key1): output = combinations[key1]
	elif combinations.has(key2): output = combinations[key2]
	return output
	
func get_tool_conversion(item, tool):
	if !tool_conversions.has(item): return null #item cant be changed by any tool
	var conversion_table = tool_conversions[item]
	if !conversion_table.has(tool): return null #item can't be changed by this specific tool
	var output = conversion_table[tool]
	return output
	
func get_weapon_stats(item):
	return weapon_stats[item]
