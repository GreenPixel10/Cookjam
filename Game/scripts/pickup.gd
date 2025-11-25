extends Node2D




var type = "none"



var t = 0

func _ready() -> void:
	pass
	
func init(item_type):
	type = item_type
	$Sprite.texture = load(ObjectManager.get_texture(type))
	print("spawning item of type " + type)

func _process(delta: float) -> void:
	t += delta
	$Sprite.position.y = sin(t) * 10
	
