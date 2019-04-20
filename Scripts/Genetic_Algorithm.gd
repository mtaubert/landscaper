extends Node

#Terrain height values
var shallowsMinValue = -0.3
var beachMinValue = 0
var grasslandsMinValue = 0.1
var mountainsMinValue = 0.3
var snowMinValue = 0.4

#Terrain biome values
var biomeOctaves = 3
var biomePeriod = 20
var biomePersistence = 0.6
var biomeLacunarity = 2

#Noise generation values
var octaves = 5 #1-7 controls the number of layers of noise 
var period = 40 #1-100 controls how far appart the highs and lows of the octaves are
var persistence = 0.6 #0-1 controls the decrease in amplitude of the octaves
var lacunarity = 2 #1.5-5 controls the increase in frequency of the octaves

func _ready():
	randomize()

#Takes feedback from the user
#0/1 - no changes
#2 - too little, increase the amount
#3 - too much, decrease the amount
func new_generation(islands):
	print(islands)
	if islands == 2:
		period -= rand_range(1,10)
	elif islands == 3:
		period += rand_range(1,10)
	print(period)

func randomize_noise_values():
	#octaves = randi()%10 + 1
	period = rand_range(0,100)
	persistence = rand_range(0,1)
	lacunarity = rand_range(1.5,5)
	
	print(String(octaves) + ", " + String(period) + ", " + String(persistence) + ", " + String(lacunarity))

func randomize_terrain_heights():
	shallowsMinValue = rand_range(-1,1)
	beachMinValue = rand_range(shallowsMinValue,1)
	grasslandsMinValue = rand_range(beachMinValue,1)
	mountainsMinValue = rand_range(grasslandsMinValue,1)
	snowMinValue = rand_range(mountainsMinValue,1)
	
	print(String(shallowsMinValue) + ", " + String(beachMinValue) + ", " + String(grasslandsMinValue) + ", " + String(mountainsMinValue) + ", " + String(snowMinValue) + ", ")
