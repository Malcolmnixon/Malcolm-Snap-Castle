tool
class_name CastleSconce
extends Spatial


## Sconce lit state
export var lit : bool = false setget _set_lit


# Called when the node enters the scene tree for the first time.
func _ready():
	# Perform initial updates
	_update_lit()


# Called when the opened property is changed
func _set_lit(new_value : bool) -> void:
	# Save and update the value
	lit = new_value
	if is_inside_tree():
		_update_lit()


# Called to update the opened state
func _update_lit() -> void:
	$OmniLight.visible = lit
	$CPUParticles.emitting = lit
