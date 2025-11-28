extends Node2D



	


func _on_area_2d_body_entered(body: Node2D) -> void:
	SG.SpawnManager.spawn_monster("rat", $Pit.global_position)
	$Area2D.queue_free()


func _on_area_2d_2_body_entered(body: Node2D) -> void:
	SG.SpawnManager.spawn_monster("skeleton", $Pit2.global_position)
	$Area2D2.queue_free()


func _process(delta: float) -> void:
	for i in $triggers.get_children():
		if len(i.get_overlapping_bodies()) > 0:
			$blurb.set_text(int(i.name))
			return
		
	


func _on_exit_body_entered(body: Node2D) -> void:
	var parent = get_parent()
	if parent:
		parent.queue_free()  # Remove the death screen
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
