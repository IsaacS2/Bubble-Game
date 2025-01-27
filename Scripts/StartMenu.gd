extends Node2D


signal level_start

func _on_button_pressed() -> void:
	emit_signal("level_start")
