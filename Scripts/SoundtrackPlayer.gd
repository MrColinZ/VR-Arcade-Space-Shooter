extends Node


class_name SOUNDTRACKPLAYER_CLASS

enum THEMES {
	MENU,
	INGAME
}

var TRACKS = {
	THEMES.MENU: [preload("res://Recources/Music/Calm Cosmos  Free Music [Royalty Free No Copyright].mp3")],
	THEMES.INGAME: [preload("res://Recources/Music/8-bit-air-fight-by_moodmode.mp3"),
	preload("res://Recources/Music/8-bit-arcade-mode-by_moodlmode.mp3"),
	preload("res://Recources/Music/cruising-down-8bit-lane-by Monument_music.mp3"),
	preload("res://Recources/Music/Kent-amp-REZ---Unreal-Supe.mp3"),
	preload("res://Recources/Music/One Cosmos  Royalty Free Sci-Fi Background Music (No Copyright).mp3")
	]
}

var current_theme: int = THEMES.MENU
var is_repeating: bool = true

@onready var streamPlayer: AudioStreamPlayer = $MusicPlayer 

func play_soundtrack(theme: int, repeat_themes: bool):
	if current_theme != theme or !streamPlayer.playing:
		is_repeating = false
		
		streamPlayer.stop()
		
		is_repeating = repeat_themes
		current_theme = theme
		
		var theme_tracks: Array = TRACKS[current_theme]
		if theme_tracks != []:
			streamPlayer.stream = theme_tracks[randi() % theme_tracks.size()]
			streamPlayer.play()
	
	
func replay_theme():
	randomize()
	var theme_tracks: Array = TRACKS[current_theme]
	streamPlayer.stream = theme_tracks[randi() % theme_tracks.size()]
	streamPlayer.play()

	
func _on_music_player_finished():
	if is_repeating:
		replay_theme()
