tool
class_name CastleSconce
extends Spatial


## Sconce lit state
export var lit : bool = false setget _set_lit

## Enable light source when lit
export var light_source : bool = false setget _set_light_source


# Called when the node enters the scene tree for the first time.
func _ready():
	# Perform initial updates
	_update_sconce()


# Called when the opened property is changed
func _set_lit(new_value : bool) -> void:
	# Save and update the state
	lit = new_value
	if is_inside_tree():
		_update_sconce()


func _set_light_source(new_value : bool) -> void:
	# Save and update the state
	light_source = new_value
	if is_inside_tree():
		_update_sconce()


# Called to update the opened state
func _update_sconce() -> void:
	$CPUParticles.emitting = lit
	$OmniLight.visible = lit and light_source
