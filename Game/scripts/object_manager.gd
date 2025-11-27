extends Node

enum types {  
	SPRITE,      
	SCENE  
} 

var objects = { #name : [texture / source, type]
	"default" : ["res://icon.svg"],
	"knife" : ["res://scenes/knife.tscn"],
	"test" : ["res://assets/sprites/tiles/tiletest2.png"],
	"pot" : ["res://assets/sprites/items/pot_empty.png"],
	"pot_water" : ["res://assets/sprites/items/pot_water.png"],
	"bone_soup_raw" : ["res://assets/sprites/items/bone_soup_raw.png"],
	"bone_soup" : ["res://assets/sprites/items/bone_soup.png"],
	"bone" : ["res://assets/sprites/items/bone.png"],
	
}


var conversions = {
	"fireplace" : { #name of converter
		"default" : ["knife", 3], #input item : [output item, conversion time]
		"example input" : ["example output", 5],
		"bone_soup_raw" : ["bone_soup", 5],
	},
	
	"fountain" : {
		"default" : ["knife", 3],
		"example input" : ["example output", 5],
		"pot" : ["pot_water", 2],
	}
}

var combinations = {
	"default+knife" : "test", #type1+type2 : output
	"pot_water+bone" : "bone_soup_raw",
}

var tool_conversions = {
	"default" : {"knife" : "test"} #item : {tool : output, tool2 : output2}
}

func get_resource(item_name):
	return objects[item_name][0]

func get_resource_type(item_name):
	var filetype = get_resource(item_name).split(".")[1]
	if filetype == "tscn": return types.SCENE
	else: return types.SPRITE
	#return objects[item_name][1]

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
