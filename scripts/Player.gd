extends RigidBody2D

var movedir = Vector2(0,0)
var SPEED = 180 #Vitesse du joueur
var health = 100 #Santé du joueur
var hurt
var start
var gravity_enabled
const GRAVITY = 500
var rotate_speed = 0.01
var control = true
const EARTH_GRAVITY = 9.8
signal bar
signal stopwatch

export (NodePath) var joystickLeftPath
onready var joystickLeft : Joystick = get_node(joystickLeftPath)

# Called when the node enters the scene tree for the first time.
func _ready():
	var gravity_strength = Physics2DServer.area_get_param(get_viewport().find_world_2d().get_space(), Physics2DServer.AREA_PARAM_GRAVITY)

func _physics_process(delta):
	var accel = Input.get_accelerometer()
	if accel and control:
		#print(accel)
		var gravity_vector = Vector2(accel.x/EARTH_GRAVITY, -accel.y/EARTH_GRAVITY)
		Physics2DServer.area_set_param(get_viewport().find_world_2d().get_space(), Physics2DServer.AREA_PARAM_GRAVITY_VECTOR, gravity_vector)

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
	gravity_scale = 128
	$BoostTimer.start()

func _on_Gravity_body_entered(body):
	gravity_enabled = true

func _on_Gravity_body_exited(body):
	gravity_enabled = false

func _on_BoostTimer_timeout():
	gravity_scale = 32

func _on_FinishTimer_timeout():
	get_tree().change_scene("res://scenes/Goal.tscn") #Affiche l'écran de victoire
