extends Control

func _ready():
	RefreshWorld()

func select_level(slot):
	Global.level = (Global.world - 1) * Global.LEVELS_PER_WORLD + slot
	Global.replay()

func preview_level(slot):
	var index = (Global.world - 1) * Global.LEVELS_PER_WORLD + slot - 1
	$HighScoreValue.text = "%0.3f" % [str2var(Global.level_time[index])]
	LoadMedals(index)

func _on_Level1_pressed():
	select_level(1)

func _on_Level1_mouse_entered():
	preview_level(1)

func _on_Level2_pressed():
	select_level(2)

func _on_Level2_mouse_entered():
	preview_level(2)

func _on_Level3_pressed():
	select_level(3)

func _on_Level3_mouse_entered():
	preview_level(3)

func _on_Level4_pressed():
	select_level(4)

func _on_Level4_mouse_entered():
	preview_level(4)

func _on_Level5_pressed():
	select_level(5)

func _on_Level5_mouse_entered():
	preview_level(5)

func _on_Level6_pressed():
	select_level(6)

func _on_Level6_mouse_entered():
	preview_level(6)

func _on_Level7_pressed():
	select_level(7)

func _on_Level7_mouse_entered():
	preview_level(7)

func _on_Level8_pressed():
	select_level(8)

func _on_Level8_mouse_entered():
	preview_level(8)

func _on_ReturnButton_pressed():
	get_tree().change_scene("res://scenes/TitleScreen.tscn")

func _on_NextWorldButton_pressed():
	Global.world = min(Global.world + 1, Global.WORLD_COUNT)
	RefreshWorld()
	GlobalScene.update_bgm()

func _on_PreviousWorldButton_pressed():
	Global.world = max(Global.world - 1, 1)
	RefreshWorld()
	GlobalScene.update_bgm()

func RefreshWorld():
	for slot in range(1, Global.LEVELS_PER_WORLD + 1):
		var button = get_node("LevelsContainer/Level" + str(slot))
		button.text = str(Global.world) + "-" + str(slot)
		button.disabled = false
	$NextWorldButton.disabled = Global.world == Global.WORLD_COUNT
	$PreviousWorldButton.disabled = Global.world == 1
	preview_level(1)

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
