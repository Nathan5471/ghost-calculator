extends Node2D

var currentText = ""
@onready var display = $Label

func calculate() -> void:
	if (currentText == ""):
		return
	# I based this off of https://upload.wikimedia.org/wikipedia/commons/2/24/Shunting_yard.svg?utm_source=en.wikipedia.org&utm_campaign=imageinfo&utm_content=original
	var output: Array[String] = []
	var operatorStack: Array[String] = []
	var currentNumber: String = ""
	var i = 0
	while true:
		if (i == currentText.length()):
			if (currentNumber != ""):
				output.append(currentNumber)
			break
		var character = currentText[i]
		if (character.is_valid_int()):
			currentNumber += character
			i += 1
			continue
		elif (character == "."):
			if (currentNumber == "" || currentNumber.contains(".")):
				displayError()
				return
			currentNumber += character
			i += 1
			continue
		elif (currentNumber != ""):
			output.append(currentNumber)
			currentNumber = ""
			i += 1
			continue
		i += 1
	for number in output:
		print(number)
	

func displayError() -> void:
	pass

func handleButtonPress(buttonValue: String) -> void:
	if (buttonValue == "="):
		print("Caclulating")
		calculate()
	elif (buttonValue == "<-"):
		currentText = currentText.left(-1)
	elif (buttonValue == "C"):
		currentText = ""
	else:
		currentText += buttonValue
	updateDisplay()

func updateDisplay() -> void:
	display.text = currentText
