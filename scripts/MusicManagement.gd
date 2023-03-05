extends Node2D

onready var temp = get_node("/root/GlobalScene/RaceMusic").get_playback_position()
onready var temp2 = get_node("/root/GlobalScene/RaceMusic2").get_playback_position()
var is_paused

func foo():
	match Global.world:
		1:
			temp = get_node("/root/GlobalScene/RaceMusic").get_playback_position()
			get_node("/root/GlobalScene/RaceMusic").stop()
		2:
			temp2 = get_node("/root/GlobalScene/RaceMusic2").get_playback_position()
			get_node("/root/GlobalScene/RaceMusic2").stop()
	is_paused = true
	$Goal.play()

func bar():
	if is_paused:
		match Global.world:
			1:
				get_node("/root/GlobalScene/RaceMusic").play()
				get_node("/root/GlobalScene/RaceMusic").seek(temp)
			2:
				get_node("/root/GlobalScene/RaceMusic2").play()
				get_node("/root/GlobalScene/RaceMusic2").seek(temp2)
		is_paused = false

func update_bgm():
	match Global.world:
		1:
			temp = get_node("/root/GlobalScene/RaceMusic2").get_playback_position()
			get_node("/root/GlobalScene/RaceMusic2").stop()
			get_node("/root/GlobalScene/RaceMusic").play()
			get_node("/root/GlobalScene/RaceMusic").seek(temp)
		2:
			temp = get_node("/root/GlobalScene/RaceMusic").get_playback_position()
			get_node("/root/GlobalScene/RaceMusic").stop()
			get_node("/root/GlobalScene/RaceMusic2").play()
			get_node("/root/GlobalScene/RaceMusic2").seek(temp2)
