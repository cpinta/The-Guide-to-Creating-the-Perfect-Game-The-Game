extends Level


# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	Game.speak_for_time("RULE 2: Nothing can go wrong", 9999, 0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)
	pass

func loaded():
	super.loaded()
	pass
