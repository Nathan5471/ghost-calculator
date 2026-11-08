@tool

extends Node2D

@export var buttonValue: String
@onready var label = $Label

func _ready() -> void:
	label.text = buttonValue


func _on_button_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	var calculator = get_parent().get_parent().get_parent().get_parent()
	calculator.handleButtonPress(buttonValue)
