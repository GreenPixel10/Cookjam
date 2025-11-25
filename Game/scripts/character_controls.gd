extends CharacterBody2D

var move = Vector2(0,0)

var move_speed = 10

var hp = 100

@onready var weapon = $Knife

func _ready():
	SG.Player = self
	
	
func apply_damage(dam):
	hp -= dam
	if hp <= 0:
		queue_free()
	
func _input(event: InputEvent):
	if event.is_action_pressed("attack"):
		weapon.attack()
	
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
		
