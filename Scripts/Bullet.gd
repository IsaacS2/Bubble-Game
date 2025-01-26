class_name Bullet

extends RigidBody2D

var timeLeft
@export var time : float = 1.5
@export var speed : float = 1

var thrust = Vector2(0, -250)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timeLeft = time
	pass
	#add_constant_central_force(force: Vector2)


func _process(delta: float) -> void:
	timeLeft -= delta
	if (timeLeft <= 0):
		queue_free()
		pass


func _physics_process(delta: float) -> void:
	apply_central_impulse(thrust.rotated(rotation + deg_to_rad(90)) * speed * delta)
