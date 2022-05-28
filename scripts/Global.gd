extends Node

var lasttime = 0 #Dernier temps
var level1_time = 999.999 #Record Niveau 1
var level2_time = 999.999 #Record Niveau 2
var level3_time = 999.999 #Record Niveau 3
var level4_time = 999.999 #Record Niveau 4
var level5_time = 999.999 #Record Niveau 5
var level6_time = 999.999 #Record Niveau 6
var level7_time = 999.999 #Record Niveau 7
var level8_time = 999.999 #Record Niveau 8
var level9_time = 999.999 #Record Niveau 9
var level10_time = 999.999 #Record Niveau 10
var level = 0 #Niveau actuel
var world = 1 #Monde actuel

func replay(): #Fonction pour faire changer/redémarrer le niveau
	get_tree().change_scene("res://scenes/levels/Level" + str(level) + ".tscn")

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
		5:
			return level5_time
		6:
			return level6_time
		7:
			return level7_time
		8:
			return level8_time
		9:
			return level9_time
		10:
			return level10_time
