extends Camera2D

class_name PlayerCamera

@onready var player: CharacterBody2D = $"../Player"
@onready var fade: Sprite2D = $Fade

var death : bool = false

var trackMode = Globals.Tracking.horizontal

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position.y = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (fade.modulate.a > 0 && !death):
		fade.modulate.a -= delta
	elif (fade.modulate.a < 1 && death):
		fade.modulate.a += delta
	
	if (trackMode == Globals.Tracking.horizontal):
		position.x = player.position.x
	elif (trackMode == Globals.Tracking.vertical):
		position.y = player.position.y


func _alter_tracking(newTrackMode : Globals.Tracking):
	trackMode = newTrackMode
	
	if (trackMode == Globals.Tracking.horizontal):
		position.y = 0
	elif (trackMode == Globals.Tracking.vertical):
		position.x = player.position.x

func _player_death():
	death = true
