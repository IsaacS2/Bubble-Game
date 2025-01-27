extends Camera2D

class_name PlayerCamera

signal restart_game

@onready var player: CharacterBody2D = $"../Player"
@onready var Sun: Killzone = $"../SunKillzone"
@onready var background: Sprite2D = $"../Background"
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
		if (fade.modulate.a >= 1):
			emit_signal("restart_game")
			print("restart")
	
	if (trackMode == Globals.Tracking.horizontal):
		position.x = player.position.x
		background.position.x = player.position.x / 2.25
	elif (trackMode == Globals.Tracking.vertical):
		position.y = player.position.y
		background.position.y = position.y


func _alter_tracking(newTrackMode : Globals.Tracking):
	trackMode = newTrackMode
	
	if (trackMode == Globals.Tracking.horizontal):
		background.position.y = 0
		position.y = 0
		background.position.x = player.position.x / 2.25
		
	elif (trackMode == Globals.Tracking.vertical):
		position.x = player.position.x
		Sun.position.x = player.position.x

func _player_death():
	death = true
