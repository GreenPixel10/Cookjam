extends Node2D

var speed = 100
var hp = 30
var death_drops = ["default"]

var pickup = preload("res://scenes/pickup.tscn")

func _ready():
	
	
	$Nav.set_navigation_map(SG.Tilemap.get_navigation_map()) #use the tilemap navmesh
	

func _process(delta: float):
	$Nav.set_target_position(SG.Player.global_position) #set target to player
	
	var path = $Nav.get_current_navigation_path()
	var next_point = $Nav.get_next_path_position() #get the next point
	
	#move towards it
	var movevec = (next_point - global_position).normalized()
	movevec *= speed * delta
	global_position += movevec


func apply_damage(dam):
	hp -= dam
	print("enemy took damage!")
	if hp <= 0:
		die()



func die():
	print("enemy died")
	for i in death_drops:
		SG.SpawnManager.spawn_pickup(i, global_position)
	queue_free()
