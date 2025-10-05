extends Node2D

var amplitude: float = 10.0
var speed: float = 2.0
var base_y: float

@onready var grupoCheckPoints : Node2D = $"../borboleta_Check_Points"
@export var listaCheckPoints: Array[Vector2] = []
var index_atual: int = 0
var indo : bool
var velo: float = 150.0

var rotacao_velo := 5.0

func _ready() -> void:
	await get_tree().process_frame
	
	base_y = position.y
	rotation = deg_to_rad(33)
	
	for child in grupoCheckPoints.get_children():
		listaCheckPoints.append(child.global_position)
	
	if listaCheckPoints.size() > 0:
		position = listaCheckPoints[0]
	
func _process(delta: float) -> void:	
	if indo and listaCheckPoints.size() > 0:
		update_check_point(delta)
	
func update_check_point(delta : float):
	if index_atual >= listaCheckPoints.size():
		indo = false
		return
	
	var destino = listaCheckPoints[index_atual]
	var direcao = (destino - position).normalized()
	var distancia = position.distance_to(destino)
	
	position += direcao * velo * delta
	
	var angulo_destino = direcao.angle()
	rotation = lerp_angle(rotation, angulo_destino, rotacao_velo * delta)
	
	if distancia < 10.0:
		position = destino
		indo = false  # Para o movimento
		print("Parou no ponto ", index_atual)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Golem" and !indo:
		if index_atual < listaCheckPoints.size() - 1:
			index_atual += 1
			indo = true
			print("Indo para ponto ", index_atual)
		else:
			pass
