extends Node2D

@export var flyingPumpkinScene: PackedScene

func spawnPumpkin() -> void:
	var x: int = randi_range(-340, 340)
	var pumpkin = flyingPumpkinScene.instantiate()
	pumpkin.setLaunchAngle(4.9+.4*(x/340))
	pumpkin.scale = Vector2(.4, .4)
	pumpkin.position = Vector2(x, 425)
	add_child(pumpkin)

func _on_timer_timeout() -> void:
	spawnPumpkin()
