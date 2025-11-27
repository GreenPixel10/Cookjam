extends Node2D

var type = "none"
var sprite = "res://icon.svg"
var cooldown = .5
var damage = 10


var cooling = false

var idle = true

var hurts_player = false



func _process(_delta: float) -> void:
	if !idle:
		look_at(get_global_mouse_position())


func init(weapon_type):
	type = weapon_type
	var stats = ObjectManager.get_weapon_stats(type)
	sprite = stats[0]
	$Sprite2D.texture = load(sprite)
	cooldown = stats[1]
	damage = stats[2]

func attack():
	if !cooling:
		var targets = $Area2D.get_overlapping_areas()
		
		for i in targets:
			var target = i.get_parent()
			if target == get_parent(): continue
			if target.has_method("apply_damage"):
				target.apply_damage(damage)
		
		
		cooling = true
		await get_tree().create_timer(cooldown).timeout
		cooling = false

func set_idle(is_idle : bool):
	idle = is_idle
	
