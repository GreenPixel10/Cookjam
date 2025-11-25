extends Node2D


var pickup = preload("res://pickup.tscn")

func _ready() -> void:
	SG.SpawnManager = self

func spawn_pickup(item_name, pos):
	var drop = pickup.instantiate()
	drop.init(item_name)
	drop.position = pos
	get_parent().add_child(drop)
