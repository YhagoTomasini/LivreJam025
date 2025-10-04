extends Node

var VELO: float
var PULO: float

var noChao: bool
var podeMover: bool

func _ready() -> void:
	Globals.VELO = 300
	Globals.PULO = -500
	Globals.podeMover = true
