extends Level


# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	Game.speak_for_time("RULE 1: Make a good tutorial\nmake sure you show off your controls\nand how the player can utilize them,", 9999, 0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)
	pass

func loaded():
	super.loaded()
	pass
