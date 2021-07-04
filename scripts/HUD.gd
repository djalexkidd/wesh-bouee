extends CanvasLayer

var time = 0
var running

func _process(delta):
	if running:
		time += delta
	$Time.text = "%0.3f" % time

func _on_Player_bar():
	$ProgressBar.value -= 1

func _on_Player_stopwatch():
	running = !running