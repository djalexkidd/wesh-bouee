extends KinematicBody2D

var movedir = Vector2(0,0)
var SPEED = 180 #Vitesse du joueur
var health = 100
var hurt
var start
signal bar
signal stopwatch

export (NodePath) var joystickLeftPath
onready var joystickLeft : Joystick = get_node(joystickLeftPath)

func _physics_process(delta):
	movedir.x = -Input.get_action_strength("left") + Input.get_action_strength("right")
	movedir.y = +Input.get_action_strength("down") - Input.get_action_strength("up")
	
	movedir = movedir.clamped(1)
	
	var velocity = movedir * SPEED
	
	if Input.is_action_pressed("run"):
		SPEED = 360
	else:
		SPEED = 180
	
	if joystickLeft and joystickLeft.is_working:
		var _velocity = move_and_slide(joystickLeft.output * SPEED)
	
	move_and_slide(velocity.normalized() * SPEED)
	
	velocity = Vector2(0,0)

	$Sprite.rotate(0.01)
	
	if hurt:
		health -= 2
		emit_signal("bar")
		set_modulate(Color(1,0.3,0.3))
		if health == 0:
			get_tree().change_scene("res://scenes/TitleScreen.tscn")

func _on_hitbox_body_entered(body):
	if start:
		hurt = true

func _on_hitbox_body_exited(body):
	hurt = false
	set_modulate(Color(1,1,1))

func _on_Start_body_exited(body):
	if !start:
		emit_signal("stopwatch")
		start = true

func _on_Goal_body_entered(body):
	emit_signal("stopwatch")
	get_tree().change_scene("res://scenes/Goal.tscn")
