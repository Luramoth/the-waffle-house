extends KinematicBody

class_name player

#---------------- editables -------------------
#walking
export var WALK_SPEED : int = 30
export var FRICTION : float = 0.2
export var ACCELERATION  : float = 0.2

#running
export var RUN_SPEED : int = 50

#gravity
export var GRAVITY : int = 150
export var MAX_SLOPE_ANGLE : float = 50.0

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

func _ready():
	# speed multipliers to accomodate for teh delta framreat de-capping
	WALK_SPEED *= 100
	RUN_SPEED *= 100
	GRAVITY *= 100

# function gets called every time the physics cycles
func _physics_process(delta):
	var direction : Vector3 = get_axis()
	var snap : Vector3 = Vector3.DOWN

	var SPEED : int

	# apply wether or not the paleyr is running
	if Input.is_action_pressed("run"):
		SPEED = RUN_SPEED
	else:
		SPEED = WALK_SPEED

	# apply some friction and acceleration
	if direction.length() > 0:
		velocity = lerp(velocity, direction.normalized() * SPEED, ACCELERATION)
	else:
		velocity = lerp(velocity, Vector3.ZERO, FRICTION)
	
	# apply gravity
	velocity.y -= GRAVITY * delta

	# do everything needed to move the player propor

	# PARAMETERS:
	#----------------------------------------------------------------
	# first paramerter is what direction the player needs to move
	#----------------------------------------------------------------
	# second is the snap, the makes it so the player will stick to slopes rather then bounce off them when stopping suddenly or gettign off them
	#----------------------------------------------------------------
	# third tells the game which direction up is
	#----------------------------------------------------------------
	# fourth is stop on slope, basically telling the game not to have the player constantly  slide down the slope
	#----------------------------------------------------------------
	# fifth is max slides, it tells the engine how many times the player can be shoved around before just saying to stop
	#----------------------------------------------------------------
	# sixth is the max slope angle for the game to consider a floor to be a floor and not a wall
	#----------------------------------------------------------------
	# seventh and last one is infinate inertia, it tells the engien wether or not the player is an unstoppable force in which no physics objects can contest
	# or in other words, wether or not physics objects can stop the player from moving
	velocity = move_and_slide_with_snap(velocity * delta, snap, Vector3.UP, true, 4, deg2rad(MAX_SLOPE_ANGLE), false)
