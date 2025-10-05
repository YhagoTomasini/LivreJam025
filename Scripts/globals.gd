extends Node

 

var VELO: float
var PULO: float

var Velo_base : float 
var Velo_escala : float


var noChao: bool
var podeMover: bool

func _ready() -> void:
	Globals.VELO = 300
	Globals.PULO = -500
	Globals.podeMover = true
	Velo_base = VELO

func _process(delta: float) -> void:
	if VELO != Velo_base:
		var player_speed_ratio = VELO / Velo_base
		var deficit_factor = sqrt(player_speed_ratio)
		Velo_escala = deficit_factor

func reset_game():
	VELO = Velo_base
	var cena_atual_caminho = get_tree().current_scene.scene_file_path
	get_tree().call_deferred("change_scene_to_file", cena_atual_caminho)
	
