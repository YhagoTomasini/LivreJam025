extends CanvasLayer

@onready var resume_btn: Button = $VBoxContainer/resume_btn
@export var volume : CanvasLayer

var parado : bool

func _ready() -> void:
	visible = false
	parado = false
	
func despausa():
	get_tree().paused = false
	visible = false

func pausar():
	if !parado:
		visible = true
		get_tree().paused = true
		grabFocus()
		
func _unhandled_input(event: InputEvent) -> void:
	if !parado:
		if event.is_action_pressed("ui_pause"):
			pausar()

func _on_resume_btn_pressed() -> void:
	despausa()

func _on_bm_btn_pressed() -> void:
	Globals.VELO = 300
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/menu_start.tscn")

func _on_reiniciar_pressed() -> void:
	Globals.VELO = 300
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func _on_audio_pressed() -> void:
	visible = false
	volume.visible = true
	
func grabFocus():
	await get_tree().create_timer(0.1).timeout
	resume_btn.grab_focus()
