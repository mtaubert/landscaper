extends Node2D

onready var terrain = get_node("Terrain")

var gridSize
var currentIterationGrids

func _ready():
	gridSize = Terrain_Generator.gridSize
	currentIterationGrids = Terrain_Generator.get_next_iteration()
	display_maps()

func display_maps():
	print(currentIterationGrids[0])
	for x in range(gridSize.x):
		for y in range(gridSize.y):
			terrain.set_cell(x,y,currentIterationGrids[0][x][y])