tool
class_name CastleDoor
extends Spatial


## Door opened signal
signal door_opened

## Door closed signal
signal door_closed


## Time taken to open or close the door
export var open_time : float = 1.0

## The angle the door swings by (can be positive or negative)
export var open_angle : float = 80.0

## Door opened state
export var opened : bool = false setget _set_opened

## Door enabled state
export var enabled : bool = true setget _set_enabled


# Tween for moving door
var _tween : SceneTreeTween

# Current angle
var _current_angle : float


# Called when the node enters the scene tree for the first time.
func _ready():
	# Perform initial updates
	_update_enabled()
	_update_opened(true)


# Called when the opened property is changed
func _set_opened(new_value : bool) -> void:
	# Save and update the value
	var old_opened := opened
	opened = new_value

	# Fire the changed event
	if opened and not old_opened:
		emit_signal("door_opened")
	elif not opened and old_opened:
		emit_signal("door_closed")

	# Update the state
	if is_inside_tree():
		_update_opened()


# Called when the enabled property is changed
func _set_enabled(new_value : bool) -> void:
	# Save and update the value
	enabled = new_value
	if is_inside_tree():
		_update_enabled()


# Called to update the opened state
func _update_opened(initial : bool = false) -> void:
	# Get the target angle
	var target : float = open_angle if opened else 0.0

	# Handle initial update
	if initial:
		_move_door(target)
		return

	# Kill existing tween
	if _tween:
		_tween.kill()

	# Launch tween to move door
	_tween = create_tween()
	_tween.set_ease(Tween.EASE_IN_OUT)
	_tween.set_trans(Tween.TRANS_QUAD)
	_tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	_tween.tween_method(self, "_move_door", _current_angle, target, open_time)


# Called to update the enabled state
func _update_enabled() -> void:
	$DoorBody.visible = enabled
	$DoorBody/CollisionShape.disabled = not enabled


# Called to move the door
func _move_door(angle : float) -> void:
	_current_angle = angle
	$DoorBody.rotation_degrees = Vector3(0.0, angle, 0.0)
