extends Area3D

@export var drop_scene: PackedScene
@export var damage = 10
@export var health = 5
@export var points = 5
@export var can_shoot: bool = true
@export var can_drop: bool = false
@onready var main = get_node("/root/Main")
var difficulty
signal add_score(int)
signal defeat()


func _ready():
	
	pass


func _process(_delta):
	pass


#Taking Damage when something hits.
func _on_area_entered(body):
	
	health -= body.damage
	print(health)
	if health <= 0:
		add_score.emit(points)
		defeat.emit()
		
		if can_drop:
			drop_item()
		$ExplosionSound.play_random_pitch(0.47)
		$MeshInstance3D.queue_free()
		$CollisionShape3D.queue_free()
		$GPUParticles3D.emitting = true
		can_shoot = false
		await get_tree().create_timer(2.0).timeout
		queue_free()


func drop_item():
	can_drop = false #Make sure that only one Item is dropped
	var drop = drop_scene.instantiate()
	drop.position = global_position
	main.add_child(drop)
