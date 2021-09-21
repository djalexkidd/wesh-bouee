extends Control

func _ready():
	$TimeValue.text = "%0.3f" % Global.lasttime #Affiche le temps actuel
	$HighScoreValue.text = "%0.3f" % Global.highscore #Affiche le record
	if Global.lasttime == Global.highscore: #Affiche "Nouveau record" si le précédent est battu
		$NewHighScore.show()

func _on_RestartButton_pressed(): #Redémarre le niveau
	Global.replay()

func _on_QuitButton_pressed(): #Retourne à la sélection du niveau
	get_tree().change_scene("res://scenes/LevelSelect.tscn")
