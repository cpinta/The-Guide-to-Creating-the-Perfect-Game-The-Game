extends Level

enum FLState{
	PreLights,
	Intro,
	Countdown,
	Splode
}

var state: FLState = FLState.PreLights

var backSprite: AnimatedSprite2D
var door: Door
var doorLocation: Vector2

var numbers: Array[AnimatedSprite2D]

const PRE_LIGHTS_TIME: float = 3
const BOMB_TIME: float = 360

var oldTimer: float = 0
var timer: float = 0

func _ready():
	super._ready()
	backSprite = $backnode/backsprite
	door = $door
	doorLocation = door.position
	
	numbers.append($backnode/backsprite/first)
	numbers.append($backnode/backsprite/second)
	numbers.append($backnode/backsprite/third)
	numbers.append($backnode/backsprite/fourth)
	
	change_state(FLState.PreLights)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)
	match state:
		FLState.PreLights:
			if timer > 0:
				timer -= delta
			else:
				change_state(FLState.Intro)
			pass
		FLState.Intro:
			pass
		FLState.Countdown:
			if timer > 0:
				timer -= delta
			else:
				change_state(FLState.Splode)
			if floor(timer) != floor(oldTimer):
				show_timer_time(timer)
			oldTimer = timer
			pass
		FLState.Splode:
			Game.load_level_path("res://levels/explode.tscn")
			pass
	pass

func show_timer_time(time: int):
	var str: String = "0000"
	
	var min: int = time/60
	var minStr: String = str(min)
	var secs: int = time - (min * 60)
	var secsStr: String = str(secs)
	
	if len(secsStr) > 1:
		str[3] = secsStr[1]
		str[2] = secsStr[0]
		pass
	else:
		str[3] = secsStr[0]
		
	
	if len(minStr) > 1:
		str[1] = minStr[1]
		str[0] = minStr[0]
	else:
		str[1] = minStr[0]
		
	
	var i = 0
	while i < len(numbers):
		numbers[i].play(str[i])
		i += 1
		pass
		
	Game.play_sound(Game.acBombBeep)
	pass

func loaded():
	super.loaded()
	pass

func change_state(newState: FLState):
	state = newState
	match state:
		FLState.PreLights:
			backSprite.play("off")
			door.position = Vector2(1000, 1000)
			for num in numbers:
				num.visible = false
			pass
			timer = PRE_LIGHTS_TIME
			await Game.speak_for_time("RULE 3", 100)
			pass
		FLState.Intro:
			backSprite.play("on")
			intro_speech()
			pass
		FLState.Countdown:
			for num in numbers:
				num.visible = true
			
			timer = BOMB_TIME
			intro_speech2()
			pass
		FLState.Splode:
			pass
	pass

func intro_speech():
	await Game.speak_for_time("RULE 3", 1)
	await Game.speak_for_time("RULE 3.", 0.5)
	await Game.speak_for_time("RULE 3..", 0.5)
	await Game.speak_for_time("RULE 3...", 1)
	await Game.speak_for_time("...", 2)
	await Game.speak_for_time("Is that a bomb?", 2)
	change_state(FLState.Countdown)
	pass

