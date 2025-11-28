extends Node2D


func _ready():
	if SG.tut:
		add_child(load("res://scenes/Tutorial.tscn").instantiate())
	else:
		add_child(load("res://scenes/Dungeon.tscn").instantiate())
