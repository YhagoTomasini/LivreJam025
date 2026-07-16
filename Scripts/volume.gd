extends CanvasLayer

@export var pause : CanvasLayer
@export var voltarB : Button

func _ready() -> void:
	visible = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		voltarPause()
		
func voltarPause():
	pause.visible = true
	visible = false
	pause.grabFocus()
	
func grabFocus():
	await get_tree().create_timer(0.1).timeout
	voltarB.grab_focus()


func _on_button_pressed() -> void:
	voltarPause()
