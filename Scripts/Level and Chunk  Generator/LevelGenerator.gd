extends Node3D


@export var ship_node: Node
@export var chunk_length = 200
@export var level_with = 100
@export var level_height = 100
@export var difficulty_increase = 0.05 #Difficulty increase per Chunk creation
@onready var main_node = get_parent()
var spawn_state = "normal"
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
	spawn_state = "normal"


#Gets called when a new Chunk needs to be generated.
func new_chunk():
	#Chunk Types: 0=Emty, 1=Meteor
	#Enemy Types: 0=none, 1=Stationary 2=MovingEnemy, 3=PulseShotEnemy, 100=BossEnemy1
	
	var next_chunk_type
	if chunk_count == 0:
		next_chunk_type = 0
	else:
		next_chunk_type = 1
	
	
	var next_enemy_type
	if spawn_state == "normal":
		if chunk_count < 5:
			next_enemy_type = 0
		if chunk_count > 5:
			next_enemy_type = 1
		if chunk_count > 10:
			next_enemy_type = randi_range(1,2)
		if chunk_count == 20:
			spawn_state = "boss"
			next_enemy_type = 100
		if chunk_count > 5:
			next_enemy_type = randi_range(1,3)
	
	print(spawn_state)
	
	if next_chunk_type == 0:
		$EmtyChunkGenerator.new_emty_chunk()
	
	if next_chunk_type == 1:
		$MeteorChunkGenerator.new_meteor_chunk() #Adds a new Meteor Chunk. You can add a logic to generate diffrent types of chunks.
	
	if next_enemy_type == 1:
		$Enemy1Spawner.spawn_enemy(difficulty) #Call this to spawn new Enemys from Type 1
	
	if next_enemy_type == 2:
		$Enemy2Spawner.spawn_enemy(difficulty)
	
	if next_enemy_type == 100:
		$BossEnemy1Spawner.spawn_enemy(difficulty)
		
	if next_enemy_type == 3:
		$Enemy3Spawner.spawn_enemy(difficulty)
		
	chunk_count += 1
	next_position = Vector3(0,0,next_position.z + chunk_length)#Set Position for next Chunk
	
	difficulty = 1.0 + float(chunk_count) * difficulty_increase #Update Difficulty
	print("Difficulty:" + str(difficulty))
	
	if main_node.game_state == "Running": #Update Ship velocity according to difficulty
		ship_node.update_speed(difficulty)

func reset_spawnstate():
	spawn_state = "normal"








