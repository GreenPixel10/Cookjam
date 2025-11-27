extends Node2D

var cooldown = .5
var damage = 10
var cooling = false

var idle = true

var hurts_player = false



func _process(_delta: float) -> void:
	if !idle:
		look_at(get_global_mouse_position())


func attack():
	if !cooling:
		var targets = $Area2D.get_overlapping_areas()
		
		for i in targets:
			i.get_parent().apply_damage(damage)
		
		
		cooling = true
		await get_tree().create_timer(cooldown).timeout
		cooling = false

func set_idle(is_idle : bool):
	idle = is_idle
	
