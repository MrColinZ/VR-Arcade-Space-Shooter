extends Sprite3D

@export var xrcamera_node: Node
@export var xrorigin_node: Node


func _ready():
	pass



func _process(_delta):
	position.x = xrorigin_node.position.x + xrcamera_node.position.x * -1
	position.y = xrorigin_node.position.y + xrcamera_node.position.y
