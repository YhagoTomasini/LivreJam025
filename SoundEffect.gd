class_name SoundEffect
extends Resource

enum TIPO_DE_SOM {
	TEMA1,
	TEMA2,
	ANDAR,
	PULAR,
	FOCUS_ON,
	FOCUS_OFF,
	GRAB,
	QUEDA,
	UI_RESTART,
	DIGITAR,
	DIGITAR_ERRADO,
	ENTER,
	BRABULETA,
	TIRO,
	TIRO_QUEBRA
}

@export_range(0, 10) var limite : int = 5
@export var tipo : TIPO_DE_SOM
@export var som : AudioStreamWAV
@export_range(-40, 20) var volume : float = 0
@export_range(0.0, 4.0, 0.1) var pitch : float = 1.0
@export_range(0.0, 1.0, 0.01) var pitch_rand : float = 0.0
@export var bus : StringName

var aud_quantidade : int

func contar_aud(quantidade : int) -> void:
	aud_quantidade = max(0, aud_quantidade + quantidade)
	
func tem_limite() -> bool:
	return aud_quantidade < limite
	
func quando_som_acabar() -> void:
	contar_aud(-1)
