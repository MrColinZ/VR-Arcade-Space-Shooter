extends Node3D

var level_with
var level_height
@export var meteor_scene: PackedScene
@export var h_meteor_scene: PackedScene
func _ready():
	level_with = get_parent().level_with
	level_height = get_parent().level_height


func _process(_delta):
	if position.z + 200 < get_node("/root/Main/Ship").position.z:
		queue_free()


func create_level(chunk_length,meteor_count):
	
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
	
	randomize()
	
	var rand_health_met = randi_range(0,2) #Chanche to spawn a Health Meteor.
	if rand_health_met == 0:
		var h_meteor = h_meteor_scene.instantiate()
		var z_pos = randi_range(0,100)
		h_meteor.position = Vector3(randi_range(0,level_with),randi_range(0,level_height),z_pos)
		h_meteor.add_score.connect(get_node("/root/Main/ScoreManager").on_add_score)
		add_child(h_meteor)
	
	for meteors in range(0,meteor_count): #Spawning the normal Meteors
		var meteor = meteor_scene.instantiate()
		var z_pos = chunk_length/meteor_count * meteors #Distributes the Meteors on z_axis
		meteor.position = Vector3(randi_range(0,level_with),randi_range(0,level_height),z_pos)
		meteor.add_score.connect(get_node("/root/Main/ScoreManager").on_add_score)
		add_child(meteor)
		if meteor.has_overlapping_areas():
			meteor.queue_free()
