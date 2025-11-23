extends CharacterBody2D

var move = Vector2(0,0)

var move_speed = 10

func _input(event):
	move = Vector2(0,0)
	if event.is_action_pressed("move_left"):
		move += (Vector2(-move_speed, 0))
	if event.is_action_pressed("move_right"):
		move += (Vector2(move_speed, 0))
	if event.is_action_pressed("move_up"):
		move += (Vector2(0, -move_speed))
	if event.is_action_pressed("move_down"):
		move += (Vector2(0, +move_speed))
	
	move_and_collide(move)
