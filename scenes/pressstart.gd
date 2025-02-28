extends Label

var FLOAT_DISTANCE: float = 2
var LERP_DISTANCE: float = 1
var LERP_SPEED: float = 2
var direction: int = 1
var origin: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	origin = position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if  abs(position.y - (origin.y + FLOAT_DISTANCE)) < LERP_DISTANCE :
		direction = -1
	elif abs(position.y - (origin.y - FLOAT_DISTANCE)) < LERP_DISTANCE :
		direction = 1
	position.y = lerpf(position.y, origin.y + (direction * FLOAT_DISTANCE), LERP_SPEED * delta)
	pass
