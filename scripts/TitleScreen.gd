extends Control

func _ready():
	load_highscore()
	
	if OS.get_name() == "Android":
		$FullScreenButton.queue_free()

func _on_StartButton_pressed(): #Bouton pour démarrer une partie
	get_tree().change_scene("res://scenes/LevelSelect.tscn")

func _on_QuitButton_pressed(): #Bouton pour quitter le jeu
	get_tree().quit()

#Cette fonction charge les meilleurs temps
#Sous GNU/Linux le fichier se situe dans /home/$USER/.local/share/godot/app_userdata/Wesh Bouée/
func load_highscore():
	var config = ConfigFile.new()
	var file2Check = File.new()
	if not file2Check.file_exists("user://scores.cfg"):
		for n in 13:
			config.set_value("Scores", var2str(n), "999.999")
			Global.level_time[n] = "999.999"
		config.save("user://scores.cfg")
		return
	
	var err = config.load("user://scores.cfg")
	
	for n in config.get_sections():
		for score in 13:
			var level_score = config.get_value(n, var2str(score))
			Global.level_time[score] = level_score

#Active/Désactive le plein écran
func _on_FullScreenButton_pressed():
	if OS.window_fullscreen:
		OS.window_fullscreen = false
	else:
		OS.window_fullscreen = true
