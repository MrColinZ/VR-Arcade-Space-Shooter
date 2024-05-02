extends Area3D

@export var damage = 1
@export var move_speed = 200
@export var destroy_distance = 200
@export var hit_sound_enable = true
var start_position


func _ready():
	start_position = position


func _process(delta):
	#Makes the Shot move
	translate(Vector3(0,0,-move_speed) * delta)
	
	
	# Destroys the Shot by given distance to start position.
	var distance_to_start = position.distance_to(start_position)
	if distance_to_start > destroy_distance:
		queue_free()


func _on_area_entered(_area):#Destroys the Shot when hit something.
	
	if hit_sound_enable:
		$CollisionShape3D.queue_free()
		$MeshInstance3D.queue_free()
		$OmniLight3D.queue_free()
		$AudioStreamPlayer3D.play_random_pitch(0)
		await get_tree().create_timer(2.0).timeout
	queue_free()
