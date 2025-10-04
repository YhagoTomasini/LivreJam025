extends Node

var VELO: float
var PULO: float

var podeMover: bool

func _ready() -> void:
	Globals.VELO = 9999
	Globals.PULO = -500
	Globals.podeMover = true
