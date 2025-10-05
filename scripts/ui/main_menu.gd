extends Node3D

const GAME_SCENE_PATH := "res://scenes/game_scene.tscn"

func _on_play_button_pressed() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().change_scene_to_file(GAME_SCENE_PATH)

func _on_exit_button_pressed() -> void:
	get_tree().quit()

func _on_master_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(0, value)
