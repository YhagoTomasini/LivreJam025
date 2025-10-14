extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $Sprite2D
@onready var pause : CanvasLayer = $"../pauseMenu"
@onready var coyote_timer: Timer = $coyote_timer
@onready var spawn_inicial: Marker2D = $"../spawn_inicial"
@onready var particulas: CPUParticles2D = $CPUParticles2D

@onready var aud : AudioStreamPlayer = $AudioStreamPlayer
@export var sonsGolem: Array[AudioStream]

var base_scale_x: float

const air_friction := 0.65

var altura_pulo := 135
var pico_em := 0.4

var can_jump := true

var gravidade
var fall_gravidade

func esp_effect(ativar : bool):
	if ativar:
		particulas.emitting = true
		anim.modulate = Color(0.75, 1, 0.75)
	else:
		particulas.emitting = false
		anim.modulate = Color(1, 1, 1)

func _ready() -> void:
	particulas.emitting = false
	
	base_scale_x = anim.scale.x 
	att_animVelo()
	
	Globals.PULO = (altura_pulo * 2) / pico_em
	gravidade = (altura_pulo * 2) / pow(pico_em, 2)
	fall_gravidade = gravidade * 2

func att_animVelo() -> void:
	anim.speed_scale = Globals.VELO/100
	
func _physics_process(delta: float) -> void:	
	if not is_on_floor():
		velocity.x = 0
		
	if Globals.podeMover:
		# Handle jump.
		if Input.is_action_just_pressed("ui_up") and can_jump:
			playAud(1)
			velocity.y = -Globals.PULO
			anim.play("Anim")
		
		
		if is_on_floor() and !can_jump:
			#playAud(2)
			can_jump = true

		elif can_jump and coyote_timer.is_stopped():
			coyote_timer.start()
			
		if velocity.y > 0 or not Input.is_action_pressed("ui_up"):
			velocity.y += fall_gravidade * delta
		else:
			velocity.y += gravidade * delta
			
			
		var direction := Input.get_axis("ui_left", "ui_right")
		if direction < 0 and anim.scale.x == base_scale_x:
			anim.scale.x = -base_scale_x
		if direction > 0:
			anim.scale.x = base_scale_x
			
		if direction:
			velocity.x = lerp(velocity.x, direction * Globals.VELO, air_friction)
		else:
			velocity.x = move_toward(velocity.x, 0, Globals.VELO)
		
		if not is_on_floor():
			anim.play("Anim")
		elif abs(velocity.x) > 10:
			anim.play("Anim")
			if !aud.playing:
				playAud(0)
		else:
			anim.play("Idle")
		
	else:
		velocity.x = 0
		anim.play("Idle")
		aud.stop()
		

	move_and_slide()
	
	for plataforms in get_slide_collision_count():
		var collision_p = get_slide_collision(plataforms)
		if collision_p.get_collider().has_method("colidiu_com_algo"):
			collision_p.get_collider().colidiu_com_algo(collision_p, self)

func playAud(i : int):
	if i >= 0 and i < sonsGolem.size():
		var pitch
		if i == 0:
			pitch = randf_range(0.5, 0.7)
		elif i == 1 or i == 2:
			pitch = randf_range(0.7, 1)
		aud.stream = sonsGolem[i]
		aud.pitch_scale = pitch
		aud.play()

func _on_area_2d_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area.is_in_group("morte"):
		#Globals.reset_game()
		if Globals.current_checkpoint != null:
			global_position = Globals.current_checkpoint.position
		else:
			global_position = spawn_inicial.position


func _on_button_button_down() -> void:
	pause.pausar()


func _on_coyote_timer_timeout() -> void:
	can_jump = false
