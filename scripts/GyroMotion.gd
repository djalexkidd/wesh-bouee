extends Reference

# The gyro branch uses the accelerometer to measure the phone's inclination.
# Keep that input local to the player instead of changing world gravity.
const EARTH_GRAVITY = 9.8
const ACCELERATION = 3136.0
const DRAG = 2.0
const MAX_SPEED = 720.0
var velocity = Vector2.ZERO

func step(accelerometer, delta, boosted = false):
	var tilt = Vector2(accelerometer.x, -accelerometer.y) / EARTH_GRAVITY
	tilt = tilt.clamped(1.0)
	var boost_scale = 4.0 if boosted else 1.0
	velocity = (velocity + tilt * ACCELERATION * boost_scale * delta) / (1.0 + DRAG * delta)
	velocity = velocity.clamped(MAX_SPEED * boost_scale)
	return velocity
