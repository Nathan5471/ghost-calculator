extends Node2D

var initialSpeed: int = randi_range(550, 750)
var rotationSpeed: float = randf_range(3, 8)
var launchAngle: float
var launchDirectionVector: Vector2 = Vector2.RIGHT
var speed: Vector2

func setLaunchAngle(angle: float):
	launchAngle = angle

func _ready() -> void:
	print("started")
	speed = Vector2.RIGHT.rotated(launchAngle) * initialSpeed

func _process(delta: float) -> void:
	position += speed * delta
	speed += Vector2.DOWN * 300 * delta
	rotation += rotationSpeed * delta

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !(event is InputEventMouseButton && event.pressed && event.button_index == MOUSE_BUTTON_LEFT):
		return
	queue_free()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if (area.get_meta("killPumpkin")):
		queue_free()
