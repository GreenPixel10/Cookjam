extends Node

enum types {  
	SPRITE,      
	SCENE  
} 

var objects = { #name : [texture / source, type]
	"default" : ["res://icon.svg", types.SPRITE],
	"knife" : ["res://scenes/knife.tscn", types.SCENE]
}


var conversions = {
	"fireplace" : { #name of converter
		"default" : ["knife", 3], #input item : [output item, conversion time]
		"example input" : ["example output", 5]
	},
	
	"fountain" : {
		"default" : ["knife", 3],
		"example input" : ["example output", 5]
	}
}


func get_resource(item_name):
	return objects[item_name][0]

func get_resource_type(item_name):
	return objects[item_name][1]
