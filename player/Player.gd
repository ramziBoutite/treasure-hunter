extends CharacterBody2D


@export var move_speed=400

@export var rotaion_sensitivity=5


@onready var canon_bullet = preload("res://bullets/bullet.tscn")

@onready var coldowntimer = $coldowntimer


var max_health = 100
var current_health = max_health


@export var current_player = "1"

signal player_fired_bullet

func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	
	new_control(delta)




func new_control(delta):
	
	
	
	if current_player=="1":
		if Input.is_action_just_pressed("fire player one"):
			shoot()
		
		
		var rotation_direction = Input.get_axis("ui_left","ui_right")

		var movement_direction = abs(Input.get_axis("ui_down","ui_up"))
		rotation += rotation_direction*rotaion_sensitivity*delta
		velocity  = transform.x*movement_direction*move_speed

		move_and_slide()

	if current_player=="2":
		if Input.is_action_just_pressed("fire player two"):
			shoot()
		var rotation_direction = Input.get_axis("left","right")

		var movement_direction = abs(Input.get_axis("down","up"))
		rotation += rotation_direction*rotaion_sensitivity*delta
		velocity  = transform.x*movement_direction*move_speed

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


func handel_health(damage):
	if current_health<=5:
		loos()
	else:
		current_health-=damage
		$UX/progress_bar.value=current_health

func loos():
	rotation_degrees=0
	$Ship_sprite.hide()
	$UX.hide()
	$Label.show()
	$CollisionShape2D.queue_free()
	set_physics_process(false)



