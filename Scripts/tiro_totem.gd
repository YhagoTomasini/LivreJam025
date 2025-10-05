extends CharacterBody2D



var velocidade_do_tiro := 360
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


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("chaos") or body.is_in_group("caixa"):
		queue_free()
