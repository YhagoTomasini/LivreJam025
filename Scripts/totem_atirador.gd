extends StaticBody2D

const TIRO_TOTEM = preload("res://Prefabs/tiro_totem.tscn")

@onready var spawn_do_tiro: Marker2D = $spawn_do_tiro
@onready var sprite: Sprite2D = $sprite
@onready var cd_tiro: Timer = $cd_tiro
@onready var colisao: CollisionShape2D = $colisao

# Constante para o tempo de recarga base (Ex: 0.5 segundo)
const TEMPO_BASE_CD_TIRO := 1.5 

@export var para_direita : bool = true

# Variáveis para rastrear a escala
var ultima_escala_conhecida: float = 1.0


func _ready() -> void:
	colisao.disabled = true
	# 1. Configura a direção do sprite
	if !para_direita:
		scale.x *= -1
		#sprite.flip_h = false
	#else:
		#sprite.flip_h = true
		
	# 2. Inicializa o timer com o tempo base
	cd_tiro.wait_time = TEMPO_BASE_CD_TIRO
	# 3. Inicializa o rastreio
	ultima_escala_conhecida = Globals.Velo_escala
	# 4. Faz o primeiro cálculo de escala
	_update_fire_rate()


# Nova função para calcular o tempo de recarga do tiro
func _update_fire_rate():
	
	# 1. Pega o fator de escala de velocidade com o deficit (Ex: 1.41)
	var escala = Globals.Velo_escala
	
	# 2. Se a escala for maior que 1 (jogador está mais rápido)
	if Globals.VELO != Globals.Velo_base:
		# Tempo de recarga é inversamente proporcional à escala. 
		# Quanto maior a escala, menor o tempo de espera (tiro mais rápido).
		cd_tiro.wait_time = TEMPO_BASE_CD_TIRO / escala
	else:
		# Se o jogador estiver na velocidade base ou mais lento, usa o tempo base
		cd_tiro.wait_time = TEMPO_BASE_CD_TIRO
		
	# 3. Garante que o tempo mínimo de espera seja razoável (Ex: 0.1s)
		cd_tiro.wait_time = max(cd_tiro.wait_time, 0.1)
	
	# 4. Se o timer estiver rodando (não pausado), atualiza o tempo restante para o novo valor
	if cd_tiro.is_stopped() == false:
		cd_tiro.start()


func _process(delta: float) -> void:
	# Verifica se a escala global mudou
	if Globals.Velo_escala != ultima_escala_conhecida: 
		# 1. Atualiza o rastreio
		ultima_escala_conhecida = Globals.Velo_escala
		
		# 2. Recalcula e aplica a nova taxa de tiro
		_update_fire_rate()

# ... (O resto das funções permanecem as mesmas)

func spawn_tiro():
	var novo_tiro = TIRO_TOTEM.instantiate()
	if para_direita:
		novo_tiro.qual_direcao(1)
	else:
		novo_tiro.qual_direcao(-1)
	add_sibling(novo_tiro)
	novo_tiro.global_position = spawn_do_tiro.global_position


func _on_visible_on_screen_enabler_2d_screen_entered() -> void:
	# Reinicia o timer com o tempo ATUALIZADO (se for o caso)
	# A função start() sempre usa o valor atual de wait_time.
	cd_tiro.start() 
	cd_tiro.paused = false

func _on_cd_tiro_timeout() -> void:
	spawn_tiro()

func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	cd_tiro.paused = true
