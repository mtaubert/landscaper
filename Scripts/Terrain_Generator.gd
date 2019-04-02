extends Node

var gridSize = Vector2(100, 53)
var grids = {}
var entriesPerIteration = 1

func _ready():
	randomize()

func get_next_iteration():
	for i in range(entriesPerIteration):
		var grid = []
		for x in range(gridSize.x):
			grid.append([])
			for y in range(gridSize.y):
				grid[x].append(randi()%2)
		grids[i] = grid
	
	return grids