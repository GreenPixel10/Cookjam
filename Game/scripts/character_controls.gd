extends CharacterBody2D

var move = Vector2(0,0)
var move_speed = 10
var health = 100
var mana = 100
var max_mana = 100

var holding = null #reference to the itemw
var hands

func _ready():
	SG.Player = self
	hands = $hands
	
	# player taking damage, currently no death implementation
func apply_damage(dam):
	health -= dam
	if is_instance_valid(SG.HealthBar):
		SG.HealthBar.change_value(health) 
	if health <= 0:
		queue_free()

# reduces mana, then updates manabar
func use_mana(amount):
	mana -= amount
	if mana < 0:
		mana = 0
	if is_instance_valid(SG.ManaBar):
		SG.ManaBar.change_value(mana)
	return mana >= 0

# opposite of use_mana, just temp to test mana bar
func restore_mana(amount):
	mana += amount
	if mana > max_mana:
		mana = max_mana
	if is_instance_valid(SG.ManaBar):
		SG.ManaBar.change_value(mana)

func _input(event: InputEvent):
	
	#project settings -> keybinds
	if event.is_action_pressed("attack"):
		if holding:
			var potential_weapon = holding.child_scene
			if potential_weapon and potential_weapon.has_method("attack"):
				potential_weapon.attack()
				#use_mana(10)
		
		
		
	if event.is_action_pressed("hold"):
		if(holding != null): #if holding something already, toss it

			var direction = (get_global_mouse_position() - global_position).normalized()
			holding.toss(direction)
			holding = null
		else: #if not holding anything, check if anything is there and if so pick one up
			var within_grab_range = $grab.get_overlapping_areas()
			print(within_grab_range)
			if len(within_grab_range) > 0:
				holding = within_grab_range[0].get_parent()
				holding.pick_up()

func _physics_process(delta: float):
	#read key inut
	if Input.is_action_pressed("move_left"):
		move += (Vector2(-move_speed, 0))
	if Input.is_action_pressed("move_right"):
		move += (Vector2(move_speed, 0))
	if Input.is_action_pressed("move_up"):
		move += (Vector2(0, -move_speed))
	if Input.is_action_pressed("move_down"):
		move += (Vector2(0, +move_speed))
	
	velocity = move * delta * 500
	move_and_slide() #apply the velocity
	
	move *= 0.7 #slow the player down until they stop
	if move.length() < 0.1:
		move = Vector2(0,0) #empty vector

	if velocity.is_zero_approx(): $chef_sprite.animation = "idle"
	else: $chef_sprite.animation = "walk"
	
	if !velocity.is_zero_approx():
		if velocity.x > 0:
			$chef_sprite.flip_h = false
		else:
			$chef_sprite.flip_h = true
		
		
