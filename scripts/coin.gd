class_name Coin
extends Node2D

var collectArea: Area2D
var magnetArea: Area2D
var anim: AnimatedSprite2D
var audio: AudioStreamPlayer2D

var hasTarget: bool = false
var target: Player

const MOVE_SPEED: float = 100

const MAGNET_DELAY: float = 1
const MAGNET_DELAY_ADDITION: float = 0.025
var magnetDelayTimer: float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	collectArea = $"collect area"
	magnetArea = $"magnet area"
	anim = $sprite
	audio = $audio
	
	anim.play("idle")
	
	collectArea.connect("body_entered", entered_collect)
	magnetArea.connect("body_entered", entered_magnet)
	magnetArea.connect("area_entered", entered_magnet)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if hasTarget: 
		if magnetDelayTimer > 0:
			magnetDelayTimer -= delta
		else:
			global_position = global_position.move_toward(target.global_position, MOVE_SPEED * delta)
			pass
	pass

func entered_magnet(body: Node2D):
	if hasTarget:
		return
	if body is Player:
		set_target(body, MAGNET_DELAY)
		set_timer_for_neighbors()
	pass

func set_timer_for_neighbors():
	var array = magnetArea.get_overlapping_areas()
	for area in array:
		if area.get_parent() is Coin:
			var coin: Coin = area.get_parent()
			if coin != self:
				if not coin.hasTarget:
					coin.set_target(target, magnetDelayTimer+MAGNET_DELAY_ADDITION)
					coin.set_timer_for_neighbors()
				pass
			pass
		pass
	pass

func set_target(body:Player, timer:float):
	target = body
	hasTarget = true
	magnetDelayTimer = timer
	pass

func entered_collect(body: Node2D):
	if body is Player:
		Game.coin_collected()
		queue_free()
	pass
