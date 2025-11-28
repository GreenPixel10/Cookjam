extends Control

func _on_restart_button_pressed() -> void:
	get_tree().paused = false # unpause game
	var parent = get_parent()
	if parent:
		parent.queue_free()  # remove the death screen
	get_tree().change_scene_to_file("res://scenes/Main.tscn")

func _on_main_menu_button_pressed() -> void:
	get_tree().paused = false # unpause game
	var parent = get_parent()
	if parent:
		parent.queue_free()  # Remove the death screen
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")

func _on_rage_quit_button_pressed() -> void:
	get_tree().quit()
