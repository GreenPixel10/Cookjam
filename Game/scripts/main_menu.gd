extends Node

var difficulty_names = ["Baby's First Dungeon", "Just the Regular", "Impossible!"]
var difficulties = [2, 1, 0.5]

func _ready():
	_on_h_slider_value_changed(1)
	SG.tut = false

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Main.tscn")


func _on_tutorial_button_pressed() -> void:
	pass # Replace with function body.
	SG.tut = true
	SG.heal_multiplier = 2
	get_tree().change_scene_to_file("res://scenes/Main.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_h_slider_value_changed(value: float) -> void:
	$ButtonManager/Label.text = "Difficulty: " + difficulty_names[round(value)]
	SG.heal_multiplier = difficulties[round(value)]
