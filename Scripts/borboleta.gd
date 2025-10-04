extends AnimatedSprite2D

var amplitude: float = 10.0
var speed: float = 2.0
var base_y: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	base_y = position.y
	

func _process(delta: float) -> void:
	var offset = sin(Time.get_ticks_msec() / 1000.0 * speed) * amplitude
	position.y = base_y + offset
