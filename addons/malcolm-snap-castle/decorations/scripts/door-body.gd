class_name CastleDoorBody
extends KinematicBody


## Castle Door Body
##
## This script is the castle door body. This is usually found by RayCast or
## object collision.
##
## To control the door (move or disable), access the castle door object using
## the door variable.


## Parent door
onready var door : CastleDoor = get_parent()
