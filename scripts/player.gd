class_name Player
extends CharacterBody2D

enum PlayerState {FREE=0, MOVED_BY_SPIKE=1}

var state: PlayerState = PlayerState.FREE

var anim: AnimatedSprite2D
var groundDetect: Area2D
var groundRayR: RayCast2D
var audio: AudioStreamPlayer2D

const SPEED = 80.0
const JUMP_VELOCITY = 325.0
const CAR_BOUNCE_VELOCITY: float = 800
const MAX_COLLISIONS = 6

var spikeDestination: Vector2

@export var publicVelocity: Vector2

var inputVector: Vector2
var direction: int = -1

var isOnGround: bool

var lastWalkFrame: int

func _ready():
	groundDetect = $groundDetect
	anim = $anim
	audio = $audio
	
	lastWalkFrame = 0
	pass

func play_sound(stream: AudioStream):
	audio.stream = stream
	audio.play()
	pass

func _process(delta):
	
	if inputVector.x != 0:
		set_direction(inputVector.x)
	if isOnGround:
		if velocity.x != 0:
			anim.play("walk")
			var frame = anim.frame
			if lastWalkFrame != frame:
				if frame == 0:
					play_sound(Game.acBum1)
					pass
				else:
					play_sound(Game.acBum2)
					pass
			
			lastWalkFrame = frame
		else:
			anim.play("idle")
	else:
		if velocity.y > 0:
			anim.play("jump")
		else:
			anim.play("fall")
	pass
	#
	#if anim.animation.get_basename() == "walk":
		#if anim.frame != leftStep:
			

func _physics_process(delta):
	match state:
		PlayerState.FREE:
			anim.z_index = 0
			get_inputVector()
			collide(delta)
			
			isOnGround = len(groundDetect.get_overlapping_bodies()) > 0
			
			# Add the gravity.
			if not is_on_floor():
				velocity -= get_gravity() * delta

			# Handle jump.
			if Input.is_action_just_pressed("jump") && isOnGround:
				velocity.y = JUMP_VELOCITY
				play_sound(Game.acJump)

			if inputVector.x != 0:
				velocity.x = inputVector.x * SPEED
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED)
			pass
		PlayerState.MOVED_BY_SPIKE:
			anim.z_index = 1
			if global_position.distance_to(spikeDestination) > 1:
				global_position = global_position.lerp(spikeDestination, 5 * delta)
			else:
				global_position = spikeDestination
				anim.speed_scale = 1
				velocity = Vector2.ZERO
				state = PlayerState.FREE
			pass

func goto_spike(dest: Vector2):
	spikeDestination = dest
	state = PlayerState.MOVED_BY_SPIKE
	#set_direction(direction * -1)
	anim.speed_scale = 0
	
	play_sound(Game.acWhoosh)
	pass
	
func bounce_off_car():
	velocity.y = CAR_BOUNCE_VELOCITY
	pass

func collide(delta: float):
	var collision_count := 0
	var collision = move_and_collide(Vector2(velocity.x, -velocity.y) * delta)
	while collision and collision_count < MAX_COLLISIONS:
		var collider = collision.get_collider()
		var entity = collider.get_parent()
		#if entity is Player:
			#
			#pass
		#elif entity is Enemy:
			#var enemy = entity as Enemy
			#if self is Player:
				#if enemy.DAMAGES_ON_CONTACT:
					#enemy.attack_enemy(self, enemy.attack_damage, enemy.attack_knockback, self.global_position - enemy.global_position)
		var normal = collision.get_normal()
		var remainder = collision.get_remainder()
		var angle = collision.get_angle()
		velocity = Vector2(velocity.x + (-1 * abs(normal.x) * velocity.x), velocity.y + (-1 * abs(normal.y) * velocity.y))
		remainder = Vector2(remainder.x + (-1 * abs(normal.x) * remainder.x), remainder.y + (-1 * abs(normal.y) * remainder.y))
		
		collision_count += 1
		collision = move_and_collide(remainder)
		pass
	pass

func get_inputVector():
	inputVector.x = Input.get_axis("left", "right")
	inputVector.y = Input.get_axis("up", "down")
	return inputVector
	
func set_direction(dir: int):
	direction = dir
	if dir == -1:
		anim.flip_h = true
		pass
	if dir == 1:
		anim.flip_h = false
		pass
