extends Control 

@onready var timer_text: Button = $timer_text
var tempo_total: float = 0.0
var zueira_timer : bool = false
var clicks = 0
@onready var zueira_text_timer: Label = $zueira_text_timer

func _process(delta: float) -> void:
	tempo_total += delta
	timer_text.text = format_time(tempo_total)


func format_time(seconds: float) -> String:
	var total_seconds: int = int(seconds)
	var minutes: int = total_seconds / 60
	var secs: int = total_seconds % 60
	return "%02d:%02d" % [minutes, secs]


func _on_timer_text_button_down() -> void:
	clicks += 1
	if clicks > 3:
		zueira_timer = true
		
	if !zueira_timer:
		pass
	else:
		zueira_text_timer.visible = true
		await get_tree().create_timer(1).timeout
		zueira_text_timer.visible = false
		zueira_timer = false
		clicks = 0
