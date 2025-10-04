extends CharacterBody2D



var velocidade_do_tiro := 70
var direcao := 1 
@onready var anim: AnimatedSprite2D = $anim

func _process(delta: float) -> void:
	position.x += velocidade_do_tiro * direcao * delta
	

func qual_direcao(dir):
	direcao = dir
	if dir < 0:
		$anim.flip_h = true
	else:
		$anim.flip_h = false
		
		
		
#if body.is_in_group("tiro_totem):
#	body.queue_free()


func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()
