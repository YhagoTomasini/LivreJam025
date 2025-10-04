extends CharacterBody2D

func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if Globals.podeMover:
		print(Globals.podeMover)
		# Handle jump.
		if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_up") and is_on_floor():
			velocity.y = Globals.PULO

		var direction := Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * Globals.VELO
		else:
			velocity.x = move_toward(velocity.x, 0, Globals.VELO)
	
	else:
		velocity.x = 0

	move_and_slide()
