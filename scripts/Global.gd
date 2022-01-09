extends Node

var lasttime = 0 #Dernier temps
var level1_time = 999.999 #Record Niveau 1
var level2_time = 999.999 #Record Niveau 2
var level3_time = 999.999 #Record Niveau 3
var level4_time = 999.999 #Record Niveau 4
var level = 0 #Niveau actuel

func replay(): #Fonction pour faire changer/redémarrer le niveau
	match level:
		1: #Niveau 1
			get_tree().change_scene("res://scenes/levels/Level1.tscn")
		2: #Niveau 2
			get_tree().change_scene("res://scenes/levels/Level2.tscn")

func get_time():
	match level:
		1:
			return level1_time
		2:
			return level2_time
		3:
			return level3_time
		4:
			return level4_time
