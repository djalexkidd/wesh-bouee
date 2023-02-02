extends CanvasLayer

var time = 0
var running

func _ready():
	if Input.get_joy_name(0) and !Global.ForceTouchScreen:
		$Joystick.hide()
		$TouchScreenButton.hide()

func _process(delta):
	if running:
		time += delta
	$Time.text = "%0.3f" % time

func get_time():
	return time

func _on_Player_bar():
	$ProgressBar.value -= 2

func _on_Player_stopwatch():
	running = !running
