extends Node



var objects = { #name : [texture]
	
	"default" : ["res://icon.svg"]
	
}


func get_texture(item_name):
	return objects[item_name][0]
