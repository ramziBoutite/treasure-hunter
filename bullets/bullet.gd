extends Area2D



var target:Vector2

var speed = 200


var angle:float

@onready var delte_timer = $Timer

@export var damage :int = 5

func _ready():
	delte_timer.start()


func _physics_process(delta):

	position+=target.normalized()*speed


func set_direction(angle_to_target_vec,firing_position,target_vec):
	rotation_degrees=angle_to_target_vec
	global_position=firing_position
	target=target_vec





func _on_timer_timeout():
	queue_free()


func _on_body_entered(body):

	if body.is_in_group("player"):
		body.handel_health(damage)

