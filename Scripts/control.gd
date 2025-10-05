extends LineEdit


@onready var meuColisor: Area2D = $"../ColisorTextBox"

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	position = meuColisor.position - Vector2(46, 16)
