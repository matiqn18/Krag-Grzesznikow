extends Node

@export var allowShooting: bool;
@export var raycast: RayCast3D;
@export var gunshotPlayer: AudioStreamPlayer3D;
@export var fireDelayTimer: Timer;
@export var collisionPoint: Vector3;
@export var animationPlayer: AnimationPlayer;
@export var shotgun: Node3D;
@export var sinner_handler: Node3D;

func _unhandled_input(event: InputEvent) -> void:
    if event is InputEventMouseButton and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and shotgun.is_visible():
        Shoot();
    
func Shoot():
    if fireDelayTimer.is_stopped():
        return;
    
    animationPlayer.play("shoot");
    CheckFireRaycastCollisionAndSpawnDecal();
    gunshotPlayer.play();
    fireDelayTimer.start();
    raycast.target_position = Vector3(0, 0, -1000);
    
func CheckFireRaycastCollisionAndSpawnDecal():
    if raycast.get_collider():
        print("Raycast hit");  
        var pos = sinner_handler.active_sinner.global_position; 
        collisionPoint = raycast.get_collision_point();
        if not sinner_handler.active_sinner.animation_player.animation_finished.is_connected(on_death_animation_finished):
            sinner_handler.active_sinner.animation_player.animation_finished.connect(on_death_animation_finished)
        sinner_handler.active_sinner.animation_player.play("Death")
        sinner_handler.animation_player.stop();
        sinner_handler.active_sinner.global_position = pos;

func on_death_animation_finished(_unused_arg = ""):
        sinner_handler.active_sinner.animation_player.animation_finished.disconnect(on_death_animation_finished)
        var bubba = sinner_handler.active_sinner
        bubba.reparent(get_node("/root/GameScene"), true)
        sinner_handler.active_sinner = null
        shotgun.visible = false;
        GameManager.sinner_killed_next_sinner.emit()
        
