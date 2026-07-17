extends HSlider

@export var nomeBus : String
var busIndex : int

func _ready() -> void:
	busIndex = AudioServer.get_bus_index(nomeBus)
	value_changed.connect(volume_alterado)
	
	value = db_to_linear(AudioServer.get_bus_volume_db(busIndex))
	
func volume_alterado(valor : float) -> void:
	AudioServer.set_bus_volume_db(busIndex, linear_to_db(valor))
