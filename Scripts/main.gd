extends Node2D

@onready var textBox: LineEdit = $CanvasLayer/TextBox

func _ready() -> void:
	pass

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
	
	if new_text.strip_edges() != "":
		Globals.VELO = float(new_text)


func _on_text_box_text_changed(new_text: String) -> void:
	var old_caret_column: int = textBox.caret_column
	
	var digitos: String = ""
	var soNum = RegEx.new()
	soNum.compile("[0-9]")
	
	var diff: int = soNum.search_all(new_text).size() - new_text.length()
	
	for c_valido in soNum.search_all(new_text):
		digitos += c_valido.get_string()
	
	textBox.set_text(digitos.to_upper())
	textBox.caret_column = old_caret_column + diff
