extends Node2D

@onready var textBox: LineEdit = $TextBoxEscrita
@export var golem: CharacterBody2D
@export var canva: CanvasLayer

var emCima: bool
var posiMouse := Vector2.ZERO
var diferenca : Vector2
@onready var hitboxText : CollisionShape2D = $ColisorTextBox/HitboxTextBox/textboxcollision

var semMover: bool
var podeClick: bool
var self_node 
var old_parent


func _ready() -> void:
	self_node = self
	old_parent = self_node.get_parent()
	
	await get_tree().create_timer(0.1).timeout
	old_parent.remove_child(self_node)
	#await get_tree().create_timer(0.1).timeout
	canva.add_child(self_node)
	
	self_node.position = Vector2(120, 120)
	
	semMover = true
	podeClick = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_down"):
		old_parent.remove_child(self_node)
		canva.add_child(self_node)
		self_node.position = Vector2(120, 120)
		print("down")
		
	if emCima and Input.is_action_just_pressed("click"):
		diferenca = get_global_mouse_position() - global_position
		podeClick = true
		
	if podeClick:
		if Input.is_action_pressed("click"):
			canva.remove_child(self_node)
			old_parent.add_child(self_node)
			
			global_position = get_global_mouse_position() - diferenca
			hitboxText.disabled = true
			
		else:
			hitboxText.disabled = false
			podeClick = false

	posiMouse = get_global_mouse_position()
#___________________________________________________________________________________#

func _on_text_box_focus_entered() -> void:
	Globals.podeMover = false
	#print(Globals.podeMover)

func _on_text_box_focus_exited() -> void:
	Globals.podeMover = true
	#print(Globals.podeMover)

func _on_text_box_text_submitted(new_text: String) -> void:
	Globals.podeMover = true
	textBox.release_focus()
	#print(Globals.podeMover)
	
	if new_text.strip_edges() != "":
		Globals.VELO = float(new_text)
		golem.att_animVelo()
		Globals.calculando()
		
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
	
#___________________________________________________________________________________#

func _on_mouse_entered() -> void:
	emCima = true

func _on_mouse_exited() -> void:
	emCima = false
