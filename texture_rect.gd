extends Sprite2D

@onready var cam : Camera2D = $"../Golem/Camera2D"
@onready var cha : CharacterBody2D = $"../Golem"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = cha.position - Vector2(0, 100)
