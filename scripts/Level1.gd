extends Node2D

func save_highscore():
	var config = ConfigFile.new()
	
	for n in 12:
		config.set_value("Scores", var2str(n), Global.level_time[n])
	
	config.save("user://scores.cfg")

func _on_Player_stopwatch():
	if $HUD.time > 1 and $HUD.time < str2var(Global.level_time[Global.level-1]):
		GlobalScene.foo()
		Global.lasttime = $HUD.time
		Global.level_time[Global.level-1] = "%0.3f" % ($HUD.time)
		save_highscore()
	elif $HUD.time > 1 and not $HUD.time < str2var(Global.level_time[Global.level-1]):
		GlobalScene.foo()
		Global.lasttime = $HUD.time
