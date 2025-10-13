extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $Sprite2D
@onready var pause : CanvasLayer = $"../pauseMenu"
@onready var coyote_timer: Timer = $coyote_timer

var base_scale_x: float

const air_friction := 0.5

var altura_pulo := 170
var pico_em := 0.5

var can_jump := true

var gravidade
var fall_gravidade


func _ready() -> void:
	base_scale_x = anim.scale.x 
	att_animVelo()
	
	Globals.PULO = (altura_pulo * 2) / pico_em
	gravidade = (altura_pulo * 2) / pow(pico_em, 2)
	fall_gravidade = gravidade * 2

func att_animVelo() -> void:
	anim.speed_scale = Globals.VELO/100
	
func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		#velocity += get_gravity() * delta
		velocity.x = 0
		
	if Globals.podeMover:
		# Handle jump.
		if Input.is_action_just_pressed("ui_up") and can_jump:
			velocity.y = -Globals.PULO
			anim.play("Anim")
		if is_on_floor() and !can_jump:
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
		else:
			anim.play("Idle")
		
	else:
		velocity.x = 0
		anim.play("Idle")
		

	move_and_slide()
	
	for plataforms in get_slide_collision_count():
		var collision_p = get_slide_collision(plataforms)
		if collision_p.get_collider().has_method("colidiu_com_algo"):
			collision_p.get_collider().colidiu_com_algo(collision_p, self)


func _on_area_2d_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area.is_in_group("morte"):
		Globals.reset_game()


func _on_button_button_down() -> void:
	pause.pausar()


func _on_coyote_timer_timeout() -> void:
	can_jump = false
