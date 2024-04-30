extends Node

@export var enemy1_spawner_scene: PackedScene

@onready var parent = get_parent()
@onready var level_with = get_parent().level_with
@onready var level_height = get_parent().level_height

func new_enemy1_spawner():
	var enemy1_spawner = enemy1_spawner_scene.instantiate()
	enemy1_spawner.position = Vector3(0,0,parent.ship_node.global_position.z + 300)
	add_child(enemy1_spawner)
	enemy1_spawner.spawn_enemy(parent.difficulty)#Tell the Spawner to spawn Enemys
