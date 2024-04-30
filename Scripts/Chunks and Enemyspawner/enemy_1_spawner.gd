extends Node3D

@export var enemy_scene: PackedScene
@export var spawn_pos_to_player = 400
var ship_node: Node
var level_with
var level_height

func _ready():
	ship_node = get_node("/root/Main/Ship")
	level_with = get_parent().level_with
	level_height = get_parent().level_height


#Delets the Spawner + Childs when the Player has past
func _process(_delta):
	if global_position.z + 200 < ship_node.global_position.z:
		queue_free()


#Spawns given numbers of stationary Enemys
func spawn_enemy(enemy_count):
	
	for x in range(0,enemy_count):
		var enemy = enemy_scene.instantiate()
		#Set Random x,y and z axis
		var y_pos = randi_range(20,level_height - 20)
		var z_pos = randi_range(0,100)
		var x_pos = randi_range(20,level_with - 20)
		
		enemy.set_position(Vector3(x_pos,y_pos,z_pos))
		enemy.add_score.connect(get_node("/root/Main/ScoreManager").on_add_score)
		add_child(enemy)
		if enemy.has_overlapping_areas():
			enemy.queue_free()
