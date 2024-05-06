extends Area3D

@export var drop_type: String
@export var value : int = 1

func _ready():
	pass # Replace with function body.



func _process(_delta):
	pass


func _on_area_entered(area):
	area.get_node("CollectModul").add_drop(drop_type,value)
	$AudioStreamPlayer.play()
	$MeshInstance3D.queue_free()
	await get_tree().create_timer(1.0).timeout
	queue_free()
