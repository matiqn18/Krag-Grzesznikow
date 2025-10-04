extends Node3D

func _ready() -> void:
    pass

func _update() -> void:
    pass

func _play_button_press() -> void:
    get_tree().change_scene_to_file("res://scenes/game_scene.tscn")
