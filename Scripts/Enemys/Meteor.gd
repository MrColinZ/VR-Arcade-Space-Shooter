extends "res://Scripts/Enemys/Entity.gd"

@export var min_size = 10
var rotation_speed_multiplyer = 0.01
var rotation_speed
var rotation_angle

func _ready():

	#Set the Meteor to a Random Size when created
	var random = randf_range(min_size,min_size+10)
	scale = Vector3(random,random,random)
	
	randomize()
	rotation = Vector3(randi(),randi(),randi())
	rotation_speed = randf_range(-1,1)
	rotation_angle = Vector3(randf(),randf(),randf()).normalized()

func _process(_delta):
	rotate(rotation_angle,rotation_speed * rotation_speed_multiplyer)
