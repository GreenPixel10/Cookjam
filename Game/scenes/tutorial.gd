extends Node2D


func _on_area_2d_area_entered(area: Area2D) -> void:
	SG.SpawnManager.spawn_monster("rat", $Pit.global_position)
	print("test")
	
