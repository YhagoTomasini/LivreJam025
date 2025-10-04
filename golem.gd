extends CharacterBody2D

func _ready() -> void:
	Globals.VELO = 300
	Globals.PULO = -500
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = Globals.PULO

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * Globals.VELO
	else:
		velocity.x = move_toward(velocity.x, 0, Globals.VELO)

	move_and_slide()
