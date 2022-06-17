extends KinematicBody

export var speed : int = 20
var velocity : Vector3 = Vector3.ZERO

func input_handler():
	velocity = Vector3.ZERO
	
	# up
	if Input.is_action_pressed("up"):
		velocity.z += 1
	# down
	if Input.is_action_pressed("down"):
		velocity.z -= 1
	# left
	if Input.is_action_pressed("left"):
		velocity.x += 1
	# right
	if Input.is_action_pressed("right"):
		velocity.x -= 1
	# normalise velocity
	velocity = velocity.normalized() * speed

func _physics_process(_delta):
	input_handler()
	velocity = move_and_slide(velocity)
