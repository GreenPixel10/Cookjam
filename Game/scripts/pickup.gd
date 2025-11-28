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
var being_tossed = false

var initialized = false

var toss_speed = 100

func _ready() -> void:
	if type != "none":
		init(type)
	freeze = false
	
func init(item_type):
	
	#stops some thigns from double spawning
	#horrible solution but I don't care
	if initialized: return
	initialized = true
	
	
	
	type = item_type
	#pick up objects can either have their own scene, or just be a sprite
	#that way simple things like an ingredient can just be a sprite, and more complicated things that need 
	#nodes (like weapons) can have their own scene
	if ObjectManager.get_resource_type(type) == ObjectManager.types.SCENE:
		var instantiated_scene = load(ObjectManager.get_resource(type)).instantiate()
		add_child(instantiated_scene)
		child_scene = instantiated_scene
		$Sprite.texture = null
		if child_scene.has_method("init"): child_scene.init(item_type)
	else:
		$Sprite.texture = load(ObjectManager.get_resource(type))
		
	print("spawning item of type " + type)
	toss(Vector2(0,0))

func _process(delta: float) -> void:
	

	being_tossed = (!linear_velocity.length_squared() < 10000) and state == states.DROPPED
	
	#visible = !being_tossed
	
	#make it bob up and down (prob dont need)
	if bobbing and state == states.DROPPED: 
		t += delta
		$Sprite.position.y = sin(t) * 10

#release the item from the player and toss the item
func toss(direction):
	
	if get_parent() != null:
		reparent(SG.SpawnManager.get_parent()) #parent it to the map (may already in the map but whatever)
	else:
		SG.SpawnManager.get_parent().add_child(self)
	state = states.DROPPED
	freeze = false #turn on physics
	var toss_vector = direction * toss_speed * 10
	apply_impulse(toss_vector) #push out
	#print("tossing", toss_vector)
	if child_scene and child_scene.has_method("set_idle"): child_scene.set_idle(true) #tell the item its on the floor, if it cares
	#you can change the toss speed but it works better to make the pickup object rigid body lighter
	$combine_collide.monitoring = true
	$combine_collide.monitorable = true

#give the item to the player
func pick_up():
	#print("picking up " + type)
	reparent(SG.Player.hands) #stick it to the player's hands
	position = Vector2(0,0)
	state = states.HELD
	freeze = true #pause physics
	if child_scene and child_scene.has_method("set_idle"): child_scene.set_idle(false) #tell the item its being held, if it cares
	$combine_collide.monitoring = false
	$combine_collide.monitorable = false


func apply_damage(_dam):
	
	var attacked_by = SG.Player.holding
	if attacked_by == null: 
		print("uh-oh!")
		return #this should never happen!
		
	print(type + " hit by " + attacked_by.type)
		
	var output = ObjectManager.get_tool_conversion(type, attacked_by.type)
	if output == null: return #this tool doesnt do anything on this item
	
	SG.SpawnManager.spawn_pickup(output, global_position)
	queue_free()

func _on_combine_collide_area_entered(area: Area2D) -> void:
	
	var other_object = area.get_parent()
	if other_object.is_queued_for_deletion(): return #already combined
	
	var other_type = other_object.type
	var output = ObjectManager.get_combo(type, other_type) #get the correct output type, if there is one
	
	if output != null:
		var avg_pos = (global_position + other_object.global_position) / 2  #spawn it between the 2 items
		SG.SpawnManager.spawn_pickup(output, avg_pos)
		other_object.queue_free() #delete the other object
		queue_free() #delete this object

func get_toss_damage():
	return ObjectManager.get_toss_damage(type) if being_tossed else 0
