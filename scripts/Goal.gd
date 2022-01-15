extends Control

func _ready():
	$TimeValue.text = "%0.3f" % Global.lasttime #Affiche le temps actuel
	$HighScoreValue.text = "%0.3f" % Global.get_time() #Affiche le record
	if Global.lasttime == Global.get_time(): #Affiche "Nouveau record" si le précédent est battu
		$NewHighScore.show()

func _on_NextButton_pressed(): #Démarre le niveau suivant
	Global.level += 1
	Global.replay()

func _on_RestartButton_pressed(): #Redémarre le niveau
	Global.replay()
	GlobalScene.bar()

func _on_QuitButton_pressed(): #Retourne à la sélection du niveau
	get_tree().change_scene("res://scenes/LevelSelect.tscn")
	GlobalScene.bar()
