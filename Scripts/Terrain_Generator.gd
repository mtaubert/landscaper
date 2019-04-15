extends Node

var gridSize = Vector2(100, 53)
var grids = {}
var entriesPerIteration = 5
var noise = {}

func _ready():
	randomize()

func configure_noise(octaves, period, persistence):
	for i in range(entriesPerIteration):
		noise[i] = OpenSimplexNoise.new()
		noise[i].seed = randi()
		noise[i].octaves = octaves
		noise[i].period = period
		noise[i].persistence = persistence

func get_next_iteration():
	configure_noise(4, 20, 0.8)
	for i in range(entriesPerIteration):
		var grid = []
		for x in range(gridSize.x):
			grid.append([])
			for y in range(gridSize.y):
				grid[x].append(randi()%7)
		grids[i] = grid
	
	return grids