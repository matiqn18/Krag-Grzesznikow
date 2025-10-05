extends Node3D

@export var animation_player: AnimationPlayer
@export var shooter_component: Node3D

var active_sinner: SinnerNode
var available_sinners: Array[Node]
var world_environment: WorldEnvironment
var player_killed: bool
var is_aggressive: bool
var encounter_counter: int

var sinners_left := 4

func _ready() -> void:
    world_environment = get_node("/root/GameScene/WorldEnvironment");
    GameManager.sinner_killed_next_sinner.connect(next_sinner)
    GameManager.drop_the_sinner.connect(drop_the_sinner)
    available_sinners = get_node("AvailableSinners").get_children()
    enter_sinner()

func enter_sinner() -> void:
    if sinners_left > 0:
        sinners_left -= 1
        if sinners_left <= 0 and "Booba" in available_sinners:
            active_sinner = get_node("AvailableSinners").find_child("Booba")
        else:
            active_sinner = choose_a_sinner();
        is_aggressive = active_sinner.name == "Booba" # Bobba is always aggressive because he's the only one with the death animation'
        active_sinner.reparent(get_node("CurrentSinner"))
        active_sinner.position = Vector3(0,0,0)
        active_sinner.rotation = Vector3(0,0,0)
        animation_player.play("sinner_enter")
        animation_player.animation_finished.connect(_on_animation_ended)
        active_sinner.animation_player.play("Walk")
    else:
        player_killed = true

func _on_animation_ended(_unused_arg = ""):
    animation_player.animation_finished.disconnect(_on_animation_ended)
    if is_aggressive:
        shooter_component.shotgun.visible = true
        sinner_became_aggresive()
    else:
        start_dialogic("test_timeline") #TODO <-------- HERE CHANGE TO TIMELINE THAT IS HELD BY THE SINNER

func sinner_became_aggresive() -> void:
    animation_player.play("sinner_attack")
    active_sinner.animation_player.play("Walk")

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
    if animation_player.animation_finished.is_connected(next_sinner):
        animation_player.animation_finished.disconnect(next_sinner)
    if active_sinner:
        active_sinner.queue_free()
    # Update sinner list
    available_sinners = get_node("AvailableSinners").get_children()
    enter_sinner()

func _process(delta: float) -> void:
    if player_killed:
        world_environment.environment.tonemap_exposure -= delta * 1.5;
        
    if world_environment.environment.tonemap_exposure <= 0:
        get_tree().change_scene_to_file("res://scenes/main_menu.tscn");
    
func kill_player():
    player_killed = true;
    print("player killed");
