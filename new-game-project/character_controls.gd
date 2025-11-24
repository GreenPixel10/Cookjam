extends CharacterBody2D

var move = Vector2(0,0)

var move_speed = 2



func _input(_event):
	pass


	
func _physics_process(delta: float):
	move = Vector2(0,0)
	if Input.is_action_pressed("move_left"):
		move += (Vector2(-move_speed, 0))
	if Input.is_action_pressed("move_right"):
		move += (Vector2(move_speed, 0))
	if Input.is_action_pressed("move_up"):
		move += (Vector2(0, -move_speed))
	if Input.is_action_pressed("move_down"):
		move += (Vector2(0, +move_speed))
	
	velocity = move * delta * 10000
	move_and_slide()
	#var _col : KinematicCollision2D = move_and_collide(move * delta)
	
