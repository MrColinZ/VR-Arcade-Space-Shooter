extends Node

@export var meteor_chunk_scene: PackedScene
@export var meteors_per_chunk = 5

@onready var level_generator = get_parent()
@onready var level_with = get_parent().level_with
@onready var level_height = get_parent().level_height

func new_meteor_chunk():
	var meteor_chunk = meteor_chunk_scene.instantiate()
	meteor_chunk.position = level_generator.next_position
	add_child(meteor_chunk)
	var meteor_count = meteors_per_chunk * level_generator.difficulty/2
	#Tell the Chunk to setup Envoirment
	meteor_chunk.create_level(level_generator.chunk_length,meteor_count)
