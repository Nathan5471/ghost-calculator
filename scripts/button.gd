@tool

extends Node2D

@export var buttonValue: String
@onready var label = $Label

func _ready() -> void:
	label.text = buttonValue


func _on_button_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !(event is InputEventMouseButton && event.pressed && event.button_index == MOUSE_BUTTON_LEFT):
		return
	var calculator = get_parent().get_parent().get_parent().get_parent()
	calculator.handleButtonPress(buttonValue)
