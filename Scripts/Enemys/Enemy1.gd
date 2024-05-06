extends "res://Scripts/Enemys/Entity.gd"

@export var shot_scene: PackedScene
var ship_node: Node


func _ready():
	ship_node = get_node("/root/Main/Ship")
	
	if global_position.x > 50:
		$AnimationPlayer.play("Enter from left")
	else:
		$AnimationPlayer.play("Enter from right")

func _process(_delta):
	look_at(ship_node.global_position)
	
	if global_position.z + 200 < ship_node.global_position.z:
		queue_free()




