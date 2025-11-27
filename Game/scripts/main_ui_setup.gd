extends CanvasLayer

# delaying assigning vars, until node is added to scene tree
@onready var health_bar = $HealthBar
@onready var mana_bar = $ManaBar

func _ready():
	# storing refs in global singleton so that they can be globally accessed
	SG.HealthBar = health_bar
	SG.ManaBar = mana_bar
	# runs after everything else is ready
	call_deferred("_initialize_ui")

func _initialize_ui():
	# once player exists, this sets up health + mana bars
	if is_instance_valid(SG.Player):
		SG.HealthBar._setup_health_bar(SG.Player.health)
		SG.ManaBar._setup_mana_bar(SG.Player.mana)
