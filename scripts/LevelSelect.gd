extends Control

func _on_Level1_pressed():
	Global.level = 1 #Change le niveau actuel vers le niveau 1
	Global.replay() #Charge le niveau

func _on_Level2_pressed():
	Global.level = 2 #Change le niveau actuel vers le niveau 2
	Global.replay() #Charge le niveau

func _on_Level1_mouse_entered():
	$HighScoreValue.text = "%0.3f" % Global.highscore

func _on_Level2_mouse_entered():
	$HighScoreValue.text = "test"
