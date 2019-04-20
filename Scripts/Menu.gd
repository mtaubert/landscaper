extends Node2D

func _ready():
	print(abs(1))
	print(abs(0))
	print(abs(-1))

func generate():
	get_tree().change_scene("res://Scenes/Terrain_Map.tscn")