extends Node

@export var ship_node: Node
var score = 0
var distance_score = 0
var destroy_score = 0

func on_add_score(points):
	destroy_score += points


func _ready():
	pass # Replace with function body.


func _on_score_updater_timeout():
	distance_score = int(ship_node.global_position.z/100)
	score= distance_score + destroy_score
	ship_node.get_node("Score").text = "Score: " + str(score)

func reset_score():
	score = 0
	distance_score = 0
	destroy_score = 0
	$ScoreUpdater.start()
	ship_node.get_node("Score").text = "Score: " + str(score)
