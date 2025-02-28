extends Level

func _init():
	super._init()
	Game.gameUI.centerText.set_color(Color.BLACK)
	end_speed()
	pass

func end_speed():
	await Game.speak_for_time("And that's all there is to it!", 3)
	await Game.speak_for_time("And that's all there is to it!
	With these rules in mind, you'll be making
the next big hit game in no time!", 5)
	await Game.speak_for_time("And that's all there is to it!
	With these rules in mind, you'll be making
the next big hit game in no time!
	Just remember: if it ain't perfect,
	it's not worth it!", 10)
	Game.load_level_path("res://levels/end.tscn")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)
	pass

func loaded():
	super.loaded()
	pass
