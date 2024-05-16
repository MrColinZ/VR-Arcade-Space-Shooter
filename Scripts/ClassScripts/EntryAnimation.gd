extends AnimationPlayer

class_name EntryAnimation

@onready var parent = get_parent()

func _ready():
	if parent.global_position.x > 50:
		play("EnemyEnter/Enter from left")
	else:
		play("EnemyEnter/Enter from right")
