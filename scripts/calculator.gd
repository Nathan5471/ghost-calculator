extends Node2D

var currentText = ""
@onready var display = $Label

func reverseArray(array: Array[String]):
	var newArray: Array[String] = []
	while array.size() > 0:
		newArray.append(array.pop_back())
	return newArray

func calculate() -> void:
	if (currentText == ""):
		return
	# I based this off of https://upload.wikimedia.org/wikipedia/commons/2/24/Shunting_yard.svg?utm_source=en.wikipedia.org&utm_campaign=imageinfo&utm_content=original
	var output: Array[String] = []
	var operatorStack: Array[String] = []
	var currentNumber: String = ""
	var lastParsedCharacter = ""
	var i = 0
	while true:
		if (i == currentText.length()):
			if (currentNumber != ""):
				output.append(currentNumber)
			if (operatorStack.size() > 0):
				output.append_array(reverseArray(operatorStack))
			break
		var character = currentText[i]
		if (character.is_valid_int()):
			currentNumber += character
			i += 1
			lastParsedCharacter = character
			continue
		elif (character == "."):
			if (currentNumber == "" || currentNumber.contains(".")):
				displayError()
				return
			currentNumber += character
			i += 1
			lastParsedCharacter = character
			continue
		elif (currentNumber != ""):
			output.append(currentNumber)
			currentNumber = ""
		if (!lastParsedCharacter.is_valid_int() && lastParsedCharacter != "!"):
			displayError()
			return
		if (character == "+" || character == "-"):
			if (operatorStack.size() == 0):
				operatorStack.append(character)
			elif (operatorStack[-1] == "+" || operatorStack[-1] == "-"):
				output.append(operatorStack.pop_back())
				operatorStack.append(character)
			else:
				output.append_array(reverseArray(operatorStack))
				operatorStack = []
				continue
			i += 1
			lastParsedCharacter = character
			continue
		elif (character == "x" || character == "/" || character == "%"):
			if (operatorStack.size() == 0 || (operatorStack[-1] == "+" || operatorStack[-1] == "-")):
				operatorStack.append(character)
			elif (operatorStack[-1] == "^"):
				output.append_array(reverseArray(operatorStack))
				operatorStack = []
				continue
			else:
				output.append(operatorStack.pop_back())
				operatorStack.append(character)
			i += 1
			lastParsedCharacter = character
			continue
		elif (character == "^"):
			operatorStack.append(character)
			i += 1
			lastParsedCharacter = character
			continue
		elif (character == "!"):
			output.append(character)
			i += 1
			lastParsedCharacter = character
			continue
	for number in output:
		print(number)
	

func displayError() -> void:
	print("ERROR")

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
