extends Control

func _ready() -> void:
	AudioManager.criar_aud(SoundEffect.TIPO_DE_SOM.TEMA1, 1)

func _on_play_button_down() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_creditos_button_down() -> void:
	get_tree().change_scene_to_file("res://Scenes/creditos.tscn")
