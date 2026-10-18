extends Node

const LEVELS_PER_WORLD = 8
const WORLD_COUNT = 4
const LEVEL_COUNT = LEVELS_PER_WORLD * WORLD_COUNT

var lasttime = 0 #Dernier temps
var level_time = {} #Meilleur temps sur les niveaux
var level = 0 #Niveau actuel
var world = 1 #Monde actuel
var bronze_medals_owned = {} #Medailles de bronze obtenues
var silver_medals_owned = {} #Medailles d'argent obtenues
var gold_medals_owned = {} #Medailles d'or obtenues
var author_medals_owned = {} #Medailles d'auteur obtenues

#Paramètres
var ForceTouchScreen = false
var gyroscope_enabled = false

const SCORE_SECTIONS = ["Scores", "Bronze Medals", "Silver Medals", "Gold Medals", "Author Medals"]

func _ready():
	var settings = ConfigFile.new()
	settings.load("user://settings.cfg")
	gyroscope_enabled = settings.get_value("Controls", "Gyroscope", false) == true
	load_scores()

func is_android():
	return OS.get_name() == "Android"

func is_gyroscope_active():
	return is_android() and gyroscope_enabled

func save_settings():
	var settings = ConfigFile.new()
	settings.load("user://settings.cfg")
	settings.set_value("Controls", "Gyroscope", gyroscope_enabled)
	settings.save("user://settings.cfg")

func set_gyroscope_enabled(enabled):
	gyroscope_enabled = enabled and is_android()
	save_settings()
	load_scores()

func score_section(section):
	return "Gyroscope " + section if is_gyroscope_active() else section

func score_tables():
	return [level_time, bronze_medals_owned, silver_medals_owned, gold_medals_owned, author_medals_owned]

func load_scores():
	var config = ConfigFile.new()
	config.load("user://scores.cfg")
	var tables = score_tables()
	# Keep the original sections for classic controls and add gyro sections.
	# Loading either mode also completes old saves without copying their medals.
	for prefix in ["", "Gyroscope "]:
		for i in range(SCORE_SECTIONS.size()):
			var section = prefix + SCORE_SECTIONS[i]
			for n in range(LEVEL_COUNT):
				var key = str(n)
				var value = config.get_value(section, key, "999.999" if i == 0 else "false")
				config.set_value(section, key, value)
				if section == score_section(SCORE_SECTIONS[i]):
					tables[i][n] = value
	config.save("user://scores.cfg")

func save_scores():
	var config = ConfigFile.new()
	config.load("user://scores.cfg")
	var tables = score_tables()
	for i in range(SCORE_SECTIONS.size()):
		for n in range(LEVEL_COUNT):
			config.set_value(score_section(SCORE_SECTIONS[i]), str(n), tables[i][n])
	config.save("user://scores.cfg")

func replay(): #Fonction pour faire changer/redémarrer le niveau
	get_tree().change_scene("res://scenes/levels/Level" + str(level) + ".tscn")

func get_time():
	return level_time[level-1]
