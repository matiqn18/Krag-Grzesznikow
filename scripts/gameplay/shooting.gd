extends Node

@export var allowShooting: bool;
@export var raycast: RayCast3D;
@export var gunshotPlayer: AudioStreamPlayer3D;
@export var fireDelayTimer: Timer;
@export var collisionPoint: Vector3;
@export var animationPlayer: AnimationPlayer;
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
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
		collisionPoint = raycast.get_collision_point();
