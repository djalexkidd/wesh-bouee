extends Control

func _ready():
	load_highscore()

func _on_StartButton_pressed(): #Bouton pour démarrer une partie
	get_tree().change_scene("res://scenes/LevelSelect.tscn")

func _on_QuitButton_pressed(): #Bouton pour quitter le jeu
	get_tree().quit()

#Cette fonction charge les meilleurs temps
#Sous GNU/Linux le fichier se situe dans /home/$USER/.local/share/godot/app_userdata/Wesh Bouée/
func load_highscore():
	var config = ConfigFile.new()
	config.load("user://scores.cfg")
	# Les anciennes sauvegardes contiennent seulement les 16 premiers niveaux.
	# Compléter les entrées manquantes sans écraser les records existants.
	for n in Global.LEVEL_COUNT:
		var key = var2str(n)
		Global.level_time[n] = config.get_value("Scores", key, "999.999")
		Global.bronze_medals_owned[n] = config.get_value("Bronze Medals", key, "false")
		Global.silver_medals_owned[n] = config.get_value("Silver Medals", key, "false")
		Global.gold_medals_owned[n] = config.get_value("Gold Medals", key, "false")
		Global.author_medals_owned[n] = config.get_value("Author Medals", key, "false")
		config.set_value("Scores", key, Global.level_time[n])
		config.set_value("Bronze Medals", key, Global.bronze_medals_owned[n])
		config.set_value("Silver Medals", key, Global.silver_medals_owned[n])
		config.set_value("Gold Medals", key, Global.gold_medals_owned[n])
		config.set_value("Author Medals", key, Global.author_medals_owned[n])
	config.save("user://scores.cfg")

func _on_SettingsButton_pressed():
	get_tree().change_scene("res://scenes/Settings.tscn")
