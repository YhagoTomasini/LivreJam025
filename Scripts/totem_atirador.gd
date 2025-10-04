extends StaticBody2D

const TIRO_TOTEM = preload("res://Prefabs/tiro_totem.tscn")

@onready var spawn_do_tiro: Marker2D = $spawn_do_tiro
@onready var sprite: Sprite2D = $sprite
@onready var cd_tiro: Timer = $cd_tiro
@export var para_direita : bool = true

func _ready() -> void:
	if para_direita:
		sprite.flip_h = false
	else:
		sprite.flip_h = true


func spawn_tiro():
	var novo_tiro = TIRO_TOTEM.instantiate()
	if  para_direita:
		novo_tiro.qual_direcao(1)
	else:
		novo_tiro.qual_direcao(-1)
	add_sibling(novo_tiro)
	novo_tiro.global_position = spawn_do_tiro.global_position


func _on_visible_on_screen_enabler_2d_screen_entered() -> void:
	cd_tiro.start()

func _on_cd_tiro_timeout() -> void:
	spawn_tiro()

func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	cd_tiro.paused
