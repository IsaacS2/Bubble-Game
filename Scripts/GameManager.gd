extends Node2D

@export var StartMenu : PackedScene = load("res://Scenes/StartMenu.tscn")
@export var Level1 : PackedScene = load("res://Scenes/Level1.tscn")

var player: Player
var camera: PlayerCamera
var win: Win
var startPos : Vector2 = Vector2(8, 17)
var elementsRetrieved : bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	
	var _startMenu = StartMenu.instantiate()
	add_child(_startMenu)
	
	_startMenu.level_start.connect(_start_game)


func _start_game() -> void:
	print("restart from game")
	var _root = get_tree().root
	var _destructibleScene = get_child(-1)
	_destructibleScene.queue_free()
	
	var _level1 = Level1.instantiate()
	add_child(_level1)
	if (_level1 is Level):
		print("level obtained")
		_place_player()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _new_start_position(new_pos : Vector2):
	startPos = new_pos

func _restart_entire_game():
	var _root = get_tree().root
	var _destructibleScene = get_child(-1)
	_destructibleScene.queue_free()
	
	var _startMenu = StartMenu.instantiate()
	add_child(_startMenu)
	
	_startMenu.level_start.connect(_start_game)


func _place_player():
	player = get_node("Level1/%Player")
	if (player):
		print("player found")
		player.global_position = startPos
		player.checkpoint_reached.connect(_new_start_position)
		
	camera = get_node("Level1/%Camera2D")
	if (camera and camera is PlayerCamera):
		print("camera found")
		camera.restart_game.connect(_start_game)
		
	win = get_node("Level1/%Win")
	if (win and win is Win):
		win.restart_entire_game.connect(_restart_entire_game)
