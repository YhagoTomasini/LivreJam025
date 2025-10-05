extends CanvasLayer

@onready var resume_btn: Button = $VBoxContainer/resume_btn


func _ready() -> void:
	visible = false
	
func pausa():
	get_tree().paused = false
	visible = false
		
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_pause"):
		visible = true
		get_tree().paused = true
		resume_btn.grab_focus()

func _on_resume_btn_pressed() -> void:
	pausa()

func _on_bm_btn_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/menu_start.tscn")


func _on_reiniciar_button_down() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
