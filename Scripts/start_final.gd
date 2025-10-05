extends Area2D

@onready var marker_2d: Marker2D = $Marker2D
@onready var borboletinha: Node2D = $Borboletinha
var tempo_de_movimento : float = 5 # Leva 1.5 segundos para chegar
@onready var camera_2d: Camera2D = %Camera2D


func _ready() -> void:
	# Não precisa de _process, o Tween fará o trabalho.
	pass
	
func iniciar_movimento_suave():
	# 1. Cria o objeto Tween
	var tween = create_tween()
	
	# 2. Configura a transição de propriedade:
	# O Tween move a propriedade "position" do nó Borboletinha 
	# para a posição do Marker2D, em um certo tempo.
	tween.tween_property(
		borboletinha, 
		"position", 
		marker_2d.position, 
		tempo_de_movimento
	)
	
	# Opcional: Adiciona suavização (começa rápido, termina lento)
	tween.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	# Opcional: Chama uma função quando o movimento terminar
	tween.tween_callback(funcao_apos_parada)
	


func funcao_apos_parada():
	print("Movimento suave concluído!")
	camera_2d.zoom = Vector2(2.5,2.5)
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://Scenes/creditos.tscn")
	# Coloque aqui a lógica que deve acontecer após o nó parar

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Golem":
		Globals.podeMover = false 
		iniciar_movimento_suave() # Chama a função do Tween
