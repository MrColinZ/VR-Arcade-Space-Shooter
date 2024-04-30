extends Node3D

var level_with
var level_height


func _ready():
	level_with = get_parent().level_with
	level_height = get_parent().level_height


func _process(_delta): #Delets the Chunk when Player has past
	if position.z + 200 < get_node("/root/Main/Ship").position.z:
		queue_free()


func create_level(chunk_length):
	
	#Set up the Area for the Ships detection. Area is not used jet
	$Area3D/CollisionShape3D.position = Vector3(level_with * 0.5, level_height * 0.5, chunk_length * 0.5)
	$Area3D/CollisionShape3D.shape.size = Vector3(level_with, level_height, chunk_length)
	
	
	#Setup Walls
	$WallRight.position = Vector3(0,level_height/2,chunk_length/2)
	$WallLeft.position = Vector3(level_with,level_height/2,chunk_length/2)
	$WallUp.position = Vector3(level_with/2,level_height,chunk_length/2)
	$WallDown.position = Vector3(level_with/2,0,chunk_length/2)
	
	$WallRight.scale = Vector3(chunk_length,level_height,1)
	$WallLeft.scale = Vector3(chunk_length,level_height,1)
	$WallUp.scale = Vector3(chunk_length,level_with,1)
	$WallDown.scale = Vector3(chunk_length,level_with,1)

