extends Node2D


## set by the spawn system
var speed = 100
var hp = 30
var death_drops = ["none"]
var tex : Resource = null
var flip_when_right = true
var damage = 0

var t = 0

# temp variables to test health bar

var dmg_cooldown = 1.0
var can_damage = true
var dead = false
var death_speed = 1.5
var target = null
var pickup = preload("res://scenes/pickup.tscn")




func _ready():
	# collision detection for mob damage to player
	$Nav.set_navigation_map(SG.Tilemap.get_navigation_map())
	if $Area2D.has_signal("area_entered"):
		$Area2D.area_entered.connect(_on_area_entered)
	

func init(type):
	var data = ObjectManager.mobs[type]
	speed = data[0]
	hp = data[1]
	damage = data[2]
	death_drops = data[3]
	tex = load(data[4])
	flip_when_right = data[5]
	$AnimatedSprite2D.sprite_frames = tex
	$AnimatedSprite2D.play("walk")
	

func _process(delta: float):
	t += delta
	
	if !$dam_effect_timer.is_stopped():
		var p = $dam_effect_timer.time_left
		var colA = Color("ff0a06")
		var colB = Color("ffffff")
		var mod_colour = lerp(colB, colA, p)
		$AnimatedSprite2D.modulate = mod_colour

	
	if dead: return
	###PATHFINDING
	if(SG.Player != null):
		if t > 0.5:
			$Nav.set_target_position(SG.Player.global_position) #set target to player
			t = 0
		
		

		var next_point = $Nav.get_next_path_position() #get the next point
		
		#move towards it
		var movevec : Vector2 = (next_point - global_position)
		movevec = movevec.normalized()
		movevec *= speed * delta
		global_position += movevec
		
		if !movevec.is_zero_approx() && $AnimatedSprite2D.animation != "attack":
			if movevec.x > 0:
				$AnimatedSprite2D.flip_h = flip_when_right
			else:
				$AnimatedSprite2D.flip_h = !flip_when_right
		
		
		#set animation:
		#$chef_sprite.animation = "walk"

func apply_damage(dam):
	if dead: return
	if dam == 0: return
	$dam_effect_timer.start(0.5)
	hp -= dam
	print("enemy took", dam, "damage!")
	if hp <= 0:
		die()

func die():
	print("enemy died")
	dead = true
	$AnimatedSprite2D.play("die")
	$AnimatedSprite2D.speed_scale = death_speed

# mob damages when entering hurtbox and not in damage cooldown
# has issues when player stands still
func _on_area_entered(area: Area2D):
	if dead: return
	if area.name == "hurtbox" and can_damage:
		var player = area.get_parent()
		if player.has_method("apply_damage"):
			$AnimatedSprite2D.play("attack")
			target = player
			target.apply_damage(damage)
			target = null
			can_damage = false
			await get_tree().create_timer(dmg_cooldown).timeout
			can_damage = true


func _on_area_2d_area_entered(area: Area2D) -> void:
	
	if(area.get_parent().has_method("get_toss_damage")):
		apply_damage(area.get_parent().get_toss_damage())
		


func _on_animated_sprite_2d_animation_finished() -> void:
	if dead:
		for i in death_drops:
			SG.SpawnManager.spawn_pickup(i, global_position)
		queue_free()
	else:
		$AnimatedSprite2D.play("walk")
		
	"""
	target.apply_damage(damage)
	target = null
	can_damage = false
	await get_tree().create_timer(dmg_cooldown).timeout
	can_damage = true
	"""
