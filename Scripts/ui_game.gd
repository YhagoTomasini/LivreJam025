extends Control 

@onready var timer_text: Label = $timer_text
var tempo_total: float = 0.0


func _process(delta: float) -> void:
	tempo_total += delta
	timer_text.text = format_time(tempo_total)


func format_time(seconds: float) -> String:
	var total_seconds: int = int(seconds)
	var minutes: int = total_seconds / 60
	var secs: int = total_seconds % 60
	return "%02d:%02d" % [minutes, secs]
