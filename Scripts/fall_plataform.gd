extends AnimatableBody2D

@onready var anim: AnimationPlayer = $anim
@onready var respawn_timer: Timer = $respawn_timer
@onready var posicao_do_spawn := global_position
@onready var sprite: Sprite2D = $sprite

@export var reset_timer := 3.0
var velocity = Vector2.ZERO
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var is_trigger = false


func _ready() -> void:
	set_physics_process(false)


func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	position += velocity * delta


func colidiu_com_algo(collision: KinematicCollision2D, collider: CharacterBody2D):
	if !is_trigger:
		is_trigger = true
		anim.play("shake")
		velocity = Vector2.ZERO


func _on_anim_animation_finished(anim_name: StringName) -> void:
	set_physics_process(true)
	respawn_timer.start(reset_timer)


func _on_respawn_timer_timeout() -> void:
	set_physics_process(false)
	global_position = posicao_do_spawn
	if is_trigger:
		var spawn_tween = create_tween().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_IN_OUT)
		spawn_tween.tween_property($sprite,"scale", Vector2(1,1), 0.2).from(Vector2(0,0))
	is_trigger = false
