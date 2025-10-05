extends Camera3D

@export_range(0.001, 0.01, 0.0001) var mouse_sensitivity := 0.01

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			rotation.y -= event.relative.x * mouse_sensitivity
			rotation.x -= event.relative.y * mouse_sensitivity
			rotation.x = clamp(rotation.x, deg_to_rad(-45), deg_to_rad(45))
			rotation.y = clamp(rotation.y, deg_to_rad(-60), deg_to_rad(60))
