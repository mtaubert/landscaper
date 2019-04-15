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
			terrain.set_cell(x,y,currentIterationGrids[currentMapindex][x][y])

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
