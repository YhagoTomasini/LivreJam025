extends Node2D

const TEMPO_DE_ESPERA := 1.0

@onready var plataform: AnimatableBody2D = $plataform

@export var mov_velocidade := 3.0
@export var distancia := 192 #distancia mutiplicada por 16p
@export var mov_horizontal := true

var movimento := Vector2.ZERO
var centro_da_plataforma := 16

func _ready() -> void:
	movimentando_a_plataforma()
	

func _physics_process(delta: float) -> void:
	plataform.position = plataform.position.lerp(movimento, 0.5)


func movimentando_a_plataforma():
#Basicamente a direção que ele se mexe é para direita com base na distancia e se casoa boleana for verdadeira
#caso contrario ele se move para cima se a boleana for falsa 
	var mov_direção = Vector2.RIGHT * distancia if mov_horizontal else Vector2.UP * distancia
	var duracao = mov_direção.length() / float(mov_velocidade * centro_da_plataforma)
#set_loops -> Numero de vezes que ira repetir: como esta vazio fara infinitamente
#set_trans é o tipo de transição / set_ease é o tipo de suavização / set_delay é o tempo de atraso -> set_delay(duracao +TEMPO_DE_ESPERA *2)
	var plataforma_tween = create_tween().set_loops().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	plataforma_tween.tween_property(self, "movimento", mov_direção, duracao).set_delay(TEMPO_DE_ESPERA)
	plataforma_tween.tween_property(self, "movimento", Vector2.ZERO, duracao).set_delay(TEMPO_DE_ESPERA)
