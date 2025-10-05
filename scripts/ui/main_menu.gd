extends Node3D

const GAME_SCENE_PATH := "res://scenes/game_scene.tscn"

@export var master_volume_slider: VSlider

func _ready() -> void:
    master_volume_slider.value = AudioServer.get_bus_volume_linear(0)
    Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_play_button_pressed() -> void:
    Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
    get_tree().change_scene_to_file(GAME_SCENE_PATH)

func _on_exit_button_pressed() -> void:
    get_tree().quit()

func _on_master_volume_value_changed(value: float) -> void:
    AudioServer.set_bus_volume_linear(0, value)
