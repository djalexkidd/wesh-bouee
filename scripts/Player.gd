extends KinematicBody2D

var movedir = Vector2(0,0)
var SPEED = 360 #Vitesse du joueur
var health = 100 #Santé du joueur
var hurt
var start
var boosted
var gravity_enabled
var GRAVITY = 500
var rotate_speed = 0.01
var control = true
signal bar
signal stopwatch

export (NodePath) var joystickLeftPath
onready var joystickLeft : Joystick = get_node(joystickLeftPath)

func _physics_process(delta):
	movedir.x = -Input.get_action_strength("left") + Input.get_action_strength("right")
	movedir.y = +Input.get_action_strength("down") - Input.get_action_strength("up")
	
	movedir = movedir.clamped(1)
	
	var velocity = movedir * SPEED
	
	#Permet de changer la vitesse du joueur si le bouton A est maintenu
	if Input.is_action_pressed("run"):
		if !boosted:
			SPEED = 180
		else:
			SPEED = 720
	else:
		if !boosted:
			SPEED = 360
		else:
			SPEED = 720
	
	if Input.is_action_just_pressed("restart"):
		Global.replay()
	
	if Input.is_action_just_pressed("exit"):
		get_tree().change_scene("res://scenes/LevelSelect.tscn")
	
	if joystickLeft and joystickLeft.is_working and control:
		var _velocity = move_and_slide(joystickLeft.output * SPEED)
	
	if gravity_enabled:
		velocity.y = velocity.y + GRAVITY
	
	if control:
		velocity = move_and_slide(velocity)

	$Sprite.rotate(rotate_speed) #Fait tourner le sprite du joueur
	
	if hurt:
		health -= 2
		emit_signal("bar")
		set_modulate(Color(1,0.3,0.3)) #Change la couleur du sprite en rouge
		Input.start_joy_vibration(0,1,1,0.1)  #Fait vibrer la manette
		Input.vibrate_handheld() #Fait vibrer le téléphone
		if health == 0: #Si la vie du joueur tombe à 0
			get_tree().change_scene("res://scenes/GameOver.tscn") #Fait un Game Over

func _on_hitbox_body_entered(_body):
	if start:
		hurt = true

func _on_hitbox_body_exited(_body):
	hurt = false
	set_modulate(Color(1,1,1)) #Remet par défaut la couleur du sprite

func _on_Start_body_exited(_body): #Début de partie
	if !start: #Si le sprite n'est pas sorti de la zone de départ
		emit_signal("stopwatch") #Démarre un chronomètre
		start = true #Le joueur ne peut plus redémarrer le chronomètre

func _on_Goal_body_entered(_body): #Fin de partie
	emit_signal("stopwatch") #Arrête le chronomètre
	
	var tween = get_node("Tween")
	var destination = get_node("../Goal")
	tween.interpolate_property(self, "position", Vector2(position.x, position.y), Vector2(destination.position.x, destination.position.y), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	
	rotate_speed = 0.10
	control = false
	$FinishTimer.start()

func _on_Boost_body_entered(body):
	boosted = true
	$BoostTimer.start()

func _on_Gravity_body_entered(body):
	gravity_enabled = true
	GRAVITY = 500

func _on_Gravity_body_exited(body):
	gravity_enabled = false

func _on_BoostTimer_timeout():
	boosted = false

func _on_FinishTimer_timeout():
	get_tree().change_scene("res://scenes/Goal.tscn") #Affiche l'écran de victoire

func _on_AntiGravity_body_entered(body):
	gravity_enabled = true
	GRAVITY = -500
