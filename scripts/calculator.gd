extends Node2D

var currentText = ""
@onready var display = $Label

func calculate() -> void:
	pass

func displayError() -> void:
	pass

func handleButtonPress(buttonValue: String) -> void:
	if (buttonValue == "="):
		pass
	elif (buttonValue == "<-"):
		currentText = currentText.left(-1)
	elif (buttonValue == "C"):
		currentText = ""
	else:
		currentText += buttonValue
	updateDisplay()

func updateDisplay() -> void:
	display.text = currentText
