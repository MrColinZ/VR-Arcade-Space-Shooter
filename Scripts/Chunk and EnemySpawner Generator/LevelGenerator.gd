extends Node3D

@export var meteor_chunk_scene: PackedScene

@export var ship_node: Node
@export var chunk_length = 200
@export var level_with = 100
@export var level_height = 100
@export var difficulty_increase = 0.05 #Difficulty increase per Chunk creation


var chunk_count = 0 
var next_position = Vector3(0,0,0) 
var difficulty = 1

func _ready():
	pass


func _process(_delta):
	#Get in wich Chunk the Ship is
	var chunk_ship_is_in = int(ship_node.position.z/chunk_length)
	
	#Creates new Chunk when Ship enters next Chunk
	if chunk_count < chunk_ship_is_in + 6:
		new_chunk()


func reset():
	chunk_count = 0
	next_position = Vector3.ZERO
	difficulty = 1


#Gets called when a new Chunk needs to be generated.
func new_chunk():
	#Chunk Types: 0=Emty, 1=Meteor
	#Enemy Types: 0=none, 1=Stationary
	
	var next_chunk_type
	if chunk_count == 0:
		next_chunk_type = 0
	else:
		next_chunk_type = 1
	
	
	var next_enemy_type
	if chunk_count < 5:
		next_enemy_type = 0
	if chunk_count > 5:
		next_enemy_type = 1
	if chunk_count > 10:
		next_enemy_type = randi_range(1,2)
	
	
	if next_chunk_type == 0:
		$EmtyChunkGenerator.new_emty_chunk()
	
	if next_chunk_type == 1:
		$MeteorChunkGenerator.new_meteor_chunk() #Adds a new Meteor Chunk. You can add a logic to generate diffrent types of chunks.
	
	if next_enemy_type == 1:
		$Enemy1SpawnerGenerator.new_enemy1_spawner() #Call this to spawn new Enemys from Type 1
	
	if next_enemy_type == 2:
		$Enemy2Spawner.spawn_enemy()
	
	chunk_count += 1
	next_position = Vector3(0,0,next_position.z + chunk_length)#Set Position for next Chunk
	
	difficulty = 1.0 + float(chunk_count) * difficulty_increase











