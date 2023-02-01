extends Control

func _ready():
	RefreshWorld()

func _on_Level1_pressed():
	match Global.world:
		1:
			Global.level = 1 #Change le niveau actuel vers le niveau 1
		2:
			Global.level = 9
	
	Global.replay() #Charge le niveau

func _on_Level2_pressed():
	match Global.world:
		1:
			Global.level = 2 #Change le niveau actuel vers le niveau 2
		2:
			Global.level = 10
	
	Global.replay() #Charge le niveau

func _on_Level3_pressed():
	match Global.world:
		1:
			Global.level = 3 #Change le niveau actuel vers le niveau 3
		2:
			Global.level = 11
	Global.replay() #Charge le niveau

func _on_Level4_pressed():
	match Global.world:
		1:
			Global.level = 4 #Change le niveau actuel vers le niveau 4
		2:
			Global.level = 12
	Global.replay() #Charge le niveau

func _on_Level5_pressed():
	match Global.world:
		1:
			Global.level = 5 #Change le niveau actuel vers le niveau 5
		2:
			Global.level = 13
	Global.replay() #Charge le niveau

func _on_Level6_pressed():
	match Global.world:
		1:
			Global.level = 6 #Change le niveau actuel vers le niveau 6
		2:
			Global.level = 14
	Global.replay() #Charge le niveau

func _on_Level7_pressed():
	match Global.world:
		1:
			Global.level = 7 #Change le niveau actuel vers le niveau 7
		2:
			Global.level = 15
	Global.replay() #Charge le niveau

func _on_Level8_pressed():
	match Global.world:
		1:
			Global.level = 8 #Change le niveau actuel vers le niveau 8
		2:
			Global.level = 16
	Global.replay() #Charge le niveau

func _on_Level1_mouse_entered():
	match Global.world:
		1:
			$HighScoreValue.text = "%0.3f" % [str2var(Global.level_time[0])]
			LoadMedals(0)
		2:
			$HighScoreValue.text = "%0.3f" % [str2var(Global.level_time[8])]
			LoadMedals(8)

func _on_Level2_mouse_entered():
	match Global.world:
		1:
			$HighScoreValue.text = "%0.3f" % [str2var(Global.level_time[1])]
			LoadMedals(1)
		2:
			$HighScoreValue.text = "%0.3f" % [str2var(Global.level_time[9])]
			LoadMedals(9)

func _on_Level3_mouse_entered():
	match Global.world:
		1:
			$HighScoreValue.text = "%0.3f" % [str2var(Global.level_time[2])]
			LoadMedals(2)
		2:
			$HighScoreValue.text = "%0.3f" % [str2var(Global.level_time[10])]
			LoadMedals(10)

func _on_Level4_mouse_entered():
	match Global.world:
		1:
			$HighScoreValue.text = "%0.3f" % [str2var(Global.level_time[3])]
			LoadMedals(3)
		2:
			$HighScoreValue.text = "%0.3f" % [str2var(Global.level_time[11])]
			LoadMedals(11)

func _on_Level5_mouse_entered():
	match Global.world:
		1:
			$HighScoreValue.text = "%0.3f" % [str2var(Global.level_time[4])]
			LoadMedals(4)
		2:
			$HighScoreValue.text = "%0.3f" % [str2var(Global.level_time[12])]
			LoadMedals(12)

func _on_Level6_mouse_entered():
	match Global.world:
		1:
			$HighScoreValue.text = "%0.3f" % [str2var(Global.level_time[5])]
			LoadMedals(5)
		2:
			$HighScoreValue.text = "%0.3f" % [str2var(Global.level_time[13])]
			LoadMedals(13)

func _on_Level7_mouse_entered():
	match Global.world:
		1:
			$HighScoreValue.text = "%0.3f" % [str2var(Global.level_time[6])]
			LoadMedals(6)
		2:
			$HighScoreValue.text = "%0.3f" % [str2var(Global.level_time[14])]
			LoadMedals(14)

func _on_Level8_mouse_entered():
	match Global.world:
		1:
			$HighScoreValue.text = "%0.3f" % [str2var(Global.level_time[7])]
			LoadMedals(7)
		2:
			$HighScoreValue.text = "%0.3f" % [str2var(Global.level_time[15])]
			LoadMedals(15)

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
		if Global.world > 2:
			button.disabled = true
		else:
			button.disabled = false
		i += 1
		x += 1
	
	if Global.world == 4:
		$NextWorldButton.disabled = true
	else:
		$NextWorldButton.disabled = false
	
	if Global.world == 1:
		$PreviousWorldButton.disabled = true
	else:
		$PreviousWorldButton.disabled = false

func LoadMedals(hovered):
	if Global.bronze_medals_owned[hovered] == "true":
		$MedalsContainer/OwnedMedals/BronzeMedal.set_modulate(Color(1,1,1,1))
	else:
		$MedalsContainer/OwnedMedals/BronzeMedal.set_modulate(Color(1,1,1,0))
	
	if Global.silver_medals_owned[hovered] == "true":
		$MedalsContainer/OwnedMedals/SilverMedal.set_modulate(Color(1,1,1,1))
	else:
		$MedalsContainer/OwnedMedals/SilverMedal.set_modulate(Color(1,1,1,0))
	
	if Global.gold_medals_owned[hovered] == "true":
		$MedalsContainer/OwnedMedals/GoldMedal.set_modulate(Color(1,1,1,1))
	else:
		$MedalsContainer/OwnedMedals/GoldMedal.set_modulate(Color(1,1,1,0))
	
	if Global.author_medals_owned[hovered] == "true":
		$MedalsContainer/OwnedMedals/AuthorMedal.set_modulate(Color(1,1,1,1))
	else:
		$MedalsContainer/OwnedMedals/AuthorMedal.set_modulate(Color(1,1,1,0))
