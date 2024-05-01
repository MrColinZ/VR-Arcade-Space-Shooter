extends "res://Scripts/Enemys/Entity.gd"

@export var shot_scene: PackedScene
@onready var main_node: Node = get_node("/root/Main")
@onready var ship_node = get_node("/root/Main/Ship")
var position_state = "upleft"
var shot_count = 5


func _ready():
	$AnimationPlayer.play("entry")
	print(get_parent().position)

func _process(delta):
	get_parent().global_position.z = ship_node.global_position.z + 100
	

func _on_position_change_timeout():
	if position_state == "upleft":
		$AnimationPlayer.play("move_right")
		position_state = "upright"
		
	elif position_state == "upright":
		$AnimationPlayer.play("move_down")
		position_state = "downright"
		
	elif position_state == "downright":
		$AnimationPlayer.play("move_left")
		position_state = "downleft"
		
	elif position_state == "downleft":
		$AnimationPlayer.play("move_up")
		position_state = "upleft"


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
