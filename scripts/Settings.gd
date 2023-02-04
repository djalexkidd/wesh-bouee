extends Control

var reset = 11

func _ready():
	if OS.get_name() == "Android":
		$SettingsContainer/FullScreenButton.disabled = true
	else:
		$SettingsContainer/MiuiFixButton.disabled = true

	
	if OS.window_fullscreen:
		$SettingsContainer/FullScreenButton.text = "SETTINGS_ENABLED"
	else:
		$SettingsContainer/FullScreenButton.text = "SETTINGS_DISABLED"
	
	if Global.ForceTouchScreen:
		$SettingsContainer/MiuiFixButton.text = "SETTINGS_ENABLED"
	else:
		$SettingsContainer/MiuiFixButton.text = "SETTINGS_DISABLED"

#Active/Désactive le plein écran
func _on_FullScreenButton_pressed():
	if OS.window_fullscreen:
		OS.window_fullscreen = false
		$SettingsContainer/FullScreenButton.text = "SETTINGS_DISABLED"
	else:
		OS.window_fullscreen = true
		$SettingsContainer/FullScreenButton.text = "SETTINGS_ENABLED"

func _on_ReturnButton_pressed():
	get_tree().change_scene("res://scenes/TitleScreen.tscn")

func _on_ResetButton_pressed():
	reset -= 1
	$ResetContainer/ResetButton.text = str(reset)
	if reset == 0:
		var dir = Directory.new()
		dir.remove("user://scores.cfg")
		get_tree().change_scene("res://scenes/TitleScreen.tscn")

func _on_MiuiFixButton_pressed():
	if Global.ForceTouchScreen:
		Global.ForceTouchScreen = false
		$SettingsContainer/MiuiFixButton.text = "SETTINGS_DISABLED"
	else:
		Global.ForceTouchScreen = true
		$SettingsContainer/MiuiFixButton.text = "SETTINGS_ENABLED"
