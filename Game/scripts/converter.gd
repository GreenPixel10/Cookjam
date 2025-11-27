extends Node2D


@export var type : String = "none"
@export var output_strength = 0.5

var conversion_table

var item_in = null
var item_out = null

func _ready():
	conversion_table = ObjectManager.conversions[type]
	

#signal from collision detector
func _on_area_2d_area_entered(area: Area2D) -> void:
	var item = area.get_parent()
	var item_name = item.type
	if conversion_table.has(item_name): #see if this item can be taken
		item_in = item_name
		item_out = conversion_table[item_name][0]
		var conversion_time = conversion_table[item_name][1]
		
		$Timer.start(conversion_time) #start the clock!
		item.queue_free() #delete the input item

#signal from timer
func _on_timer_timeout() -> void:
	var new_object = SG.SpawnManager.spawn_pickup(item_out, global_position)
	#could add some random here vvv
	var facing_vector = Vector2(0,1).rotated(get_parent().rotation)
	new_object.toss(facing_vector * output_strength)
	print("converted " + item_in + " to " + item_out + "!")
	item_in = null
	item_out = null
