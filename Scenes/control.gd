extends Control


@onready var meuColisor: Area2D = $"../../ColisorTextBox"

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	global_position = meuColisor.position
