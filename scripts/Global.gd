extends Node

var lasttime = 0
var highscore = 999.999
var level = 0

func replay(): #Fonction pour faire changer/redémarrer le niveau
	match level:
		1:
			get_tree().change_scene("res://scenes/levels/Level1.tscn")
		2:
			get_tree().change_scene("res://scenes/levels/Level2.tscn")
