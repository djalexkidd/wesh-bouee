extends Control

func _on_Level1_pressed():
	Global.level = 1 #Change le niveau actuel vers le niveau 1
	Global.replay() #Charge le niveau

func _on_Level2_pressed():
	Global.level = 2 #Change le niveau actuel vers le niveau 2
	Global.replay() #Charge le niveau

func _on_Level3_pressed():
	Global.level = 3 #Change le niveau actuel vers le niveau 3
	Global.replay() #Charge le niveau

func _on_Level4_pressed():
	Global.level = 4 #Change le niveau actuel vers le niveau 4
	Global.replay() #Charge le niveau

func _on_Level5_pressed():
	Global.level = 5 #Change le niveau actuel vers le niveau 5
	Global.replay() #Charge le niveau

func _on_Level6_pressed():
	Global.level = 6 #Change le niveau actuel vers le niveau 6
	Global.replay() #Charge le niveau

func _on_Level1_mouse_entered():
	$HighScoreValue.text = "%0.3f" % Global.level1_time

func _on_Level2_mouse_entered():
	$HighScoreValue.text = "%0.3f" % Global.level2_time

func _on_Level3_mouse_entered():
	$HighScoreValue.text = "%0.3f" % Global.level3_time

func _on_Level4_mouse_entered():
	$HighScoreValue.text = "%0.3f" % Global.level4_time

func _on_Level5_mouse_entered():
	$HighScoreValue.text = "%0.3f" % Global.level5_time

func _on_Level6_mouse_entered():
	$HighScoreValue.text = "%0.3f" % Global.level6_time

func _on_ReturnButton_pressed():
	get_tree().change_scene("res://scenes/TitleScreen.tscn")
