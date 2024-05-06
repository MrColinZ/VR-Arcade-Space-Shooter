extends Node

class_name EnemyMovement

@export_category("Keep distance to Player")
@export var keep_distance_to_player: bool = false
@export var distance_to_player: int = 120
@export var random_distance: bool = false # Makes the distance to the Player a bit Random.

@export_category("Pos Change")
@export var random_xy_pos: bool = false
@export var pos_wait_time: float = 4.0

@onready var level_height = get_node("/root/Main/LevelGenerator").level_height
@onready var level_with = get_node("/root/Main/LevelGenerator").level_with
@onready var entity: Node = get_parent()
@onready var ship_node: Node = get_node("/root/Main/Ship")

var next_xy_pos: Vector2

func _ready():
	if random_xy_pos:
		await get_tree().create_timer(pos_wait_time).timeout
		new_random_xy_pos()
		
	if random_distance:
		distance_to_player = randi_range(distance_to_player,distance_to_player+50)


func _process(_delta):
	
	if keep_distance_to_player:
		entity.global_position.z = ship_node.global_position.z + distance_to_player
		
	if random_xy_pos:
		var cur_xy_pos = Vector2(entity.global_position.x,entity.global_position.y)
		var xy_pos = cur_xy_pos.lerp(next_xy_pos,0.05)
		entity.global_position.x = xy_pos.x
		entity.global_position.y = xy_pos.y


func new_random_xy_pos():
	var x = randi_range(10,level_with-10)
	var y = randi_range(10,level_height-10)
	next_xy_pos = Vector2(x,y)
	await get_tree().create_timer(pos_wait_time).timeout
	new_random_xy_pos()
