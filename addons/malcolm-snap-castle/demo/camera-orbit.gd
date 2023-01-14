extends Camera


export var distance = 100.0
export var height = 20.0
export var target = Vector3(0, 5, 0)


var time := 0.0


func _process(delta):
	time += delta

	global_translation = Vector3(sin(time / 6) * distance, height, cos(time / 6) * distance)
	look_at(target, Vector3.UP)
