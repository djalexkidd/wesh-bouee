extends Area2D

export(String, "current", "ice", "brake", "portal", "buoy") var kind = "current"
export(Vector2) var half_size = Vector2(168, 168)
export(Vector2) var force = Vector2(240, 0)
export(Vector2) var destination = Vector2.ZERO
export(String) var caption = ""
export(float) var tide_period = 0.0
var collected = false
var clock = 0.0

func _ready():
	collision_layer = 0
	collision_mask = 1
	var collider = CollisionShape2D.new()
	if kind == "portal" or kind == "buoy":
		var circle = CircleShape2D.new()
		circle.radius = 84 if kind == "portal" else 68
		collider.shape = circle
	else:
		var box = RectangleShape2D.new()
		box.extents = half_size
		collider.shape = box
	add_child(collider)
	if kind in ["current", "ice", "brake"]:
		add_to_group("race_terrain")
	connect("body_entered", self, "_on_entered")
	connect("body_exited", self, "_on_exited")
	z_index = -1 if kind in ["current", "ice", "brake"] else 1

func _process(delta):
	clock += delta
	update()

func _draw():
	var colors = {"current": Color(1, 0.25, 0.22), "ice": Color(0.4, 0.85, 1), "brake": Color(0.4, 1, 0.5), "portal": Color(0.95, 0.35, 1), "buoy": Color(1, 0.8, 0.15)}
	var color = colors[kind]
	if kind == "portal" or kind == "buoy":
		var radius = 84.0 if kind == "portal" else 68.0
		if collected:
			color = Color(0.35, 0.9, 0.5, 0.45)
		draw_circle(Vector2.ZERO, radius, Color(color.r, color.g, color.b, 0.16))
		draw_arc(Vector2.ZERO, radius, 0, TAU, 40, color, 7)
		draw_arc(Vector2.ZERO, radius * 0.65 + sin(clock * 3) * 5, clock, clock + PI * 1.6, 32, color, 5)
		if kind == "buoy":
			draw_circle(Vector2.ZERO, 18, color)
			if collected:
				draw_line(Vector2(-24, 0), Vector2(-5, 20), Color.white, 6)
				draw_line(Vector2(-5, 20), Vector2(28, -22), Color.white, 6)
		return
	var rect = Rect2(-half_size, half_size * 2)
	draw_rect(rect, Color(color.r, color.g, color.b, 0.15))
	draw_rect(rect, Color(color.r, color.g, color.b, 0.75), false, 4)
	for x in range(int(-half_size.x + 70), int(half_size.x), 140):
		for y in range(int(-half_size.y + 70), int(half_size.y), 140):
			var center = Vector2(x, y)
			if kind == "current":
				var angle = flow_force().angle()
				var offset = fmod(clock * 30, 30) - 15
				var tip = center + Vector2(26 + offset, 0).rotated(angle)
				draw_line(center + Vector2(-24 + offset, 0).rotated(angle), tip, color, 6)
				draw_line(tip, center + Vector2(5 + offset, -20).rotated(angle), color, 6)
				draw_line(tip, center + Vector2(5 + offset, 20).rotated(angle), color, 6)
			elif kind == "ice":
				for angle in [0, PI / 3, PI * 2 / 3]:
					var arm = Vector2(24, 0).rotated(angle)
					draw_line(center - arm, center + arm, color, 3)
			else:
				draw_line(center + Vector2(-15, -25), center + Vector2(-15, 25), color, 10)
				draw_line(center + Vector2(15, -25), center + Vector2(15, 25), color, 10)

func _on_entered(body):
	if not body.has_method("enter_terrain") or not body.control:
		return
	match kind:
		"portal":
			body.call_deferred("teleport_to", destination)
		"buoy":
			if not collected:
				collected = true
				get_parent().collect_buoy()
		_:
			body.enter_terrain(self)

func _on_exited(body):
	if body.has_method("exit_terrain"):
		body.exit_terrain(self)

func flow_force():
	return force if tide_period <= 0 else force * cos(clock * TAU / tide_period)
