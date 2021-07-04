extends KinematicBody2D

var velocity = Vector2(0,0)
var SPEED = 180 #Vitesse du joueur
var health = 100
var hurt
var start
signal bar
signal stopwatch

func _physics_process(delta):
	if Input.is_action_pressed("left"):
		velocity.x = -SPEED
	if Input.is_action_pressed("right"):
		velocity.x = SPEED
	if Input.is_action_pressed("up"):
		velocity.y = -SPEED
	if Input.is_action_pressed("down"):
		velocity.y = SPEED
	
	if Input.is_action_pressed("run"):
		SPEED = 360
	else:
		SPEED = 180
	
	move_and_slide(velocity.normalized() * SPEED)
	
	velocity = Vector2(0,0)

	$Sprite.rotate(0.01)
	
	if hurt:
		health -= 1
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
