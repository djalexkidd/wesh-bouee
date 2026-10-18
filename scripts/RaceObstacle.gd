extends KinematicBody2D

export(Vector2) var half_size = Vector2(28, 140)
export(Vector2) var travel = Vector2.ZERO
export(float) var period = 3.5
export(float) var phase = 0.0
export(float) var spin = 0.0
var origin = Vector2.ZERO
var elapsed = 0.0
var tire = preload("res://assets/tiles/tires_red.png")

func _ready():
	origin = position
	collision_layer = 2
	collision_mask = 0
	var collider = CollisionShape2D.new()
	var shape = RectangleShape2D.new()
	shape.extents = half_size
	collider.shape = shape
	add_child(collider)

func _physics_process(delta):
	elapsed += delta
	position = origin + travel * sin(elapsed * TAU / period + phase)
	rotation = spin * elapsed
	update()

func _draw():
	# Same tires as the static walls, with a bright core to show moving parts.
	for x in range(int(-half_size.x), int(half_size.x), 56):
		for y in range(int(-half_size.y), int(half_size.y), 56):
			draw_texture_rect(tire, Rect2(x, y, 56, 56), false)
	draw_line(Vector2(-half_size.x + 8, 0), Vector2(half_size.x - 8, 0), Color(1, 0.75, 0.3), 6)
	draw_circle(Vector2.ZERO, 13, Color(1, 0.85, 0.3))
