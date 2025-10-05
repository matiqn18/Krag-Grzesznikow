extends Node3D

@export var animation_player: AnimationPlayer

var active_sinner: SinnerNode
var available_sinners: Array[Node]


func _ready() -> void:
    available_sinners = get_node("AvailableSinners").get_children()
    enter_sinner()

func enter_sinner() -> void:
    active_sinner = choose_a_sinner()
    active_sinner.reparent(get_node("CurrentSinner"))
    animation_player.play("sinner_enter")
    active_sinner.animation_player.play("Walk")

func stop_walking() -> void:
    active_sinner.animation_player.stop(true)

func start_dialogic(timeline: String) -> void:
    Dialogic.start("res://dialogic/timelines/" + timeline + ".dtl")

func choose_a_sinner() -> Node3D:
    return available_sinners.pick_random()
