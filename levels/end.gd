extends Level

var intro:AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	Game.player.queue_free()
	intro = $intro
	intro.play("close")
	intro.animation_finished.connect(anim_done)
	Game.audio.stream = Game.acClose
	Game.audio.play()
	
	
	pass # Replace with function body.

func anim_done():
	Game.restart_game()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
