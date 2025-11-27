extends Node2D

var speed = 100
var hp = 30
var death_drops = ["default"]

var t = 0

# temp variables to test health bar
var damage = 10
var dmg_cooldown = 1.0
var can_damage = true

var pickup = preload("res://scenes/pickup.tscn")

func _ready():
	# collision detection for mob damage to player
	$Nav.set_navigation_map(SG.Tilemap.get_navigation_map())
	if $Area2D.has_signal("area_entered"):
		$Area2D.area_entered.connect(_on_area_entered)
	

func _process(delta: float):
	t += delta
	
	
	if t > 0.5:
		$Nav.set_target_position(SG.Player.global_position) #set target to player
		t = 0
	

	var next_point = $Nav.get_next_path_position() #get the next point
	
	#move towards it
	var movevec : Vector2 = (next_point - global_position)
	movevec = movevec.normalized()
	movevec *= speed * delta
	global_position += movevec
	
	#$Knife.attack()

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

# mob damages when entering hurtbox and not in damage cooldown
# has issues when player stands still
func _on_area_entered(area: Area2D):
	if area.name == "hurtbox" and can_damage:
		var player = area.get_parent()
		if player.has_method("apply_damage"):
			player.apply_damage(damage)
			can_damage = false
			await get_tree().create_timer(dmg_cooldown).timeout
			can_damage = true
