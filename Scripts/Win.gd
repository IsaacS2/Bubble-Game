class_name Win

extends Area2D

signal restart_entire_game

func _on_body_entered(body: Node2D) -> void:
	if (body is Player):
		emit_signal("restart_entire_game")
