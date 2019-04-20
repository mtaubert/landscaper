extends Node

var gridSize = Vector2(200, 106)
var grids = {}
var entriesPerIteration = 5
var noise = {}

func _ready():
	randomize()

#Creates a set of noise maps for use in drawing the map
func configure_noise(octaves, period, persistence, lacunarity):
	for i in range(entriesPerIteration):
		noise[i] = {}
		#Heightmap noise
		noise[i]["heightmap"] = OpenSimplexNoise.new()
		noise[i]["heightmap"].seed = randi()
		noise[i]["heightmap"].octaves = octaves
		noise[i]["heightmap"].period = period
		noise[i]["heightmap"].persistence = persistence
		noise[i]["heightmap"].lacunarity = lacunarity
		
		#Biome noise
		noise[i]["biome"] = OpenSimplexNoise.new()
		noise[i]["biome"].seed = randi()
		noise[i]["biome"].octaves = octaves
		noise[i]["biome"].period = period
		noise[i]["biome"].persistence = persistence
		noise[i]["biome"].lacunarity = lacunarity

#Generates a new set of noise and then returns if for the terrain map
func get_next_iteration():
	configure_noise(Genetic_Algorithm.octaves, Genetic_Algorithm.period, Genetic_Algorithm.persistence, Genetic_Algorithm.lacunarity)
	
	#Saves the noise x,y values for each noise to a 2d array
	for i in range(entriesPerIteration):
		var grid = []
		for x in range(gridSize.x):
			grid.append([])
			for y in range(gridSize.y):
				if x >= 0.05*gridSize.x and x <= 0.95*gridSize.x:
					grid[x].append(noise[i]["heightmap"].get_noise_2d(x,y))
				else:
					#Returns the noise value modified for the start and end 5% of the map to make the edges ocean
					grid[x].append((-1*int(x/(0.5*gridSize.x)) + 0.5)*((int(x/(0.5*gridSize.x))-1)+((x%int(0.05*gridSize.x))/(0.05*gridSize.x))) + noise[i]["heightmap"].get_noise_2d(x,y))
		grids[i] = grid
	return grids