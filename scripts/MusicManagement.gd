extends Node2D

onready var temp = get_node("/root/GlobalScene/RaceMusic").get_playback_position()
var is_paused

func foo():
	temp = get_node("/root/GlobalScene/RaceMusic").get_playback_position()
	get_node("/root/GlobalScene/RaceMusic").stop()
	is_paused = true
	$Goal.play()

func bar():
	if is_paused:
		get_node("/root/GlobalScene/RaceMusic").play()
		get_node("/root/GlobalScene/RaceMusic").seek(temp)
		is_paused = false
