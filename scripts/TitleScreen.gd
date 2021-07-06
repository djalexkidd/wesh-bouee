extends Control

func _ready():
	load_highscore()

func _on_Button_pressed():
	get_tree().change_scene("res://scenes/Game.tscn")

func load_highscore():
	var save_file = File.new()
	if not save_file.file_exists("user://highscores.json"):
		return

	save_file.open("user://highscores.json", File.READ)
	var json_str = save_file.get_as_text()
	var game_data = JSON.parse(json_str).result
	$HighScoreValue.text = "%0.3f" % game_data.highscore
	Global.highscore = game_data.highscore
	save_file.close()

func _on_FullScreenButton_pressed():
	if OS.window_fullscreen:
		OS.window_fullscreen = false
	else:
		OS.window_fullscreen = true

func _on_NetworkButton_pressed():
	get_tree().change_scene("res://scenes/NetMain.tscn")
