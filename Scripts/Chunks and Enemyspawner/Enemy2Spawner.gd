extends Node

@export var enemy2_scene: PackedScene
@export var enemy_count = 1

@onready var parent = get_parent()

@onready var level_height = get_parent().level_height
@onready var level_with = get_parent().level_with

func _ready():
	pass # Replace with function body.



func _process(_delta):
	pass


func spawn_enemy():
	
	for x in range(0,enemy_count):
		var enemy = enemy2_scene.instantiate()
		enemy.position.x = randi_range(0,level_with)
		enemy.position.y = randi_range(0,level_height)
		add_child(enemy)
		if enemy.has_overlapping_areas():
			enemy.queue_free()
