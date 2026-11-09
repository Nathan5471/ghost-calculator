extends Node2D

func _on_play_button_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if !(event is InputEventMouseButton && event.pressed && event.button_index == MOUSE_BUTTON_LEFT):
		return
	get_tree().change_scene_to_file("res://main.tscn")

func _on_secret_pumkpkin_button_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !(event is InputEventMouseButton && event.pressed && event.button_index == MOUSE_BUTTON_LEFT):
		return
	get_tree().change_scene_to_file("res://scenes/pumpkin.tscn")
