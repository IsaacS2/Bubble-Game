extends Node2D

var player: Player

var startPos : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _new_start_position(new_pos : Vector2):
	startPos = new_pos


func _place_player():
	player = get_node("%Player")
	if (player):
		player.position = startPos
