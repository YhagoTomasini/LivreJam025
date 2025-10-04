extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $Sprite2D

var base_scale_x: float

func _ready() -> void:
	base_scale_x = anim.scale.x 
	att_animVelo()

func att_animVelo() -> void:
	anim.speed_scale = Globals.VELO/100
	
func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if Globals.podeMover:
		#print(Globals.podeMover)

		# Handle jump.
		if Input.is_action_just_pressed("ui_up") and is_on_floor():
			velocity.y = Globals.PULO

		var direction := Input.get_axis("ui_left", "ui_right")
		if direction < 0 and anim.scale.x == base_scale_x:
			anim.scale.x = -base_scale_x
		if direction > 0:
			anim.scale.x = base_scale_x
			
		if direction:
			velocity.x = direction * Globals.VELO
			anim.play("Anim")
		else:
			velocity.x = move_toward(velocity.x, 0, Globals.VELO)
			anim.play("Idle")
	
		
	else:
		velocity.x = 0
		anim.play("Idle")
		
	

	move_and_slide()
	
	for plataforms in get_slide_collision_count():
		var collision_p = get_slide_collision(plataforms)
		if collision_p.get_collider().has_method("colidiu_com_algo"):
			collision_p.get_collider().colidiu_com_algo(collision_p, self)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "tiro_totem":
		Globals.reset_game()
		
