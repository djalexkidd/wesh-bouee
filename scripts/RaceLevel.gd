extends "res://scripts/Level1.gd"

export(int) var required_buoys = 0
var collected_buoys = 0

func _ready():
	update_objective()

func can_finish():
	return collected_buoys >= required_buoys

func collect_buoy():
	collected_buoys += 1
	update_objective()

func update_objective():
	$HUD/BuoyCount.visible = required_buoys > 0
	$HUD/BuoyCount.text = "Balises : " + str(collected_buoys) + "/" + str(required_buoys)
	$Goal.modulate = Color.white if can_finish() else Color(0.5, 0.5, 0.5, 0.65)
