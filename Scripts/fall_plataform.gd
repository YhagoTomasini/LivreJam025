extends AnimatableBody2D



@onready var anim: AnimationPlayer = $anim
@onready var respawn_timer: Timer = $respawn_timer
@onready var posicao_do_spawn := global_position
@onready var sprite: Sprite2D = $sprite
@onready var sprites: Node2D = $Sprites

@export var reset_timer := 3.0

var velocity = Vector2.ZERO
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_trigger = false
var tempo_para_cair : float = 1
var  INICIAL_tempo_para_cair : float = 0

func _ready() -> void:
	set_physics_process(false)
	INICIAL_tempo_para_cair = tempo_para_cair



func _process(delta: float) -> void:
	if Globals.VELO > Globals.Velo_base:
		tempo_para_cair = tempo_para_cair / Globals.Velo_escala
	else:
		tempo_para_cair = INICIAL_tempo_para_cair

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	position += (velocity*5) * delta

func colidiu_com_algo(collision: KinematicCollision2D, collider: CharacterBody2D):

	if !is_trigger:

		is_trigger = true

#anim.play("shake")

		velocity = Vector2.ZERO

		await get_tree().create_timer(tempo_para_cair).timeout

		caiu()





func _on_anim_animation_finished(anim_name: StringName) -> void:

	set_physics_process(true)

	respawn_timer.start(reset_timer)





func _on_respawn_timer_timeout() -> void:

	set_physics_process(false)

	global_position = posicao_do_spawn

	if is_trigger:

		var spawn_tween = create_tween().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_IN_OUT)

		spawn_tween.tween_property($Sprites,"scale", Vector2(1,1), 0.2).from(Vector2(0,0))

		is_trigger = false



func caiu():

	set_physics_process(true)

	respawn_timer.start(reset_timer)
