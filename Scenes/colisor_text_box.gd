extends Area2D

var emCima: bool
var posiMouse := Vector2.ZERO
var diferenca : Vector2


func _on_mouse_entered() -> void:
	emCima = true
	
func _on_mouse_exited() -> void:
	emCima = false
	
func _process(delta: float) -> void:
	diferenca = posiMouse - get_global_mouse_position()
	
	if Input.is_action_pressed("click") and emCima and diferenca != Vector2.ZERO:
		global_position -= diferenca
		
	posiMouse = get_global_mouse_position()
