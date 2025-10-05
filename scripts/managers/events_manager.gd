extends Node3D

@export var anomaly: AnimationPlayer
@export var timer: Timer

var random = RandomNumberGenerator.new()
var anomalies = []
var used_anomalies_queue = []
var max_queue_limit

func _ready() -> void:
	anomalies = Array(anomaly.get_animation_list())
	anomalies.pop_back()
	max_queue_limit = len(anomalies) - 3 if len(anomalies) > 3 else 0

func select_anomaly() -> void:
	random = randi() % len(anomalies)
	while random in used_anomalies_queue:
		random = randi() % len(anomalies)
	print(used_anomalies_queue, ": ", random, " - ", anomalies[random])
	update_queue(random)
	var chosen_anomaly = anomalies[random]
	anomaly.play(chosen_anomaly)
		
func update_queue(index: int) -> void:
	used_anomalies_queue.push_back(index)
		
	if len(used_anomalies_queue) > max_queue_limit:
		used_anomalies_queue.pop_front()
		
func trigger_anomaly_time() -> void:
	select_anomaly()
	random = (randi() % 5) + 12
	timer.wait_time = random
