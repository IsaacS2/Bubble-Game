extends Node2D

@export var bullet : PackedScene = load("res://Scenes/PlayerBullet.tscn")

const MAXBULLETCOUNT = 5
const ROTATIONDIFFERENCE = 15

var gun_rotation
var active : bool = true
var gun_shot : bool = false
var bullet_count : int = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gun_rotation = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var horizontal_direction = 1 if (Input.get_axis("Left", "Right") != 0) else 0
	var vertical_direction = Input.get_axis("Up", "Down")
	
	if (vertical_direction == -1):
		gun_rotation = 270 + (horizontal_direction * 45)
	if (vertical_direction == 1):
		gun_rotation = 90 - (horizontal_direction * 45)
	if (vertical_direction == 0):
		gun_rotation = 0
		
	gun_shot = Input.is_action_just_pressed("Shoot")
	
	if ((gun_shot ) && active): 
		for i in bullet_count + 1:
			var new_bullet = bullet.instantiate()
			var rotation_coeff = i % 2
			#if (get_parent().transform.x.x > -0.99):
				#new_bullet.rotation = rotation
			#else:
				#new_bullet.rotation = 3
			if (rotation_coeff == 0):
				new_bullet.rotation = global_rotation + deg_to_rad(ROTATIONDIFFERENCE * floor(i / 2))
			else:
				new_bullet.rotation = global_rotation + deg_to_rad(-ROTATIONDIFFERENCE * floor(i / 2))
			
			get_tree().root.add_child(new_bullet)
			new_bullet.global_position = global_position


func _physics_process(delta: float) -> void:
	rotation_degrees = gun_rotation


func _activate_gun(active_state : bool):
	active = active_state
