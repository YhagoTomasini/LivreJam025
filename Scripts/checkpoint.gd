extends Area2D


var is_active = false
@onready var anim: AnimatedSprite2D = $anim


func _on_body_entered(body: Node2D) -> void:
	if body.name != "Golem" or is_active:
		return
	actived_checkpoint()
	
func actived_checkpoint():
	#anim.play("rising")
	print("pegou2")
	Globals.current_checkpoint = self
	is_active = true 
	
