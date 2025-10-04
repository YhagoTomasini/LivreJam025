extends Node2D

const TEMPO_DE_ESPERA := 1.0

@onready var plataform: AnimatableBody2D = $plataform

# Velocidade base para cálculos
const MOV_VELOCIDADE_BASE := 3.0 

# Variável usada no cálculo de duração
@export var mov_velocidade := MOV_VELOCIDADE_BASE 
@export var distancia := 192.0 # Usar float é mais seguro
@export var mov_horizontal := true

# O tween animará a 'position' da plataforma diretamente, não esta variável.
# var movimento := Vector2.ZERO 
var centro_da_plataforma := 16.0 

# Variável para rastrear o Tween e a Escala
var plataforma_tween: Tween = null
var ultima_escala_conhecida: float = 1.0


func _ready() -> void:
	# 1. Inicia o movimento com a velocidade base
	_create_movement_tween()
	# 2. Inicializa o rastreio de escala
	ultima_escala_conhecida = Globals.Velo_escala


func _process(delta: float) -> void:
	# Verifica se a escala global mudou
	if Globals.Velo_escala != ultima_escala_conhecida:
		
		# 1. Atualiza o rastreio (garantindo que este código rode só uma vez)
		ultima_escala_conhecida = Globals.Velo_escala
		
		# 2. Calcula a nova velocidade (Base * Escala com deficit)
		# O Globals.Velo_escala já contém o deficit (raiz quadrada).
		mov_velocidade = MOV_VELOCIDADE_BASE * Globals.Velo_escala

		# 3. Recria o Tween para aplicar a nova duração/velocidade
		_create_movement_tween()


# Função para criar/reiniciar o movimento suave da plataforma
func _create_movement_tween():
	
	# 1. Garante que qualquer tween anterior seja parado
	if plataforma_tween:
		plataforma_tween.kill()
		plataforma_tween = null

	# 2. Define a direção e calcula a DURAÇÃO com a nova 'mov_velocidade'
	var mov_direção = Vector2.RIGHT * distancia if mov_horizontal else Vector2.UP * distancia
	
	# Duração = Distância / Velocidade
	var duracao = mov_direção.length() / (mov_velocidade * centro_da_plataforma) 

	# 3. Cria o novo Tween com loop infinito
	plataforma_tween = create_tween().set_loops()
	plataforma_tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

	# 4. Anima a propriedade "position" do nó AnimatableBody2D filho
	plataforma_tween.tween_property(plataform, "position", mov_direção, duracao).set_delay(TEMPO_DE_ESPERA)
	plataforma_tween.tween_property(plataform, "position", Vector2.ZERO, duracao).set_delay(TEMPO_DE_ESPERA)
