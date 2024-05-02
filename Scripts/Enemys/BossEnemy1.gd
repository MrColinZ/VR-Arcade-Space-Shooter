extends "res://Scripts/Enemys/Entity.gd"

@onready var ship_node = get_node("/root/Main/Ship")
var position_state = "upleft"



func _ready():
	$AnimationPlayer.play("entry")
	

func _process(_delta):
	pass
	
