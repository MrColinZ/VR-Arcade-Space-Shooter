extends Area3D

@export var no_damage: bool = false
@export var start_health = 5
@export var shot_scene: PackedScene
@export var start_rotation_speed = 1 
@export var start_yaw_rate = 0.3
@export var start_move_speed = 50
var invert_x_axis: bool = false
var health
var rotation_speed 
var yaw_rate
var move_speed
var can_shoot = false
var cur_rotation_speed_x = 0
var cur_rotation_speed_y = 0
var cur_rotation_speed_z = 0
var rotation_vertical = 0
var rotation_horizontal = 0
var shoot_button_pressed = false
signal player_death


func _ready():
	rotation_speed = 0
	yaw_rate = 0
	move_speed = 0
	health = start_health


func start(_start_position): #Gets call by Main Node on Restart
	
	can_shoot = true
	rotation_speed = start_rotation_speed 
	yaw_rate = start_yaw_rate
	move_speed = start_move_speed
	
	
	
func _on_right_hand_input_vector_2_changed(_input_name, value):
	rotation_horizontal = value.x
	rotation_vertical = value.y
		
func _process(delta):
	
	if $XROrigin3D.vr_mode == false:
		rotation_horizontal = Input.get_axis("horizontal_left","horizontal_right")
		rotation_vertical = Input.get_axis("vertical_down","vertical_up")
		if invert_x_axis:
			rotation_vertical = -rotation_vertical
		
	#Use Lerp function to get smooth motion
	cur_rotation_speed_z = lerp_angle(cur_rotation_speed_z,rotation_horizontal,0.05)
	cur_rotation_speed_x = lerp_angle(cur_rotation_speed_x,rotation_vertical,0.05)
	
	#Set rotation
	rotate_object_local(Vector3(1,0,0),cur_rotation_speed_x * rotation_speed * delta)
	rotate_object_local(Vector3(0,0,1),cur_rotation_speed_z * rotation_speed * delta)

	
	#Set Yaw
	rotate_object_local(Vector3(0,1,0),-cur_rotation_speed_z * yaw_rate * delta)
	
	#Forward move.
	translate(Vector3(0,0,move_speed) * delta)
	
	
	#Shoot Input for none VR Mode
	if $XROrigin3D.vr_mode == false:
		shoot_button_pressed = Input.is_action_pressed("shoot")


	

#Makes the Player Shoot
func _on_shot_interval_timeout():
	if shoot_button_pressed && can_shoot:
		
		$ShootSound.play_random_pitch(0.2)
		
		var shot1 = shot_scene.instantiate()
		var shot2 = shot_scene.instantiate()
		
		shot1.position = $CanonLeft.global_position
		shot2.position = $CanonRight.global_position
		
		shot1.rotation = $CanonLeft.global_rotation
		shot2.rotation = $CanonRight.global_rotation
		
		var parent = get_parent()
		parent.add_child(shot1)
		parent.add_child(shot2)



#Get calld when something hits the Player.
func _on_area_entered(area):
	
	if !no_damage:
		$DamageSound.play_random_pitch(0)
		$AnimationPlayer.play("ship_hit")
		health_update(-area.damage)	
		
		if health <= 0: #Stop the Player and send a Signal to Main Node when Health gets to zero.
			death()
		
		no_damage = true #Making the Player unhittable after hit for given time
		print(no_damage)
		await get_tree().create_timer(2).timeout
		no_damage = false
		print(no_damage)
		
		


func death():
	player_death.emit()
	rotation_speed = 0 
	yaw_rate = 0
	move_speed = 0
	can_shoot = false
	
	
#Vr Input for Shooting
func _on_right_hand_button_pressed(input_name):
	if input_name == "trigger_click":
		shoot_button_pressed = true

func _on_right_hand_button_released(input_name):
	if input_name == "trigger_click":
		shoot_button_pressed = false


func health_update(value):
	health += value
	health = clamp(health,0,start_health)
	if value < 0:
		for x in range(0,4):
			$Healthbar.set_frame(health-1)
			await get_tree().create_timer(0.2).timeout
			$Healthbar.set_frame(health)
			await get_tree().create_timer(0.2).timeout
			$Healthbar.set_frame(health-1)
	else:
		$Healthbar.set_frame(health-1)
			

func update_speed(speed):
	move_speed = start_move_speed + speed


func _on_invert_axis_button_toggled(toggled_on): #Invert x Axis when Button in Menu is pressed
	if toggled_on:
		invert_x_axis = true
	else:
		invert_x_axis = false
