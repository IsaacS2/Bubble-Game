class_name Player

extends CharacterBody2D

@onready var Sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var Camera: PlayerCamera = $"../Camera2D"

const MAXHEALTH = 3
const SPEED = 6000.0
const JUMP_VELOCITY = -300.0
const MAXACCELERATION = 100
const MAXBUBBLESPEED = 500.0
const MAXHITSTUNTIME = 1
const HITCOLOR = Color.RED 

var health : int = MAXHEALTH
var status : Globals.State = Globals.State.shooting
var hit_stun : bool = false
var hit_stun_time : float = 0


func _process(delta: float) -> void:
	if (hit_stun_time > 0):
		hit_stun_time -= delta
		
		if (hit_stun_time <= 0):
			hit_stun = false
			Sprite.modulate = Color.WHITE


func _physics_process(delta: float) -> void:
	if (status == Globals.State.shooting):
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta

		# Handle jump.
		if Input.is_action_just_pressed("Jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# TODO: For player movement, direction-switching must always be
		# enabled, even when the player's locking their movement for aiming
		var direction := Input.get_axis("Left", "Right")
		if (direction != 0): 
			transform.x.x = direction
		
		if direction:
			velocity.x = direction * SPEED * delta
			
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED * delta)
		move_and_slide()
		
	elif (status == Globals.State.bubbled):
		var direction
		var input_dir = Input.get_axis("Left", "Right") 
		var maxFrameAcceleration = MAXACCELERATION * delta
		
		direction = (transform.x.x * Vector3(input_dir, 0, 0)).normalized()
		
		direction *= MAXBUBBLESPEED
		
		velocity.x = move_toward(velocity.x, direction.x, maxFrameAcceleration)
		velocity.y= -(get_gravity() * delta).y
		
		move_and_slide()


func _hit(damage: int) -> void:
	if (status == Globals.State.shooting && !hit_stun):
		health -= damage
		
		if (health < 1):
			status = Globals.State.bubbled
			Camera._alter_tracking(Globals.Tracking.vertical)
		else:
			hit_stun = true
			hit_stun_time = MAXHITSTUNTIME
			Sprite.modulate = HITCOLOR
			Camera._alter_tracking(Globals.Tracking.horizontal)
			
	elif (status == Globals.State.bubbled):
		if (health < -MAXHEALTH):
			status = Globals.State.dead
		else:
			status = Globals.State.shooting
