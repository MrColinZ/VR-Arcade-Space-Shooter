extends Node

class_name ScalePulse

@export var time_scale = 8
@export var amplifire = 1
@export var pulse_object: Node3D 
@onready var shot_scale = pulse_object.scale
var time: float


func _process(delta):
	if pulse_object != null:
		time += delta * time_scale
		pulse_object.scale = shot_scale + (Vector3(2,2,2) + Vector3(sin(time),sin(time),sin(time))) * amplifire
	

