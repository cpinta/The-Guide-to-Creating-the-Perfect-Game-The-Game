class_name Spike
extends Node2D

var sprite: Sprite2D
var col: StaticBody2D

var dest: Node2D

var area: Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite = $sprite
	col = $collider
	area = $"fall area"
	dest = $destination
	
	area.connect("body_entered", fall_area_entered)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		
	pass

func fall_area_entered(body: Node2D):
	if body is Player:
		var player = body as Player
		if player.state != Player.PlayerState.MOVED_BY_SPIKE:
			player.goto_spike(dest.global_position)
		pass
	pass
