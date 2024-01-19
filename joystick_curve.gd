extends CharacterBody2D


@export var MAX_SPEED := 100000
@export var ACCELERATION := 100000
@export var FRICTION := 1000
@export var e := 0.3 # joystick curve

@onready var axis = Vector2.ZERO


func _physics_process(delta):
	move(delta)


func get_input_axis():
	var left =  apply_joystick_curve( Input.get_action_strength("move_left") )
	var right = apply_joystick_curve( Input.get_action_strength("move_right") )
	var up =    apply_joystick_curve( Input.get_action_strength("move_up") )
	var down =  apply_joystick_curve( Input.get_action_strength("move_down") )
	#print("left: ", left, ", right: ", right, ", up: ", up, ", down: ", down)
	var horizontal = right - left
	var vertical = down - up
	
	return Vector2(horizontal ,vertical)


func apply_joystick_curve(x):
	return e * x ** 3 / (1 - e) * x


func move(delta):
	axis = get_input_axis()
	print("axis.x: ", axis.x, ", axis.y: ", axis.y)
	
	if axis == Vector2.ZERO:
		apply_friction(FRICTION * delta)
	else:
		apply_movement(axis * ACCELERATION * delta)
		
	move_and_slide()


func apply_friction(amount):
	if velocity.length() > amount:
		velocity -= velocity.normalized() * amount
	else:
		velocity = Vector2.ZERO
	
	
func apply_movement(accel):
	velocity = accel
	velocity = velocity.limit_length(MAX_SPEED)
