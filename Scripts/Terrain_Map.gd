extends Node2D

onready var terrain = get_node("Terrain")

var gridSize
var currentIterationGrids
var numberOfMaps
var currentMapindex

func _ready():
	gridSize = Terrain_Generator.gridSize
	currentIterationGrids = Terrain_Generator.get_next_iteration()
	numberOfMaps = currentIterationGrids.size()
	currentMapindex = 0
	display_maps()

func display_maps():
	$UI/Menu_Bar/Map_Number.text = "Map: " + String(currentMapindex+1)
	for x in range(gridSize.x):
		for y in range(gridSize.y):
			#Range from -1 to 1 where -1 is deep and 1 is tall
			var currentCell = currentIterationGrids[currentMapindex][x][y]
			if currentCell < Genetic_Algorithm.shallowsMinValue:
				terrain.set_cell(x,y,0)
			elif currentCell >= Genetic_Algorithm.shallowsMinValue and currentCell < Genetic_Algorithm.beachMinValue:
				terrain.set_cell(x,y,1)
			elif currentCell >= Genetic_Algorithm.beachMinValue and currentCell < Genetic_Algorithm.grasslandsMinValue:
				terrain.set_cell(x,y,2)
			elif currentCell >= Genetic_Algorithm.grasslandsMinValue and currentCell < Genetic_Algorithm.mountainsMinValue:
				terrain.set_cell(x,y,3)
			elif currentCell >= Genetic_Algorithm.mountainsMinValue and currentCell < Genetic_Algorithm.snowMinValue:
				terrain.set_cell(x,y,4)
			elif currentCell >= Genetic_Algorithm.snowMinValue:
				terrain.set_cell(x,y,5)

#Switch to the previous map
func _on_Left_Button_pressed():
	currentMapindex -= 1
	if currentMapindex < 0:
		currentMapindex = numberOfMaps-1
	
	display_maps()

#Switch to the next map
func _on_Right_Button_pressed():
	currentMapindex += 1
	if currentMapindex == numberOfMaps:
		currentMapindex = 0
	
	display_maps()
