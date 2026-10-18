extends Node2D

export(float) var bronze_medal
export(float) var silver_medal
export(float) var gold_medal
export(float) var author_medal

# Separate medal targets for inclination controls; tunable per level.
export(float) var gyroscope_time_multiplier = 1.5

func medal_target(classic_time):
	return classic_time * gyroscope_time_multiplier if Global.is_gyroscope_active() else classic_time

func save_highscore():
	Global.save_scores()

func award_medals():
	if $HUD.time < medal_target(bronze_medal):
		Global.bronze_medals_owned[Global.level-1] = "true"
	
	if $HUD.time < medal_target(silver_medal):
		Global.silver_medals_owned[Global.level-1] = "true"
	
	if $HUD.time < medal_target(gold_medal):
		Global.gold_medals_owned[Global.level-1] = "true"
	
	if $HUD.time < medal_target(author_medal):
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
