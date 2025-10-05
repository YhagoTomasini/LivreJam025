extends Control

@onready var scroll_container: ScrollContainer = $ScrollContainer
@export var text_node: RichTextLabel
@export var vel : float = 1

var cabo : bool

@onready var pause_menu: CanvasLayer = $pauseMenu

func _ready() -> void:
	cabo = false
	
func fim():
	cabo = true
	pause_menu.visible = true
	pause_menu.get_tree().paused = true
	pause_menu.resume_btn.grab_focus()
	print("fim")
	
	
func _process(delta: float) -> void:
	if scroll_container.scroll_vertical <= text_node.size.y+680:
		scroll_container.scroll_vertical += 1 * vel
	elif !cabo:
		fim()
