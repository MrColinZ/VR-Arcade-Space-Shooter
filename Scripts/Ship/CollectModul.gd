extends Node

@onready var parent = get_parent()

func _ready():
	pass # Replace with function body.


func _process(_delta):
	pass

func add_drop(type,value):
	if type == "Health":
		parent.health_update(value)
