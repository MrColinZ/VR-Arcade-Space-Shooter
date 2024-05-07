extends Marker3D

@export var shot_scene: PackedScene
@export var shot_count = 5
@export var reload_time = 5.0
@export var shoot_interval = 0.5
@export var shot_dir_to_player: bool = true
@export var entity: Node
@onready var ship_node = get_node("/root/Main/Ship")
@onready var main_node = get_node("/root/Main")

signal  shot_fired()

var cur_shot_count

func _ready():
	$ShootTimer.wait_time = shoot_interval
	$ReloadTimer.wait_time = reload_time
	$ReloadTimer.start()


func _process(_delta):
	pass


func _on_reload_timer_timeout():
	cur_shot_count = shot_count
	$ShootTimer.start()


func _on_shoot_timer_timeout():
	if entity.can_shoot && global_position.z > ship_node.get_node("EnemyAimPoint").global_position.z:
		var shot = shot_scene.instantiate()
		shot.position = global_position
		main_node.add_child(shot)
		if shot_dir_to_player:
			shot.look_at(ship_node.get_node("EnemyAimPoint").global_position)
			
		#Making the Shot Direction a bit random
		var rand_shot_dir = Vector3(randf_range(-1,1),randf_range(-1,1),randf_range(-1,1))*0.05
		shot.rotation = shot.rotation + rand_shot_dir
		
		shot_fired.emit()
		
		cur_shot_count -= 1
		if cur_shot_count <= 0:
			$ShootTimer.stop()
			$ReloadTimer.start()
