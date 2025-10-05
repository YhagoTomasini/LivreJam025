extends Area2D

var emCima: bool
var posiMouse := Vector2.ZERO
var diferenca : Vector2
@onready var hitboxText : CollisionShape2D = $HitboxTextBox/CollisionShape2D

var semMover: bool
var podeClick: bool


func _ready() -> void:
	semMover = true
	podeClick = false
	

func _on_mouse_entered() -> void:
	emCima = true
	Globals.podeMover = true
	
func _on_mouse_exited() -> void:
	emCima = false
	Globals.podeMover = true
		
	
func _physics_process(delta: float) -> void:
	diferenca = posiMouse - get_global_mouse_position()
	
	if emCima:
		podeClick = true
	
	if podeClick:
		if Input.is_action_pressed("click"):
			if diferenca != Vector2.ZERO:
				global_position -= diferenca
				hitboxText.disabled = true
				Globals.podeMover = false
			
		else:
			hitboxText.disabled = false
			podeClick = false
		
	posiMouse = get_global_mouse_position()
