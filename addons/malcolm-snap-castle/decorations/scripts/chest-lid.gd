class_name CastleChestLid
extends KinematicBody


## Castle Chest Lid
##
## This script is the castle chest lid. This is usually found by RayCast or
## object collision.
##
## To control the chest, access the castle chest object using the chest variable.


## Parent chest
onready var chest : CastleChest = get_parent()
