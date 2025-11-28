extends Node2D


var pickup = preload("res://scenes/pickup.tscn")
var mob = preload("res://scenes/mob.tscn")

var pits = []

var spawn_interval = 15
var spawn_interval_decay = 0.98
var initial_delay = 3

var t = 0

func _ready() -> void:
	SG.SpawnManager = self
	$Timer.start(initial_delay)
	
func _process(delta):
	t += delta

func spawn_pickup(item_name, pos):
	var drop = pickup.instantiate()
	drop.init(item_name)
	drop.position = pos
	get_parent().add_child(drop)
	return drop
	

func spawn_monster(monster_name, pos):
	var new_mob = mob.instantiate()
	new_mob.init(monster_name)
	new_mob.position = pos
	get_parent().add_child(new_mob)
	return new_mob

func _on_timer_timeout() -> void:
	print("spawning!")
	var spawn_source = pits.pick_random()
	var monster_name = ObjectManager.mobs.keys().pick_random()
	#monster_name = "snake"
	spawn_monster(monster_name, spawn_source.global_position)
	$Timer.start(spawn_interval * spawn_interval_decay)
