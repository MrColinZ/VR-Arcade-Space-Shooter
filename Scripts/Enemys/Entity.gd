extends Area3D

@export var damage = 10
@export var health = 5
@export var points = 5
var can_shoot = true
signal add_score(int)
signal defeat()

func _ready():
	
	pass


func _process(_delta):
	pass


#Taking Damage when something hits.
func _on_area_entered(body):
	
	health -= body.damage
	if health <= 0:
		add_score.emit(points)
		defeat.emit()
		$ExplosionSound.play_random_pitch(0.47)
		$MeshInstance3D.queue_free()
		$CollisionShape3D.queue_free()
		$GPUParticles3D.emitting = true
		can_shoot = false
		await get_tree().create_timer(2.0).timeout
		queue_free()
