extends CharacterBody2D

@export var move_speed=40
@export var max_speed=200
@export var friction=50
@export var rotaion_sensitivity=1.9



@onready var canon_bullet = preload("res://bullets/bullet.tscn")

@onready var coldowntimer = $coldowntimer


@export var current_player = "1"

signal player_fired_bullet

func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	
	new_control(delta)




func new_control(delta):
	
	
	
	if current_player=="1":
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			shoot()
		
		
		var rotation_direction = Input.get_axis("ui_left","ui_right")
		var movement_direction = Input.is_action_pressed("ui_up")
		rotation += rotation_direction*rotaion_sensitivity*delta
		
		velocity  += transform.x*int(movement_direction)*move_speed*delta
		velocity.limit_length(max_speed)
	#velocity -= velocity.normalized()
		move_and_slide()

	if current_player=="2":
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
			shoot()
		var rotation_direction = Input.get_axis("left","right")
		var movement_direction = Input.is_action_pressed("up")
		rotation += rotation_direction*rotaion_sensitivity*delta
		velocity  += transform.x*int(movement_direction)*move_speed*delta
		velocity.limit_length(max_speed)
		#velocity -= velocity.normalized()
		move_and_slide()

func shoot():

	if(coldowntimer.is_stopped()):
			var bullet
			bullet = canon_bullet.instantiate()
			var bullet_angle_to_target = $position.global_rotation_degrees #bullet own rotation relative to the world
			var firing_pos = $position.global_position #global bullet spon position
			var firing_target_for_bullet = $position.position.rotated($position.global_rotation) #a vector pointing in the aiming direction rotated by its global rotation to aviod problems when reflecting the body or scaling it
			
			emit_signal("player_fired_bullet",bullet,bullet_angle_to_target,firing_pos,firing_target_for_bullet)
			print("signal emmited")
			coldowntimer.start()

func loos():
	$Ship_sprite.hide()
	$Label.show()
	$CollisionShape2D.queue_free()
	set_process(false)
	
