extends CharacterBody2D

@export var maxspeed = 100000
@export var acceleration = 100000
@export var friction = 300
@onready var axis = Vector2.ZERO
func _physics_process(delta):
	move(delta) 
	
	
	
	
func get_input_axis():
	axis.x = int(Input.is_action_pressed("right"))-int(Input.is_action_pressed("left"))
	axis.y = int(Input.is_action_pressed("up"))-int(Input.is_action_pressed("down"))
	return axis.normalized()
	
	
	
func move(delta):
	if axis == Vector2.ZERO:
		apply_fric(delta*friction) #apply friction
	else:
		apply_accel(axis*acceleration*delta)#apply move
	move_and_slide()
func apply_fric(amount):
	if velocity.length() > amount :
		velocity -= velocity.normalized() * amount 
		pass
	else:
		velocity = Vector2.ZERO
		pass

func apply_accel(accel):
	velocity += accel
	velocity= velocity.limit_length(maxspeed)
