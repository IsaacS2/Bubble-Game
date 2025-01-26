class_name Enemy

extends Area2D
@onready var Sprite: AnimatedSprite2D = $AnimatedSprite2D


const MAXHEALTH = 10
const MAXDAMAGECOLORTIME = 0.25

var damageTime = 0
var health : int = MAXHEALTH

func _process(delta: float) -> void:
	if (damageTime > 0):
		damageTime -= delta
		
		if (damageTime <= 0):
			Sprite.modulate = Color.RED
	

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
