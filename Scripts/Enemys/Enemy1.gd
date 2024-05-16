extends "res://Scripts/Enemys/Entity.gd"

@export var shot_scene: PackedScene
@onready var ship_node: Node = get_node("/root/Main/Ship")



func _process(_delta):
	look_at(ship_node.global_position)
	
	if global_position.z + 200 < ship_node.global_position.z:
		queue_free()




