extends Node2D

func save_highscore():
	var data = {
		"highscore" : $HUD.get_time()
	}
	
	var save_file = File.new()
	save_file.open("user://highscores.json", File.WRITE)
	save_file.store_line(to_json(data))
	save_file.close()

func _on_Player_stopwatch():
	if $HUD.time > 1 and $HUD.time < Global.highscore:
		save_highscore()
