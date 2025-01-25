extends Camera2D

class_name PlayerCamera

@onready var player: CharacterBody2D = $"../Player"

var trackMode = Globals.Tracking.horizontal

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (trackMode == Globals.Tracking.horizontal):
		position.x = player.position.x
	elif (trackMode == Globals.Tracking.vertical):
		position.y = player.position.y


func _alter_tracking(newTrackMode : Globals.Tracking):
	trackMode = newTrackMode
