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
    if event is InputEventMouseButton and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
        Shoot();
    
func _physics_process(delta: float) -> void:
    if sinner_handler.is_aggressive:
        shotgun.visible = true
    else:
        shotgun.visible = false;
        
    
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
        sinner_handler.active_sinner.animation_player.play("Death")
        sinner_handler.animation_player.stop();
        sinner_handler.active_sinner.global_position = pos;
        
