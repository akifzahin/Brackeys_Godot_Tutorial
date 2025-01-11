extends Node

var gameScore = 0
@onready var score = $Score


func addPoint():
	gameScore+=1
	score.text = "Coins = " + str(gameScore)
