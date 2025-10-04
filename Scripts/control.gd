extends LineEdit


@onready var meuColisor: Area2D = $"../ColisorTextBox"

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	global_position = meuColisor.position - Vector2(60, 30)
