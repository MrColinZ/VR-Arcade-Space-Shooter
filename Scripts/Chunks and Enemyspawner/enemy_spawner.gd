extends Node

class_name EnemySpawner

@export var enemy_scene: PackedScene

@export var connect_defeat_signal: bool = false

@export_category("XY Position")
@export var random_xy_pos: bool = false
@export var xy_pos_level_mid: bool = false
@export var cus_xy_pos: Vector2 = Vector2(0,0)

@export_category("Z Position")
@export var random_z_pos: bool = false
@export var random_z_range: int = 100
@export var min_z_dis_to_player: int = 100

@export_category("Enemy count")
@export var scale_with_difficulty: bool = false
@export var scale_rate: float = 1.0
@export var start_enemy_count: int = 1

@onready var level_with = get_parent().level_with
@onready var level_height  = get_parent().level_height
@onready var ship_node = get_node("/root/Main/Ship")

func _ready():
	pass # Replace with function body.


func _process(_delta):
	pass


func spawn_enemy(difficulty):
	
	var enemy_count
	
	if scale_with_difficulty:
		enemy_count = start_enemy_count + ((difficulty - 1) * scale_rate)
	else:
		enemy_count = start_enemy_count
	
	for x in range(0,enemy_count):
		var enemy = enemy_scene.instantiate()
		enemy.difficulty = difficulty
		
		if random_xy_pos:
			enemy.position.x = randi_range(10,level_with-10)
			enemy.position.y = randi_range(10,level_height-10)
		elif xy_pos_level_mid:
			enemy.position.x = level_with * 0.5
			enemy.position.y = level_height * 0.5
		else:
			enemy.position.x = cus_xy_pos.x
			enemy.position.y = cus_xy_pos.y
		
		var z = ship_node.position.z + min_z_dis_to_player
		if random_z_pos:
			z += randi_range(0, random_z_range)
		enemy.position.z = z
			
		if connect_defeat_signal:
			enemy.defeat.connect(get_node("/root/Main/LevelGenerator").reset_spawnstate)
			
		enemy.add_score.connect(get_node("/root/Main/ScoreManager").on_add_score)
		
		add_child(enemy)
		
		if enemy.has_overlapping_areas():
			enemy.queue_free()
