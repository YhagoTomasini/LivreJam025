extends Node2D

@onready var textBox: LineEdit = $CanvasLayer/TextBox

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass



func _on_text_box_focus_entered() -> void:
	Globals.podeMover = false
	print(Globals.podeMover)

func _on_text_box_focus_exited() -> void:
	Globals.podeMover = true
	print(Globals.podeMover)

func _on_text_box_text_submitted(new_text: String) -> void:
	Globals.podeMover = true
	textBox.release_focus()
	print(Globals.podeMover)
