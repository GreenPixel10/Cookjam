extends Node2D

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Main.tscn")


func _on_tutorial_pressed() -> void:
	pass # Replace with function body.
	# get_tree().change_scene_to_file()

func _on_quit_pressed() -> void:
	get_tree().quit()
