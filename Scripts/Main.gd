extends Node

var player_start_position
var game_state = "Menu"


func _ready():
	
	player_start_position = get_node("Ship").position
	randomize()
	$SoundtrackPlayer.play_soundtrack($SoundtrackPlayer.THEMES.MENU,true)

func _process(_delta):
	pass


func _on_ship_player_death():#Gets called by the Ship when Health is 0
	game_over()


func game_over(): 
	game_state = "GameOver"
	$CanvasLayer/Button.visible = true
	$Ship.set_visible(false)


func reset_to_menu():
	game_state = "Menu"
	$ScoreManager/ScoreUpdater.stop()
	$CanvasLayer/StartButton.visible = true
	$CanvasLayer/InvertAxisButton.visible = true
	randomize()
	$SoundtrackPlayer.play_soundtrack($SoundtrackPlayer.THEMES.MENU,true)
	$Ship.position = player_start_position
	$Ship.rotation = Vector3.ZERO
	$Ship.set_visible(true)
	$Ship.health = $Ship.start_health
	$Ship/Healthbar.set_frame($Ship.health - 1)
	$Ship/Instructions.visible = true
	$LevelGenerator.reset()
	get_tree().call_group("Chunks", "queue_free")
	get_tree().call_group("Spawner", "queue_free")
	get_tree().call_group("Shots", "queue_free")
	get_tree().call_group("Enemys", "queue_free")
	get_tree().call_group("Drops", "queue_free")


func new_game(): #Starts New Game
	get_node("ScoreManager").reset_score()
	$Ship.start(player_start_position)
	randomize()
	$SoundtrackPlayer.play_soundtrack($SoundtrackPlayer.THEMES.INGAME,true)
	$Ship/Instructions.visible = false
	game_state = "Running"

func _on_button_pressed(): #Reset Button to get to Menu
	reset_to_menu()
	$CanvasLayer/Button.visible = false


func _on_start_button_pressed(): #Start Button to Start new Game
	new_game()
	$CanvasLayer/StartButton.visible = false
	$CanvasLayer/InvertAxisButton.visible = false


func _on_right_hand_button_pressed(input_name):
	print(input_name)
	if input_name == "ax_button" && game_state == "Menu":
		new_game()
	
	if game_state == "GameOver" && input_name == "ax_button":
		reset_to_menu()

	if game_state == "Running" && input_name == "by_button":
		$Ship.death()
		reset_to_menu()
		
