extends Node2D

export(float) var bronze_medal
export(float) var silver_medal
export(float) var gold_medal
export(float) var author_medal

func save_highscore():
	var config = ConfigFile.new()
	
	for n in Global.level_time.size():
		config.set_value("Scores", var2str(n), Global.level_time[n])
		config.set_value("Bronze Medals", var2str(n), Global.bronze_medals_owned[n])
		config.set_value("Silver Medals", var2str(n), Global.silver_medals_owned[n])
		config.set_value("Gold Medals", var2str(n), Global.gold_medals_owned[n])
		config.set_value("Author Medals", var2str(n), Global.author_medals_owned[n])
	
	config.save("user://scores.cfg")

func award_medals():
	if $HUD.time < bronze_medal:
		Global.bronze_medals_owned[Global.level-1] = "true"
	
	if $HUD.time < silver_medal:
		Global.silver_medals_owned[Global.level-1] = "true"
	
	if $HUD.time < gold_medal:
		Global.gold_medals_owned[Global.level-1] = "true"
	
	if $HUD.time < author_medal:
		Global.author_medals_owned[Global.level-1] = "true"

func _on_Player_stopwatch():
	if $HUD.time > 1 and $HUD.time < str2var(Global.level_time[Global.level-1]):
		GlobalScene.foo()
		Global.lasttime = $HUD.time
		Global.level_time[Global.level-1] = "%0.3f" % ($HUD.time)
		award_medals()
		save_highscore()
	elif $HUD.time > 1 and not $HUD.time < str2var(Global.level_time[Global.level-1]):
		GlobalScene.foo()
		Global.lasttime = $HUD.time
