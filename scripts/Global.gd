extends Node

var lasttime = 0 #Dernier temps
var level_time = {}
var level = 0 #Niveau actuel
var world = 1 #Monde actuel

func replay(): #Fonction pour faire changer/redémarrer le niveau
	get_tree().change_scene("res://scenes/levels/Level" + str(level) + ".tscn")

func get_time():
	return level_time[level-1]
