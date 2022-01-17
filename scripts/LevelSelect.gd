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

func _on_Level7_pressed():
	Global.level = 7 #Change le niveau actuel vers le niveau 7
	Global.replay() #Charge le niveau

func _on_Level8_pressed():
	Global.level = 8 #Change le niveau actuel vers le niveau 8
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

func _on_Level7_mouse_entered():
	$HighScoreValue.text = "%0.3f" % Global.level7_time

func _on_Level8_mouse_entered():
	$HighScoreValue.text = "%0.3f" % Global.level8_time

func _on_ReturnButton_pressed():
	get_tree().change_scene("res://scenes/TitleScreen.tscn")

func _on_NextWorldButton_pressed():
	Global.world += 1
	RefreshWorld()

func _on_PreviousWorldButton_pressed():
	Global.world -= 1
	RefreshWorld()

func RefreshWorld():
	var i = 1
	var x = 1
	while i < 9:
		var button = get_node("LevelsContainer/Level" + str(i))
		button.text = str(Global.world) + "-" + str(x)
		if Global.world > 1:
			button.disabled = true
		else:
			button.disabled = false
		i += 1
		x += 1
	
	if Global.world == 8:
		$NextWorldButton.disabled = true
	else:
		$NextWorldButton.disabled = false
	
	if Global.world == 1:
		$PreviousWorldButton.disabled = true
	else:
		$PreviousWorldButton.disabled = false
