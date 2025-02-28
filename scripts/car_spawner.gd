class_name CarSpawner
extends Node2D

var start: Area2D
var end: Node2D
var audio: AudioStreamPlayer2D

const TIME_BT_SPAWNS: float = 1
var spawnTimer: float = 0

var prefabCar = load("res://scenes/car.tscn")

var cars: Array[Car]

# Called when the node enters the scene tree for the first time.
func _ready():
	start = $start
	end = $end
	audio = $audio
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if spawnTimer < TIME_BT_SPAWNS:
		spawnTimer += delta
	else:
		spawn_car()
		spawnTimer = 0
	pass

func play_sound(stream: AudioStream):
	audio.stream = stream
	audio.play()
	pass

func spawn_car():
	if start.has_overlapping_bodies():
		return
	var car = prefabCar.instantiate()
	self.add_child(car)
	car.position = start.position
	play_sound(Game.acRev)
	pass
