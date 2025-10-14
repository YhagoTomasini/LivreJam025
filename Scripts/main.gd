extends Node2D

@onready var textBox: LineEdit = $TextBoxEscrita
@export var golem: CharacterBody2D
@export var canva: CanvasLayer

var emCima: bool
var posiMouse := Vector2.ZERO
var diferenca : Vector2
@onready var tex : TextureRect = $ColisorTextBox/TextureRect
@onready var hitboxText : CollisionPolygon2D = $ColisorTextBox/HitboxTextBox/polygonsahpe2
@onready var particulas : CPUParticles2D = $CPUParticles2D
@onready var timerSegs : Timer = $Timer

var semMover: bool
var podeClick: bool
var self_node 
var old_parent


func _ready() -> void:
	self_node = self
	old_parent = self_node.get_parent()
	
	particulas.emitting = false
	tex.modulate = Color(1, 1, 1)
	particulas.modulate = Color(1, 1, 1)
	
	await get_tree().create_timer(0.1).timeout
	voltar_HUD()
	
	semMover = true
	podeClick = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_down"):
		voltar_HUD()
		
	if emCima and Input.is_action_just_pressed("click"):
		diferenca = get_global_mouse_position() - global_position
		podeClick = true
	
	if podeClick:
		if Input.is_action_pressed("click"):
			if self_node.get_parent() == canva:
				canva.remove_child(self_node)
				old_parent.add_child(self_node)
			
			global_position = get_global_mouse_position() - diferenca
			
			particulas.emitting = true
			tex.modulate = Color(1, 0.75, 0.75)
			particulas.modulate = Color(1, 0.75, 0.75)
			
			hitboxText.disabled = true
			
		else:
			hitboxText.disabled = false
			podeClick = false
			
			particulas.emitting = false
			tex.modulate = Color(1, 1, 1)
			particulas.modulate = Color(1, 1, 1)

		posiMouse = get_global_mouse_position()
		
		
func voltar_HUD():
	old_parent.remove_child(self_node)
	canva.add_child(self_node)
	self_node.position = Vector2(120, 120)
	print("down")
	
#___________________________________________________________________________________#

func _on_text_box_focus_entered() -> void:
	Globals.podeMover = false
	particulas.emitting = true
	tex.modulate = Color(0.75, 1, 0.75)
	particulas.modulate = Color(0.75, 1, 0.75)
	
	golem.esp_effect(true)
	#print(Globals.podeMover)

func _on_text_box_focus_exited() -> void:
	Globals.podeMover = true
	particulas.emitting = false
	tex.modulate = Color(1, 1, 1)
	particulas.modulate = Color(1, 1, 1)
	
	golem.esp_effect(false)
	#print(Globals.podeMover)

func _on_text_box_text_submitted(new_text: String) -> void:
	Globals.podeMover = true
	particulas.emitting = false
	tex.modulate = Color(1, 1, 1)
	particulas.modulate = Color(1, 1, 1)
	textBox.release_focus()
	
	golem.esp_effect(false)
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
	
	tex.modulate = Color(01, 01, 01)
	particulas.modulate = Color(01, 01, 01)
	await get_tree().create_timer(0.1).timeout
	particulas.emitting = true
	tex.modulate = Color(0.75, 1, 0.75)
	particulas.modulate = Color(0.75, 1, 0.75)
	
#___________________________________________________________________________________#

func _on_mouse_entered() -> void:
	emCima = true

func _on_mouse_exited() -> void:
	emCima = false

#___________________________________________________________________________________#

func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	print("Saiu da tela, iniciando contagem para voltar HUD")
	timerSegs.start()

func _on_visible_on_screen_enabler_2d_screen_entered() -> void:
	timerSegs.stop()
	print("Caixa voltou a aparecer, cancelando retorno")

func _on_timer_timeout() -> void:
	voltar_HUD()
