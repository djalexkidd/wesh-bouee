extends Control

func _ready():
	$TimeValue.text = "%0.3f" % Global.lasttime #Affiche le temps actuel
	$HighScoreValue.text = "%0.3f" % str2var(Global.get_time()) #Affiche le record
	if str2var("%0.3f" % (Global.lasttime)) == str2var(Global.get_time()): #Affiche "Nouveau record" si le précédent est battu
		$NewHighScore.show()
	if Global.level == 8 or Global.level == 16:
		$VBoxContainer/NextButton.disabled = true
	LoadMedals()

func _on_NextButton_pressed(): #Démarre le niveau suivant
	Global.level += 1
	Global.replay()
	GlobalScene.bar()

func _on_RestartButton_pressed(): #Redémarre le niveau
	Global.replay()
	GlobalScene.bar()

func _on_QuitButton_pressed(): #Retourne à la sélection du niveau
	get_tree().change_scene("res://scenes/LevelSelect.tscn")
	GlobalScene.bar()

func LoadMedals():
	if Global.bronze_medals_owned[Global.level-1] == "true":
		$MedalsContainer/OwnedMedals/BronzeMedal.set_modulate(Color(1,1,1,1))
	else:
		$MedalsContainer/OwnedMedals/BronzeMedal.set_modulate(Color(1,1,1,0))
	
	if Global.silver_medals_owned[Global.level-1] == "true":
		$MedalsContainer/OwnedMedals/SilverMedal.set_modulate(Color(1,1,1,1))
	else:
		$MedalsContainer/OwnedMedals/SilverMedal.set_modulate(Color(1,1,1,0))
	
	if Global.gold_medals_owned[Global.level-1] == "true":
		$MedalsContainer/OwnedMedals/GoldMedal.set_modulate(Color(1,1,1,1))
	else:
		$MedalsContainer/OwnedMedals/GoldMedal.set_modulate(Color(1,1,1,0))
	
	if Global.author_medals_owned[Global.level-1] == "true":
		$MedalsContainer/OwnedMedals/AuthorMedal.set_modulate(Color(1,1,1,1))
	else:
		$MedalsContainer/OwnedMedals/AuthorMedal.set_modulate(Color(1,1,1,0))
