extends Control

func _ready():
	$TimeValue.text = "%0.3f" % Global.lasttime
	$HighScoreValue.text = "%0.3f" % Global.highscore
	if Global.lasttime == Global.highscore:
		$NewHighScore.show()

func _on_RestartButton_pressed():
	Global.replay()

func _on_QuitButton_pressed():
	get_tree().change_scene("res://scenes/LevelSelect.tscn")
