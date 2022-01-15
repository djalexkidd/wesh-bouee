extends Node2D

func save_highscore():
	var data = {
		"level1_time" : Global.level1_time,
		"level2_time" : Global.level2_time,
		"level3_time" : Global.level3_time,
		"level4_time" : Global.level4_time,
		"level5_time" : Global.level5_time,
		"level6_time" : $HUD.get_time(),
	}
	
	var save_file = File.new()
	save_file.open("user://highscores.json", File.WRITE)
	save_file.store_line(to_json(data))
	save_file.close()

func _on_Player_stopwatch():
	if $HUD.time > 1 and $HUD.time < Global.level6_time:
		GlobalScene.foo()
		Global.lasttime = $HUD.time
		Global.level6_time = $HUD.get_time()
		save_highscore()
	elif $HUD.time > 1 and not $HUD.time < Global.level6_time:
		GlobalScene.foo()
		Global.lasttime = $HUD.time
