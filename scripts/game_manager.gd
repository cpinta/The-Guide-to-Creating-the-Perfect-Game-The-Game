class_name GM
extends Node2D

enum GameState {TITLE_SCREEN=0, IN_GAME=1, PAUSED=2, END=3}

var state: GameState = GameState.IN_GAME

var levelIndex = 0
var curLevelObj: Level
var levelPaths: Array[String]

var gameUI: UI

var player: Player

var coinCount: int = 0

var sceneIntro: PackedScene = load("res://scenes/intro.tscn")
var intro: AnimatedSprite2D

var audio: AudioStreamPlayer2D
var audioCoin: AudioStreamPlayer2D

var acBum1: AudioStream
var acBum2: AudioStream
var acJump: AudioStream
var acCoin: AudioStream
var acHonk: AudioStream
var acOpen: AudioStream
var acClose: AudioStream
var acRev: AudioStream
var acExplode: AudioStream
var acDoor: AudioStream
var acBombBeep: AudioStream
var acCarRoof: AudioStream
var acWhoosh: AudioStream

# Called when the node enters the scene tree for the first time.
func _ready():
	gameUI = $UI
	load_intro()
	
	audio = $audio
	audioCoin = $audioCoin
	
	acBum1 = load("res://audio/bum1.mp3")
	acBum2 = load("res://audio/bum2.mp3")
	acJump = load("res://audio/jump.mp3")
	acCoin = load("res://audio/coin.mp3")
	acHonk = load("res://audio/honk.mp3")
	acOpen = load("res://audio/open page.mp3")
	acClose = load("res://audio/page close.mp3")
	acRev = load("res://audio/rev.mp3")
	acExplode = load("res://audio/splode.mp3")
	acDoor = load("res://audio/door.mp3")
	acBombBeep = load("res://audio/bombbeep.mp3")
	acCarRoof = load("res://audio/carroof.mp3")
	acWhoosh = load("res://audio/whoosh.mp3")
	
	
	levelPaths.append("res://levels/level_1.tscn");
	levelPaths.append("res://levels/level_2.tscn");
	levelPaths.append("res://levels/level_3.tscn");
	levelPaths.append("res://levels/level_3.1.tscn");
	levelPaths.append("res://levels/level_4.tscn");
	levelPaths.append("res://levels/level_5.tscn");
	levelPaths.append("res://levels/level_6.tscn");
	levelPaths.append("res://levels/level_7.tscn");
	levelPaths.append("res://levels/level_7.1.tscn");
	levelPaths.append("res://levels/level_7.2.tscn");
	levelPaths.append("res://levels/level_7.3.tscn");
	levelPaths.append("res://levels/level_8.tscn");
	levelPaths.append("res://levels/level_9.tscn");
	levelPaths.append("res://levels/level_10.tscn");
	levelPaths.append("res://levels/level_11.tscn");
	levelPaths.append("res://levels/end.tscn");
	
	#load_level(0)
	pass # Replace with function body.

func restart_game():
	unload_current_level()
	load_intro()

func load_intro():
	Game.gameUI.centerText.set_color(Color.WHITE)
	state = GameState.TITLE_SCREEN
	intro = sceneIntro.instantiate()
	self.add_child(intro)
	intro.play("idle")
	intro.animation_finished.connect(intro_ended)
	gameUI.pressStartText.visible = true

func intro_ended():
	intro.queue_free()
	load_level(0)
	state = GameState.IN_GAME
	pass

func play_sound(stream: AudioStream):
	audio.stream = stream
	audio.play()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	match state:
		GameState.TITLE_SCREEN:
			if Input.is_action_just_released("jump"):
				if intro.animation.get_basename() != "open":
					gameUI.pressStartText.visible = false
					intro.play("open")
				
					play_sound(acOpen)
			pass
		GameState.IN_GAME:
			if player == null:
				if get_tree().get_node_count_in_group("player") > 0:
					player = get_tree().get_nodes_in_group("player")[0]
					#player.justDied.connect(load_death_screen)
				pass
			pass
		GameState.PAUSED:
			pass
		GameState.END:
			pass
	pass

func coin_collected():
	coinCount += 1
	
	audioCoin.stream = acCoin
	audioCoin.play()
	pass

func next_level():
	levelIndex += 1
	if await(load_level(levelIndex)):
		
		pass
	else:
		
		pass
	
	pass
	
func speak_for_time(text: String, time:float, shake:float = 0):
	gameUI.centerText.set_center_text(text, time, shake)
	await get_tree().create_timer(time, true, false, true).timeout
	pass


	
func load_level(index: int):
	if index < len(levelPaths):
		if curLevelObj != null:
			curLevelObj.queue_free()
		gameUI.centerText.set_center_text("", 0, 0)
		curLevelObj = load(levelPaths[index]).instantiate()
		if player == null:
			if get_tree().get_node_count_in_group("player") > 0:
				player = get_tree().get_nodes_in_group("player")[0]
				#player.justDied.connect(load_death_screen)
			pass
		pass
		player.position = Vector2(48, -64)
		self.add_child.call_deferred(curLevelObj)
		
		#player.position = get_tree().get_nodes_in_group("start")[0].global_position
		#player.position = curLevelObj.start.position
		return true
		pass
	return false
	pass

func unload_current_level():
	if curLevelObj != null:
		curLevelObj.queue_free()
	
func load_level_path(str: String):
	if curLevelObj != null:
		curLevelObj.queue_free()
		gameUI.centerText.set_center_text("", 0, 0)
		curLevelObj = load(str).instantiate()
		if player == null:
			if get_tree().get_node_count_in_group("player") > 0:
				player = get_tree().get_nodes_in_group("player")[0]
				#player.justDied.connect(load_death_screen)
			pass
		pass
		player.position = Vector2(48, -48)
		self.add_child.call_deferred(curLevelObj)
		
		#player.position = get_tree().get_nodes_in_group("start")[0].global_position
		#player.position = curLevelObj.start.position
		return true
		pass
	pass
