extends Node

#Terrain height values
var shallowsMinValue = -0.3
var beachMinValue = 0
var grasslandsMinValue = 0.1
var mountainsMinValue = 0.3
var snowMinValue = 0.4

#Terrain biome values
#TBA

#Noise generation values
var octaves = 4
var period = 40
var persistence = 0.8

func _ready():
	randomize()
