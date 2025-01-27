class_name Enemy

extends Area2D
@onready var Sprite: AnimatedSprite2D = $AnimatedSprite2D
@export var bullet : PackedScene = load("res://Scenes/EnemyBullet.tscn")

const MAXHEALTH = 10
const MAXDAMAGECOLORTIME = 0.25
const SHOOTTIME = 1
const SHOOTHORIZONTALDIFF = -6

var damageTime = 0
var health : int = MAXHEALTH
var shootTime = SHOOTTIME

func _ready() -> void:
	pass
	#transform.x.x = scale.x

func _process(delta: float) -> void:
	if (damageTime > 0):
		damageTime -= delta
		
		if (damageTime <= 0):
			Sprite.modulate = Color.WHITE
	
	if (shootTime > 0):
		shootTime -= delta
		
		if (shootTime <= 0):
			shootTime = SHOOTTIME
			var new_bubble = bullet.instantiate()
			get_tree().root.get_child(-1).get_child(-1).add_child(new_bubble)
			new_bubble.rotation = global_rotation
			new_bubble.global_position = global_position + Vector2(0, SHOOTHORIZONTALDIFF)
	

func _on_hit(damage : int):
	health -= damage
	
	if (health < 1):
		queue_free()
	else:
		Sprite.modulate = Color.RED
		damageTime = MAXDAMAGECOLORTIME


func _on_body_entered(body: Node2D) -> void:
	if (body is PlayerBullet):
		_on_hit(body.damage)
		body.queue_free()
