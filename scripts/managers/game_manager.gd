extends Node3D

signal drop_the_sinner

func _ready() -> void:
    Dialogic.signal_event.connect(_handle_dialogic_signals)

func _update() -> void:
    pass

func _handle_dialogic_signals(arg) -> void:
    if arg == "DropTheSinner":
        drop_the_sinner.emit()
