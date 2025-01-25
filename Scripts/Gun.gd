extends Node2D

@export var bullet : PackedScene = load("res://Scenes/Bullet.tscn")
var gun_rotation
var gun_shot : bool = false

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
	
	if (gun_shot): 
		var new_bullet = bullet.instantiate()
		
		#if (get_parent().transform.x.x > -0.99):
			#new_bullet.rotation = rotation
		#else:
			#new_bullet.rotation = 3
		new_bullet.rotation = global_rotation
		
		get_tree().root.add_child(new_bullet)
		new_bullet.global_position = global_position
		print(str(rotation))
		print(str(transform.x.x))
		print(str(scale.x))
		print(str(scale.y))
			


func _physics_process(delta: float) -> void:
	rotation_degrees = gun_rotation
