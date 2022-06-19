extends KinematicBody

class_name player

#---------------- editables -------------------
#walking
export var WALK_SPEED : int = 10
export var FRICTION : float = 0.2
export var ACCELERATION  : float = 0.2

#running
export var RUN_SPEED : int = 20

#---------------- no touchy -------------------
var velocity : Vector3

export var is_running : bool

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

	var SPEED : int

	is_running = Input.is_action_pressed("run")

	if is_running:
		SPEED = RUN_SPEED
	else:
		SPEED = WALK_SPEED

	# apply some friction and acceleration
	if direction.length() > 0:
		velocity = lerp(velocity, direction.normalized() * SPEED, ACCELERATION)
	else:
		velocity = lerp(velocity, Vector3.ZERO, FRICTION)
	
	velocity = move_and_slide(velocity)
