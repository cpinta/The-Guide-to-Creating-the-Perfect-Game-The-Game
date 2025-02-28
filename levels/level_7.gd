extends Level

func _init():
	super._init()
	Game.speak_for_time("RULE 2: Nothing can go wrong
	EVER
	don't let your player feel anguish
	or else they will be sad
	negative feelings are bad", 9999, 0)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)
	pass

func loaded():
	super.loaded()
	pass
