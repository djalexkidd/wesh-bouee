extends Node

var lasttime = 0 #Dernier temps
var highscore = 999.999 #Record
var level = 0 #Niveau actuel

func replay(): #Fonction pour faire changer/redémarrer le niveau
	match level:
		1: #Niveau 1
			get_tree().change_scene("res://scenes/levels/Level1.tscn")
		2: #Niveau 2
			get_tree().change_scene("res://scenes/levels/Level2.tscn")
