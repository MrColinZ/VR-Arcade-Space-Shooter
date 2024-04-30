extends AudioStreamPlayer3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func play_random_pitch(start_pos):
	pitch_scale = randf_range(0.9,1.1)
	play(start_pos)
