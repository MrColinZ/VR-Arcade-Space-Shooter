extends "res://Scripts/Enemys/Entity.gd"

@export var shot_scene: PackedScene

@onready var ship_node: Node = get_node("/root/Main/Ship")


func _ready():
	
	if global_position.x > 50:
		$AnimationPlayer.play("EnemyEnter/Enter from left")
	else:
		$AnimationPlayer.play("EnemyEnter/Enter from right")
		


func _process(_delta):
	pass
