extends Control

func _on_RestartButton_pressed():
	Global.replay()

func _on_QuitButton_pressed():
	get_tree().change_scene("res://scenes/LevelSelect.tscn")
