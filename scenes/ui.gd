class_name UI
extends CanvasLayer


var centerText: UI_CenterText

var pressStartText: Label

# Called when the node enters the scene tree for the first time.
func _ready():
	centerText = $Control/centering/text
	pressStartText = $Control/pressstart
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
