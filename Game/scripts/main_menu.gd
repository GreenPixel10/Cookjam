extends Node

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Main.tscn")


func _on_tutorial_button_pressed() -> void:
	pass # Replace with function body.
	# get_tree().change_scene_to_file("res:// some tutorial scene")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
