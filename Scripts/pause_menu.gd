extends CanvasLayer

@onready var resume_btn: Button = $VBoxContainer/resume_btn

var parado : bool

func _ready() -> void:
	visible = false
	parado = false
	
func pausa():
	get_tree().paused = false
	visible = false

func pausar():
	if !parado:
		visible = true
		get_tree().paused = true
		resume_btn.grab_focus()
func _unhandled_input(event: InputEvent) -> void:
	if !parado:
		if event.is_action_pressed("ui_pause"):
			visible = true
			get_tree().paused = true
			resume_btn.grab_focus()

func _on_resume_btn_pressed() -> void:
	pausa()

func _on_bm_btn_pressed() -> void:
	Globals.VELO = 300
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/menu_start.tscn")


func _on_reiniciar_button_down() -> void:
	Globals.VELO = 300
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
