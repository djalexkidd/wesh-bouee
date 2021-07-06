extends Control

func _ready():
	$TimeValue.text = "%0.3f" % Global.lasttime
	$HighScoreValue.text = "%0.3f" % Global.highscore

func _on_RestartButton_pressed():
	get_tree().change_scene("res://scenes/Game.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()
