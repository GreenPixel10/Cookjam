extends CanvasLayer

var blurbs = [
	"Use WASD to move around the dungeon",
	"Use SPACE to pick up and throw objects",
	"Pits will spawn enemies. Press LMB to use your weapon!",
	"Press TAB to view the recipie book. Use A/D to find the recipie for Mouse Bites",
	"Follow the recipie! You can use weapons for both fighting and meal prepping. Toss items to combine them or to put them into workstations like the fireplace.",
	"Press RMB to eat a completed meal. This is the only way to recover health!",
	"In the next room, try using the mace and the fountain to create some Skelly Jelly. The mace is great for grinding and crushing both monsters AND ingredients!",
	"If you toss an item in a pit, you can't get it back. Use this if you need to clear some space, but don't lose anything important!",
	"Looks like you're all set! Good luck..."
]

func set_text(index):
	$Panel/RichTextLabel.text = blurbs[index]
