extends KinematicBody

#---------------- editables -------------------
export var SPEED : int = 20
export var FRICTION : float = 0.2
export var ACCELERATION  : float = 0.2

#---------------- no touchy -------------------
var velocity : Vector3

#---------------- functions -------------------
# grabs axis inputs from WASD or controller
func get_axis():
	var axis : Vector3 = Vector3.ZERO
	
	# up
	if Input.is_action_pressed("up"):
		axis.z += 1
	# down
	if Input.is_action_pressed("down"):
		axis.z -= 1
	# left
	if Input.is_action_pressed("left"):
		axis.x += 1
	# right
	if Input.is_action_pressed("right"):
		axis.x -= 1
	
	return axis

# function gets called every time the physics cycles
func _physics_process(_delta):
	var direction : Vector3 = get_axis()

	# apply some friction and acceleration
	if direction.length() > 0:
		velocity = lerp(velocity, direction.normalized() * SPEED, ACCELERATION)
	else:
		velocity = lerp(velocity, Vector3.ZERO, FRICTION)
	
	velocity = move_and_slide(velocity)
