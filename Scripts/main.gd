extends Node2D

@onready var textBox: LineEdit = $CanvasLayer/TextBox

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass


func _on_text_box_editing_toggled(toggled_on: bool) -> void:
	Globals.podeMover = false
	print(Globals.podeMover)

func _on_text_box_text_submitted(new_text: String) -> void:
	Globals.podeMover = true
	_on_text_box_editing_toggled(false)
	print(Globals.podeMover)
