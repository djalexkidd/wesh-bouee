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

# Standalone physics avoids Godot 3 invoking both inherited frame callbacks.
# Used only by worlds 3 and 4. The original sixteen levels keep Player.gd.
var terrain = {}
var drift = Vector2.ZERO
var portal_cooldown = 0.0

func _physics_process(delta):
	portal_cooldown = max(0.0, portal_cooldown - delta)
	if Input.is_action_just_pressed("restart"):
		Global.replay()
		return
	if Input.is_action_just_pressed("exit"):
		get_tree().change_scene("res://scenes/LevelSelect.tscn")
		return
	$Sprite.rotate(rotate_speed)
	if not control:
		return
	movedir = Vector2(Input.get_action_strength("right") - Input.get_action_strength("left"), Input.get_action_strength("down") - Input.get_action_strength("up")).clamped(1)
	if joystickLeft and joystickLeft.is_working:
		movedir = joystickLeft.output.clamped(1)
	var current = Vector2.ZERO
	var on_ice = false
	var braking = false
	for zone in terrain.values():
		if not is_instance_valid(zone):
			continue
		match zone.kind:
			"current":
				current += zone.flow_force()
			"ice":
				on_ice = true
			"brake":
				braking = true
	var slow = Input.is_action_pressed("run")
	SPEED = 720 if boosted else (180 if slow else 360)
	if on_ice and slow:
		SPEED = 180
	if braking:
		SPEED = 200
	var target = movedir * SPEED
	if on_ice and not braking:
		drift = drift.move_toward(target, (1000.0 if slow else 230.0) * delta)
	else:
		drift = target
	var velocity = drift + current
	if gravity_enabled:
		velocity.y += GRAVITY
	var actual = move_and_slide(velocity)
	# Do not keep accumulating momentum into a wall on ice.
	drift = actual - current
	hurt = start and $hitbox.get_overlapping_bodies().size() > 0
	if hurt:
		health = max(0, health - 2)
		emit_signal("bar")
		modulate = Color(1, 0.3, 0.3)
		if health == 0:
			get_tree().change_scene("res://scenes/GameOver.tscn")
	else:
		modulate = Color.white

func enter_terrain(zone):
	terrain[zone.get_instance_id()] = zone
	if zone.kind == "brake":
		boosted = false
		$BoostTimer.stop()
		drift *= 0.35

func exit_terrain(zone):
	terrain.erase(zone.get_instance_id())

func teleport_to(destination):
	if portal_cooldown > 0 or not control:
		return
	portal_cooldown = 0.8
	global_position = destination
	drift = Vector2.ZERO
	terrain.clear()
	# Rebuild areas after the physics server updates the new position.
	call_deferred("refresh_terrain")
	$Camera2D.reset_smoothing()

func refresh_terrain():
	for zone in get_tree().get_nodes_in_group("race_terrain"):
		if zone.get_parent() == get_parent() and zone.overlaps_body(self):
			enter_terrain(zone)

func _on_Goal_body_entered(body):
	if body != self or not control:
		return
	if not get_parent().can_finish():
		return
	emit_signal("stopwatch") #Arrête le chronomètre
	
	var tween = get_node("Tween")
	var destination = get_node("../Goal")
	tween.interpolate_property(self, "position", Vector2(position.x, position.y), Vector2(destination.position.x, destination.position.y), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	
	rotate_speed = 0.10
	control = false
	$FinishTimer.start()


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
