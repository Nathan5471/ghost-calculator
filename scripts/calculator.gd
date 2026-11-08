extends Node2D

var currentText = ""
@onready var display = $Label

func reverseArray(array: Array[String]) -> Array[String]:
	var newArray: Array[String] = []
	while array.size() > 0:
		var character = array.pop_back()
		newArray.append(character)
	return newArray

func calculate() -> void:
	if (currentText == ""):
		return
	# I based this off of https://upload.wikimedia.org/wikipedia/commons/2/24/Shunting_yard.svg?utm_source=en.wikipedia.org&utm_campaign=imageinfo&utm_content=original
	var output: Array[String] = []
	var operatorStack: Array[String] = []
	var currentNumber: String = ""
	var lastParsedCharacter: String = ""
	var openParentheses: int = 0
	var i: int = 0
	while true:
		if (i == currentText.length()):
			if (openParentheses != 0):
				displayError()
				return
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
			if (currentNumber.contains(".")):
				displayError()
				return
			if (currentNumber == ""):
				currentNumber += "0"
			currentNumber += character
			i += 1
			lastParsedCharacter = character
			continue
		elif (currentNumber != ""):
			output.append(currentNumber)
			currentNumber = ""
		
		if ((character != "(" && lastParsedCharacter == "") && !lastParsedCharacter.is_valid_int() && lastParsedCharacter != "!" && lastParsedCharacter != ")"):
			displayError()
			return
		
		if (character == "+" || character == "-"):
			if (operatorStack.size() == 0):
				operatorStack.append(character)
			elif (operatorStack[-1] == "("):
				operatorStack.append(character)
			elif (operatorStack[-1] == "+" || operatorStack[-1] == "-"):
				output.append(operatorStack.pop_back())
				operatorStack.append(character)
			else:
				if (openParentheses == 0):
					output.append_array(reverseArray(operatorStack))
				else:
					while true:
						if (operatorStack[-1] == "("):
							break
						output.append(operatorStack.pop_back())
			i += 1
			lastParsedCharacter = character
			continue
		elif (character == "x" || character == "/" || character == "%"):
			if (operatorStack.size() == 0 || (operatorStack[-1] == "+" || operatorStack[-1] == "-")):
				operatorStack.append(character)
			elif (operatorStack[-1] == "^"):
				if (openParentheses == 0):
					output.append_array(reverseArray(operatorStack))
				else:
					while true:
						if (operatorStack[-1] == "("):
							break
						output.append(operatorStack.pop_back())
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
		
		if (character == "("):
			operatorStack.append(character)
			openParentheses += 1
			i += 1
			lastParsedCharacter = character
			continue
		elif (character == ")"):
			if (openParentheses == 0):
				displayError()
				return
			openParentheses -= 1
			while true:
				var currentCharacter = operatorStack.pop_back()
				if (currentCharacter == "("):
					break
				output.append(currentCharacter)
			i += 1
			lastParsedCharacter = character
			continue
	
	var evaluationStack: Array[float] = []
	for item in output:
		if (item.is_valid_float()):
			evaluationStack.append(float(item))
			continue
		if (item == "+"):
			var b: float = evaluationStack.pop_back()
			var a: float = evaluationStack.pop_back()
			var result = a + b
			evaluationStack.append(result)
		elif (item == "-"):
			var b: float = evaluationStack.pop_back()
			var a: float = evaluationStack.pop_back()
			var result = a - b
			evaluationStack.append(result)
		elif (item == "x"):
			var b: float = evaluationStack.pop_back()
			var a: float = evaluationStack.pop_back()
			var result = a * b
			evaluationStack.append(result)
		elif (item == "/"):
			var b: float = evaluationStack.pop_back()
			var a: float = evaluationStack.pop_back()
			if (b == 0.0):
				displayError()
				return
			var result = a / b
			evaluationStack.append(result)
		elif (item == "%"):
			var b: float = evaluationStack.pop_back()
			var a: float = evaluationStack.pop_back()
			var result = fmod(a, b)
			evaluationStack.append(result)
		elif (item == "^"):
			var b: float = evaluationStack.pop_back()
			var a: float = evaluationStack.pop_back()
			var result = a ** b
			evaluationStack.append(result)
		elif (item == "!"):
			var a: float = evaluationStack.pop_back()
			if (a < 0 || a > 13 || a != floor(a)):
				displayError()
				return
			var result = 1
			for number in range(1, int(a)+1):
				result *= number
			evaluationStack.append(result)
	if (evaluationStack[0] == floor(evaluationStack[0])):
		currentText = str(int(evaluationStack[0]))
	else:
		currentText = str(evaluationStack[0])
	display.text = currentText

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