func intro_speech2():
	await Game.speak_for_time("Is that a bomb?", 1)
	await Game.speak_for_time("WOAH! It is a bomb!", 3)
	await Game.speak_for_time("Okay... This can't be right", 4)
	await Game.speak_for_time("Here                       ", 1)
	door.position = doorLocation
	Game.play_sound(Game.acDoor)
	await Game.speak_for_time("Here go through this door", 5)
	await Game.speak_for_time("You'll be safe in there", 4)
	await Game.speak_for_time("We don't want to know what's gonna
happen when this thing blows", 4)
	await Game.speak_for_time("...", 3) #25
	await Game.speak_for_time("It's over there", 3)
	await Game.speak_for_time("in the corner", 4)
	await Game.speak_for_time("um... did we not follow rule 1?", 5)
	await Game.speak_for_time("do you not know the controls?", 5)
	await Game.speak_for_time("okay, now I feel bad", 5)
	await Game.speak_for_time("how can I talk about all these
	rules", 5)
	await Game.speak_for_time("but they arent't even effective?", 5)
	await Game.speak_for_time("...", 5)
	await Game.speak_for_time("no, no, no that can't be right", 5)
	await Game.speak_for_time("you're messing with me, right?", 5)
	await Game.speak_for_time("yeah! this is all a joke!", 5)
	await Game.speak_for_time("haha", 2)
	await Game.speak_for_time("real funny, bucko!", 3) #82
	await Game.speak_for_time("now get over to that door over there,
	you little prankster!", 5)
	await Game.speak_for_time("haha", 3) #90
	await Game.speak_for_time("ha", 1)
	await Game.speak_for_time("haha", 1)
	await Game.speak_for_time("hahaha", 2)
	await Game.speak_for_time("hahahaha", 2)
	await Game.speak_for_time("hahahahaha", 4) #100
	await Game.speak_for_time("...", 5)
	await Game.speak_for_time("alright, its not funny anymore", 5)
	await Game.speak_for_time("please, just go through the door", 5)
	await Game.speak_for_time("my publisher is gonna be really mad at
								me if the player explodes in a
								room that's a giant bomb", 8)
	await Game.speak_for_time("like, first of all, this is a clear
	violation of rule 2!", 5)
	await Game.speak_for_time("second of all, if you truly don't know the 
controls, I violated rule 1!", 5)
	await Game.speak_for_time("AHHHH", 2)
	await Game.speak_for_time("", 2)
	await Game.speak_for_time("This book was all a waste of time...", 5)
	await Game.speak_for_time("If I can't even abide by the rules", 3)
	await Game.speak_for_time("If I can't even abide by the rules
	whats the point", 3)
	await Game.speak_for_time("I don't even know who placed this
room here", 5)
	await Game.speak_for_time("had to have been one of the editors", 5) 
	await Game.speak_for_time("are giant bombs a thing people just have
	in office spaces?", 5) #153
	await Game.speak_for_time("now that I think about it", 5)
	await Game.speak_for_time("if this copy does explode. Do all copies
	explode?", 5)
	await Game.speak_for_time("this could be devastating!", 5)
	await Game.speak_for_time("this could hurt tens of millions of
	lives!", 5)
	await Game.speak_for_time("okay, maybe thousands of lives", 5)
	await Game.speak_for_time("alright, hundreds?", 5)
	await Game.speak_for_time("actually, I could get lucky, not sell any
	copies and not hurt anybody at all!", 8)
	await Game.speak_for_time("that would be... so cool", 4) #210
	await Game.speak_for_time("sure, I'd be a failed artist but I wouldn't
	be a murderer!", 5)
	await Game.speak_for_time("...", 5)
	await Game.speak_for_time("y'know, this is kind of all I have", 5)
	await Game.speak_for_time("being an established and respected writer
	has been my greatest dream", 5)
	await Game.speak_for_time("and, I don't know, if this thing fails
	what am I supposed to do?", 5)
	await Game.speak_for_time("I promised a lot with this book. I told
	them that it would be PERFECT", 5) #240
	await Game.speak_for_time("or at least the games created would be", 5)
	await Game.speak_for_time("if I dont deliver on that promise...
	I'll be back on my butt again", 5)
	await Game.speak_for_time("this was my big shot. My moment.", 5)
	await Game.speak_for_time("Maybe destiny is pointing me in
	another direction", 5)
	await Game.speak_for_time("hell, I didn't even deserve it in the first
	place", 5)
	await Game.speak_for_time("it was a promise driven purely by ego 
	instead of fact", 5)
	await Game.speak_for_time("thing is: there is no guide to creating a
	perfect game", 5)
	await Game.speak_for_time("creating a game requires time, effort, and
	passion", 5)
	await Game.speak_for_time("'perfect' games are the product of
	perfecting a craft", 5)
	await Game.speak_for_time("the greatest rule in creating games is to
	follow your heart", 5) #290
	await Game.speak_for_time("so I guess, in the end", 5)
	await Game.speak_for_time("you could say that the real perfect game", 5)
	await Game.speak_for_time("was inside of you the whole time", 5)
	await Game.speak_for_time("y'know what?", 5)
	await Game.speak_for_time("even though I've intensely
	embarrassed myself today", 5)
	await Game.speak_for_time("and maybe shattered my dreams to an
	immeasurable amount", 5) #320
	await Game.speak_for_time("I'm glad that I was able to spend this time
with you", 5)
	await Game.speak_for_time("I'm glad that I was able to spend this time
with you, friend", 5) #327
	await Game.speak_for_time("can I call you a friend? :)", 5)
	await Game.speak_for_time("I can't actually hear what you said", 5)
	await Game.speak_for_time("I'm just going to assume you said yes", 5) #342
	await Game.speak_for_time("So thanks for atleast reading through this
silly thing", 5)
	await Game.speak_for_time("looks like this might be the end of the line", 5)
	await Game.speak_for_time("thanks for playing my book: the game :)", 5)
	await Game.speak_for_time("thanks for playing my book: the game,
	friend :)", 5)
	pass
