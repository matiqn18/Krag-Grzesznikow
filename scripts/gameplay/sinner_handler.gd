extends Node3D

@export var animation_player: AnimationPlayer

var active_sinner: SinnerNode
var available_sinners: Array[Node]

var sinners_left := 4

func _ready() -> void:
    GameManager.drop_the_sinner.connect(drop_the_sinner)
    available_sinners = get_node("AvailableSinners").get_children()
    enter_sinner()

func enter_sinner() -> void:
    if sinners_left > 0:
        sinners_left -= 1
        active_sinner = choose_a_sinner()
        active_sinner.reparent(get_node("CurrentSinner"))
        active_sinner.position = Vector3(0,0,0)
        active_sinner.rotation = Vector3(0,0,0)
        animation_player.play("sinner_enter")
        active_sinner.animation_player.play("Walk")
    else:
        #Game over
        pass

func stop_walking() -> void:
    active_sinner.animation_player.stop(true)

func start_dialogic(timeline: String) -> void:
    Dialogic.start("res://dialogic/timelines/" + timeline + ".dtl")

func choose_a_sinner() -> Node3D:
    return available_sinners.pick_random()

func drop_the_sinner() -> void:
    animation_player.play("sinner_exit")
    animation_player.animation_finished.connect(next_sinner)

#HACK: Unused arg is a hack for the AnimationPlayer.animation_finished calling signals with the argument
func next_sinner(_unused_arg = "") -> void:
    animation_player.animation_finished.disconnect(next_sinner)
    active_sinner.queue_free()
    # Update sinner list
    available_sinners = get_node("AvailableSinners").get_children()
    enter_sinner()

