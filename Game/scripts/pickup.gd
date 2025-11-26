extends RigidBody2D


enum states {  
	DROPPED,      
	HELD,  
	INUSE  
} 


@export var type : String = "none"



var child_scene = null
var state = states.DROPPED
var t = 0
var bobbing = false


var toss_speed = 100

func _ready() -> void:
	if type != "none":
		init(type)
	freeze = false
	
func init(item_type):
	type = item_type
	#pick up objects can either have their own scene, or just be a sprite
	#that way simple things like an ingredient can just be a sprite, and more complicated things that need 
	#nodes (like weapons) can have their own scene
	if ObjectManager.get_resource_type(type) == ObjectManager.types.SCENE:
		var instantiated_scene = load(ObjectManager.get_resource(type)).instantiate()
		add_child(instantiated_scene)
		child_scene = instantiated_scene
		$Sprite.texture = null
	else:
		$Sprite.texture = load(ObjectManager.get_resource(type))
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
	if child_scene and child_scene.has_method("set_idle"): child_scene.set_idle(true) #tell the item its on the floor, if it cares
	#you can change the toss speed but it works better to make the pickup object rigid body lighter

#give the item to the player
func pick_up():
	print("picking up " + type)
	reparent(SG.Player.hands) #stick it to the player's hands
	position = Vector2(0,0)
	state = states.HELD
	freeze = true #pause physics
	if child_scene and child_scene.has_method("set_idle"): child_scene.set_idle(false) #tell the item its being held, if it cares
