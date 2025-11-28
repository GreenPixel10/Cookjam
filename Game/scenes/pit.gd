extends Node2D


func _on_area_2d_area_entered(area: Area2D) -> void:
	var item = area.get_parent()
	if item.state == item.states.DROPPED:
		item.queue_free()
