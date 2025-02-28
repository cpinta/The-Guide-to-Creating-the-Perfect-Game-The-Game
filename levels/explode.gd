extends Level

var sprite: AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite = $splode
	sprite.animation_finished.connect(anim_done)
	sprite.play("splode")
	Game.audio.stream = Game.acExplode
	Game.audio.play()
	pass # Replace with function body.

func anim_done():
	get_tree().quit()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
