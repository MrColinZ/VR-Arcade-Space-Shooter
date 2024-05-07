extends "res://Scripts/Enemys/Shot.gd"

@export var time_scale = 8
@export var amplifire = 1
var shot_scale = scale
var time: float


func _process(delta):
	super(delta)
	time += delta * time_scale
	scale = shot_scale + (Vector3(2,2,2) + Vector3(sin(time),sin(time),sin(time))) * amplifire
	

