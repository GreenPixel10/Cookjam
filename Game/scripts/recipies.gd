extends Control

var showing = false


var recipies = [
	"""[b]Granny's Classic Rat Stew[/b]
[u]Fill a pot[/u] with stale water.
[u]Dice your rat[/u] and [u]add to the pot[/u]. 
[u]Warm the pot[/u] over an open flame.
Season to taste, and enjoy!
	""",
	
	"""[b]Skelly Jelly[/b]
This is a favourite among no adventurers.
[u]Grind some bones[/u] into a fine powder, and let soak in [u]water[/u] until set.
What it lacks in taste it makes up for in convienience
	""",
	
	"""[b]Viper Burrito[/b]
[u]Grind up a meat of your choice[/u], and [u]cook[/u] over medium heat.
Wrap in the [u]skin of a viper[/u] using our patented roll and fold technique.
	""",
	
	"""[b]Bone Broth[/b]
This hearty soup almost makes you forget your impending death.
[u]Fill a pot[/u] with water. Add your [u]bones[/u] and [u]boil[/u] until you smell a beautiful aroma. 
Remove from heat and eat once cool. Garnish with your favourite seasoning (Optional).
	""",
	
	"""[b]Mouse Bites[/b]
[u]Chop your favourite rodent, and fry[/u] until crispy and gold. A family classic!
	""",
	
	"""[b]Minotaur Steak[/b]
If you're feeling a life of luxury, [u]grill up a nice minotaur steak[/u]: Its as simple as meat and heat!
	""",
	
	"""[b]Secret Seasoning[/b]
Did you know [u]ground snakeskin[/u] adds a fantastic flavour to soups and stews?
Try it today to elevate your mediocre dishes!
	""",
	
	
]

var index = 0



func _ready():
	hide()
	showing = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("recipies"):
		if !showing:
			get_tree().paused = true # pause the game
			showing = true
			show()
		else:
			get_tree().paused = false # unpause the game
			hide()
			showing = false
	if showing:
		if event.is_action_pressed("move_left"):
			index -= 1
		if event.is_action_pressed("move_right"):
			index += 1	
		index = (index + len(recipies)) % len(recipies)
		$Panel/RichTextLabel.text = recipies[index]
		

func _process(_delta: float) -> void:
	pass
