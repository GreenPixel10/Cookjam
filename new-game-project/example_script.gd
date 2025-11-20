extends Sprite2D

var t = 0


func _ready():
	print("laoded!")
	##gets called once when the object the script is attached to loads

func _process(delta): ##process gets called every game frame
	t += delta
	global_position.x = sin(t) * 100 + 200
	
	$childddd.position.x = sin(t + 67) * 40 + 200 #u can use the dollar sign to reference children nodes
