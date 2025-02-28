class_name Car
extends AnimatableBody2D

var frontarea: Area2D
var toparea: Area2D
var anim: AnimatedSprite2D
var audio: AudioStreamPlayer2D

var stopped: bool = false
var travelDistance: float = 0

const SPEED: float = 75
const TRAVEL_MAX: float = 350

# Called when the node enters the scene tree for the first time.
func _ready():
	frontarea = $frontarea
	toparea = $toparea
	anim = $sprite
	audio = $audio
	
	frontarea.connect("body_entered", someone_in_front)
	frontarea.connect("body_exited", someone_left_in_front)
	
	toparea.connect("body_entered", someone_hit_top)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	if not stopped:
		anim.play("drive")
		var distance = SPEED * delta
		move_and_collide(Vector2.LEFT * distance)
		if travelDistance < TRAVEL_MAX:
			travelDistance += distance
		else:
			self.queue_free()
	else:
		anim.play("idle")
	pass

func play_sound(stream: AudioStream):
	audio.stream = stream
	audio.play()
	pass
	
func someone_hit_top(body: Node2D):
	if body is Player:
		var player = body as Player
		player.bounce_off_car()
		play_sound(Game.acCarRoof)
	pass
	
func someone_in_front(body: Node2D):
	if body is Player:
		var player = body as Player
		if player.state != Player.PlayerState.MOVED_BY_SPIKE:
			stopped = true
			play_sound(Game.acHonk)
		pass
	if body is Car:
		if body != self:
			stopped = true
	pass

func someone_left_in_front(body: Node2D):
	if body is Player or body is Car:
		stopped = false
		pass
	pass
