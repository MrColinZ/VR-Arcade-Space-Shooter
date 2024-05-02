extends MeshInstance3D

var ring_rot_speed = 0



func _process(delta):
	rotate_z(ring_rot_speed * delta)
	ring_rot_speed += 0.1

func _on_cannon_shot_fired():
	ring_rot_speed = 0
