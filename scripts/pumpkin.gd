extends Node2D

@export var flyingPumpkinScene: PackedScene
var score = 0
@onready var timer = $Timer
@onready var scoreLabel = $Score

func spawnPumpkin() -> void:
	var x: int = randi_range(-340, 340)
	var pumpkin = flyingPumpkinScene.instantiate()
	pumpkin.setLaunchAngle(4.9+.4*(x/340))
	pumpkin.scale = Vector2(.4, .4)
	pumpkin.position = Vector2(x, 425)
	add_child(pumpkin)

func _on_timer_timeout() -> void:
	spawnPumpkin()
	timer.wait_time = maxf(timer.wait_time - .01, .1)

func increaseScore() -> void:
	score += 1
	scoreLabel.text = "Score: " + str(score)

func reset() -> void:
	score = 0
	scoreLabel.text = "Score: 0"
	timer.wait_time = 1

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/start.tscn")
