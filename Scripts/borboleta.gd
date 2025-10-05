extends AnimatedSprite2D

var amplitude: float = 10.0
var speed: float = 2.0
var base_y: float

@onready var grupoCheckPoints : Node2D = $"../borboleta_Check_Points"
var listaCheckPoints: Array[Vector2] = []
var index_atual: int = 0
var indo : bool
var velo: float = 150.0

func _ready() -> void:
	base_y = position.y
	
	for child in grupoCheckPoints.get_children():
		listaCheckPoints.append(child.global_position)
	
	if listaCheckPoints.size() > 0:
		position = listaCheckPoints[0]
	
func _process(delta: float) -> void:
	#var offset = sin(Time.get_ticks_msec() / 1000.0 * speed) * amplitude
	#position.y = base_y + offset
	
	if indo and listaCheckPoints.size() > 0:
		update_check_point(delta)
	
func update_check_point(delta : float):
	var destino = listaCheckPoints[index_atual]
	var direcao = (destino - position).normalized()
	var distancia = position.distance_to(destino)
	
	await get_tree().create_timer(0.1).timeout
	
	position += direcao * velo * delta
	
	await get_tree().create_timer(0.1).timeout
	
	if index_atual >= listaCheckPoints.size():
		index_atual += 1
		
	else:
		pass
		

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "golem":
		indo = true
		print(indo)
