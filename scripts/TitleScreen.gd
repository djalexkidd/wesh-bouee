extends Control

const nbr_levels = 16

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
		for n in nbr_levels:
			config.set_value("Scores", var2str(n), "999.999")
			Global.level_time[n] = "999.999"
			
			config.set_value("Bronze Medals", var2str(n), "false")
			Global.bronze_medals_owned[n] = "false"
			
			config.set_value("Silver Medals", var2str(n), "false")
			Global.silver_medals_owned[n] = "false"
			
			config.set_value("Gold Medals", var2str(n), "false")
			Global.gold_medals_owned[n] = "false"
			
			config.set_value("Author Medals", var2str(n), "false")
			Global.author_medals_owned[n] = "false"
		config.save("user://scores.cfg")
		return
	
	config.load("user://scores.cfg")
	
	for n in config.get_sections():
		if n == "Scores":
			for score in nbr_levels:
				var level_score = config.get_value(n, var2str(score))
				Global.level_time[score] = level_score
		elif n == "Bronze Medals":
			for bronze in nbr_levels:
				var bmedal = config.get_value(n, var2str(bronze))
				Global.bronze_medals_owned[bronze] = bmedal
		elif n == "Silver Medals":
			for silver in nbr_levels:
				var smedal = config.get_value(n, var2str(silver))
				Global.silver_medals_owned[silver] = smedal
		elif n == "Gold Medals":
			for gold in nbr_levels:
				var gmedal = config.get_value(n, var2str(gold))
				Global.gold_medals_owned[gold] = gmedal
		elif n == "Author Medals":
			for author in nbr_levels:
				var amedal = config.get_value(n, var2str(author))
				Global.author_medals_owned[author] = amedal

#Active/Désactive le plein écran
func _on_FullScreenButton_pressed():
	if OS.window_fullscreen:
		OS.window_fullscreen = false
	else:
		OS.window_fullscreen = true
