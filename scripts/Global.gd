extends Node

var lasttime = 0 #Dernier temps
var level_time = {} #Meilleur temps sur les niveaux
var level = 0 #Niveau actuel
var world = 1 #Monde actuel
var bronze_medals_owned = {} #Medailles de bronze obtenues
var silver_medals_owned = {} #Medailles d'argent obtenues
var gold_medals_owned = {} #Medailles d'or obtenues
var author_medals_owned = {} #Medailles d'auteur obtenues

func replay(): #Fonction pour faire changer/redémarrer le niveau
	get_tree().change_scene("res://scenes/levels/Level" + str(level) + ".tscn")

func get_time():
	return level_time[level-1]
