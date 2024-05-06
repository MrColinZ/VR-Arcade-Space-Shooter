extends Node

@export var emty_chunk_scene: PackedScene
@onready var level_generator = get_parent()
@onready var level_with = get_parent().level_with
@onready var level_height = get_parent().level_height

func new_emty_chunk():
	var emty_chunk = emty_chunk_scene.instantiate()
	emty_chunk.position = level_generator.next_position
	add_child(emty_chunk)
	#Tell the Chunk to setup Envoirment
	emty_chunk.create_level(level_generator.chunk_length)
