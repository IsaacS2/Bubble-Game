extends Node2D

var gun_rotation

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gun_rotation = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var horizontal_direction := Input.get_axis("Left", "Right")
	var vertical_direction := Input.get_axis("Down", "Up")
	
	if (vertical_direction == -1):
		gun_rotation = 270 + (horizontal_direction * 45)
	if (vertical_direction == 1):
		gun_rotation = 90 - (horizontal_direction * 45)
	if (vertical_direction == 0):
		gun_rotation = ((horizontal_direction - 1) / 2) * -180
		
	rotation_degrees = gun_rotation
