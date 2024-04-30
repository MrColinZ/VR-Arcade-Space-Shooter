extends "res://Scripts/Enemys/Entity.gd"

@export var shot_scene: PackedScene
var main_node: Node
var ship_node: Node


func _ready():
	main_node = get_node("/root/Main")
	ship_node = get_node("/root/Main/Ship")
	
	if global_position.x > 50:
		$AnimationPlayer.play("Enter from left")
	else:
		$AnimationPlayer.play("Enter from right")

func _process(_delta):
	pass
	
	
#Creates a new Shot on Timer timeout and shoot it towards the Player
func _on_shoot_timer_timeout():
	
	if can_shoot:
		if global_position.z > ship_node.global_position.z:
			var shot = shot_scene.instantiate()
			shot.position = $Cannon.global_position
			main_node.add_child(shot)
			shot.look_at(ship_node.get_node("EnemyAimPoint").global_position)
			#Aiming a bit in front of the Player for better hitquote
