extends StaticBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var colisao: CollisionShape2D = $CollisionIN
@onready var base: Node2D = $sprite_base
@onready var area1: Area2D = $Area1
@onready var area2: Area2D = $Area2

var esqSim: bool
var dirSim: bool

func _ready() -> void:
	base.visible = false
	
	check_initial_neighbors()
	
	await get_tree().create_timer(0.1).timeout
	
	update_visual()


func check_initial_neighbors() -> void:
	var body1 = area1.get_overlapping_bodies()
	var body2 = area2.get_overlapping_bodies()
	#if body1.name == "plataforma_suspensa":
	if body1 != null:
		esqSim = true
		#print(esqSim)
	if body2 != null:
		#if body.name == "plataforma_suspensa":
		dirSim = true

func update_visual():
	if esqSim and dirSim:
		base.visible = true
		colisao.scale.x = 1.5
	elif esqSim and !dirSim:
		anim.play("1")
	elif !esqSim and dirSim:
		anim.play("3")
	else:
		anim.play("2")
		
func _on_area_1_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.name == "plataforma_suspensa":
		esqSim = true
	else:
		esqSim = false
		#print(esqSim)

	update_visual()

func _on_area_2_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.name == "plataforma_suspensa":
		dirSim = true
	else:
		dirSim = false
		#print(dirSim)
	update_visual()
