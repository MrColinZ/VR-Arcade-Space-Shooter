extends "res://Scripts/Enemys/Entity.gd"

@export var shot_scene: PackedScene
var main_node: Node
var ship_node: Node

var shot_count = 5


func _ready():
	
	main_node = get_node("/root/Main")
	ship_node = get_node("/root/Main/Ship")
	
	if global_position.x > 50:
		$AnimationPlayer.play("EnemyEnter/Enter from left")
	else:
		$AnimationPlayer.play("EnemyEnter/Enter from right")
		


func _process(_delta):
	global_position.z = ship_node.global_position.z + 140



func _on_shoot_timer_timeout():
	
	if can_shoot:
		var shot = shot_scene.instantiate()
		shot.position = $Cannon.global_position
		main_node.add_child(shot)
		shot.look_at(ship_node.get_node("EnemyAimPoint").global_position)
		#Aiming a bit in front of the Player for better hitquote
		
		shot_count -= 1
		if shot_count <= 0:
			$ShootTimer.stop()
			$ReloadTimer.start()

func _on_reload_timer_timeout():
	shot_count = 5
	$ShootTimer.start()
