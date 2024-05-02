extends Node

@export var boss_enemy3_scene: PackedScene
@export var enemy_count = 1

@onready var parent = get_parent()

@onready var level_height = get_parent().level_height
@onready var level_with = get_parent().level_with

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func spawn_enemy():
	
	for x in range(0,enemy_count):
		var enemy = boss_enemy3_scene.instantiate()
		enemy.position.x = level_with * 0.5
		enemy.position.y = level_height * 0.5
		enemy.add_score.connect(get_node("/root/Main/ScoreManager").on_add_score)
		enemy.defeat.connect(get_node("/root/Main/LevelGenerator").reset_spawnstate)
		add_child(enemy)
		print("spawn boss")

