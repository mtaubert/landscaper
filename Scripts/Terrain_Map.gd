extends Node2D

onready var terrain = get_node("Terrain")

var gridSize
var currentIterationGrids
var numberOfMaps
var currentMapindex

func _ready():
	
	setup_ui()
	
	gridSize = Terrain_Generator.gridSize
	Genetic_Algorithm.new_generation(0)
	currentIterationGrids = Terrain_Generator.get_next_iteration()
	numberOfMaps = currentIterationGrids.size()
	currentMapindex = 0
	display_maps()

func setup_ui():
	$UI/Rateing_Panel.hide()
	$UI/Help_Panel.hide()
	
	var waterOptions = ["Select one", "Good", "Too low", "Too high"]
	var mountainOptions = ["Select one", "Good", "Too few", "Too many"]
	var islandOptions = ["Select one", "Good", "Too few", "Too many"]
	var biomeOptions = ["Select one", "Good", "More diverse", "Less diverse"]
	
	for i in range(4):
		$UI/Rateing_Panel/Ratings/Value/Water_Level.add_item(waterOptions[i],i)
		$UI/Rateing_Panel/Ratings/Value/Mountains.add_item(mountainOptions[i],i)
		$UI/Rateing_Panel/Ratings/Value/Islands.add_item(islandOptions[i],i)
		$UI/Rateing_Panel/Ratings/Value/Biomes.add_item(biomeOptions[i],i)

func display_maps():
	$UI/Menu_Bar_BG/Menu_Bar/Map_Number.text = "Map: " + String(currentMapindex+1)
	for x in range(gridSize.x):
		for y in range(gridSize.y):
			#print(String(x) + ", " + String(y))
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

func generate_next_iteration():
	$UI/Rateing_Panel.hide()
	
	Genetic_Algorithm.new_generation($UI/Rateing_Panel/Ratings/Value/Islands.get_selected_id())
	
	#send details from the rate panel to the algorithm
	currentIterationGrids = Terrain_Generator.get_next_iteration()
	numberOfMaps = currentIterationGrids.size()
	currentMapindex = 0
	display_maps()

func _on_Menu_pressed():
	get_tree().change_scene("res://Scenes/Menu.tscn")

func _on_Rate_Iteration_pressed():
	$UI/Rateing_Panel.show()

func _on_Rating_Panel_Close_Button_pressed():
	$UI/Rateing_Panel.hide()

func _on_Help_pressed():
	$UI/Help_Panel.show()

func _on_Help_Panel_Close_Button_pressed():
	$UI/Help_Panel.hide()


