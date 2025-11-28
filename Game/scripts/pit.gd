extends Node2D


var spawn_interval = 15
var timer_random = 1.3

func _on_area_2d_area_entered(area: Area2D) -> void:
	var item = area.get_parent()
	if item.state == item.states.DROPPED:
		item.queue_free()



func _ready() -> void:
	SG.SpawnManager.pits.append(self)
	
