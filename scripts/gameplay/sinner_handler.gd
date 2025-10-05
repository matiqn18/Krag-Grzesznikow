extends Node3D

@export var animation_player: AnimationPlayer

func _ready() -> void:
	animation_player.play("sinner_enter")

func start_dialogic(timeline: String) -> void:
	Dialogic.start("res://dialogic/timelines/" + timeline + ".dtl")
