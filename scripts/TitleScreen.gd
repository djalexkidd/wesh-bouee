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
	var save_file = File.new()
	if not save_file.file_exists("user://highscores.json"):
		return #Ne fait rien si le fichier n'existe pas

	save_file.open("user://highscores.json", File.READ) #Ouvre le fichier
	var json_str = save_file.get_as_text()
	var game_data = JSON.parse(json_str).result
	Global.level1_time = game_data.level1_time #Met la 1ère ligne du fichier dans une variable "level1_time"
	Global.level2_time = game_data.level2_time #Met la 2ème ligne du fichier dans une variable "level2_time"
	Global.level3_time = game_data.level3_time #Met la 3ème ligne du fichier dans une variable "level3_time"
	Global.level4_time = game_data.level4_time #Met la 4ème ligne du fichier dans une variable "level4_time"
	Global.level5_time = game_data.level5_time #Met la 5ème ligne du fichier dans une variable "level5_time"
	Global.level6_time = game_data.level6_time #Met la 6ème ligne du fichier dans une variable "level6_time"
	Global.level7_time = game_data.level7_time
	Global.level8_time = game_data.level8_time
	Global.level9_time = game_data.level9_time
	Global.level10_time = game_data.level10_time
	Global.level11_time = game_data.level11_time
	Global.level12_time = game_data.level12_time
	save_file.close() #Ferme le fichier

#Active/Désactive le plein écran
func _on_FullScreenButton_pressed():
	if OS.window_fullscreen:
		OS.window_fullscreen = false
	else:
		OS.window_fullscreen = true
