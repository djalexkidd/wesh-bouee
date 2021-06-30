extends KinematicBody2D

var velocity = Vector2(0,0)
const SPEED = 180 #Vitesse du joueur

func _physics_process(delta):
	if Input.is_action_pressed("left"):
		velocity.x = -SPEED
	if Input.is_action_pressed("right"):
		velocity.x = SPEED
	if Input.is_action_pressed("up"):
		velocity.y = -SPEED
	if Input.is_action_pressed("down"):
		velocity.y = SPEED
	
	move_and_slide(velocity.normalized() * SPEED)
	
	velocity = Vector2(0,0)
