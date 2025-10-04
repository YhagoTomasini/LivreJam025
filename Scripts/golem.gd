extends CharacterBody2D

func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if Globals.podeMover:
		#print(Globals.podeMover)
		
		# Handle jump.
		if Input.is_action_just_pressed("ui_up") and is_on_floor():
			velocity.y = Globals.PULO

		var direction := Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * Globals.VELO
		else:
			velocity.x = move_toward(velocity.x, 0, Globals.VELO)
	
	else:
		velocity.x = 0

	move_and_slide()
	
	for plataforms in get_slide_collision_count():
		var collision_p = get_slide_collision(plataforms)
		if collision_p.get_collider().has_method("colidiu_com_algo"):
			collision_p.get_collider().colidiu_com_algo(collision_p, self)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "tiro_totem":
		get_tree().reload_current_scene()
