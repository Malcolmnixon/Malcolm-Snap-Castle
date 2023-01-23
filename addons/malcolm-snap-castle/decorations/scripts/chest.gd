tool
class_name CastleChest
extends Spatial


## Chest opened signal
signal chest_opened

## Chest closed signal
signal chest_closed


## Time taken to open or close the chest
export var open_time : float = 1.0

## The angle the chest swings by (can be positive or negative)
export var open_angle : float = 120.0

## Chest opened state
export var opened : bool = false setget _set_opened


# Tween for moving chest
var _tween : SceneTreeTween

# Current angle
var _current_angle : float


# Called when the node enters the scene tree for the first time.
func _ready():
	# Perform initial updates
	_update_opened(true)


# Called when the opened property is changed
func _set_opened(new_value : bool) -> void:
	# Save and update the value
	opened = new_value
	if is_inside_tree():
		_update_opened()


# Called to update the opened state
func _update_opened(initial : bool = false) -> void:
	# Get the target angle
	var target : float = open_angle if opened else 0.0

	# Handle initial update
	if initial:
		_move_lid(target)
		return

	# Kill existing tween
	if _tween:
		_tween.kill()

	# Launch tween to move lid
	_tween = create_tween()
	_tween.set_ease(Tween.EASE_IN_OUT)
	_tween.set_trans(Tween.TRANS_QUAD)
	_tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	_tween.tween_method(self, "_move_lid", _current_angle, target, open_time)


# Called to move the door
func _move_lid(angle : float) -> void:
	_current_angle = angle
	$Lid.rotation_degrees = Vector3(0.0, 0.0, angle)
