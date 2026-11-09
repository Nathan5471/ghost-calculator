extends Node2D

var initialSpeed: int = randi_range(550, 750)
var rotationSpeed: float = randf_range(3, 8)
var launchAngle: float = randf_range(1, 3)
var launchDirectionVector: Vector2 = Vector2.RIGHT
var speed: Vector2

func setLaunchAngle(angle: float):
	launchAngle = angle

func _ready() -> void:
	speed = Vector2.RIGHT.rotated(5) * initialSpeed

func _process(delta: float) -> void:
	position += speed * delta
	speed += Vector2.DOWN * 300 * delta
	rotation += rotationSpeed * delta
