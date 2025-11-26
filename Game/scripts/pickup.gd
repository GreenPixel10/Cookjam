extends RigidBody2D






enum states {  
	DROPPED,      
	HELD,  
	INUSE  
} 

var type = "none"
var state = states.DROPPED
var t = 0
var bobbing = false


var toss_speed = 10

func _ready() -> void:
	freeze = false
	
func init(item_type):
	type = item_type
	$Sprite.texture = load(ObjectManager.get_texture(type))
	print("spawning item of type " + type)

func _process(delta: float) -> void:
	
	#make it bob up and down (prob dont need)
	if bobbing and state == states.DROPPED: 
		t += delta
		$Sprite.position.y = sin(t) * 10

#release the item from the player and toss the item
func toss(direction):
	reparent(SG.SpawnManager.get_parent()) #add it to the map
	state = states.DROPPED
	freeze = false #turn on physics
	apply_impulse(direction * toss_speed * 10) #push out
	#you can change the toss speed but it works better to make the pickup object rigid body lighter

#give the item to the player
func pick_up():
	reparent(SG.Player.hands) #stick it to the player's hands
	position = Vector2(0,0)
	state = states.HELD
	freeze = true #pause physics
