extends Area2D

@export var powerup = 0
@onready var poweruptimer = $poweruptimer


func _on_body_entered(body):
	print("entered body")

	if body.is_in_group("player"):
		powerup = int(randi_range(0,2))#powerup code
		self.visible = false
		print("player hit",powerup)
		poweruptimer.start()
		var damage
		var speed
		if powerup==0:
			if body.current_health < body.max_health:
				body.current_health+=30
		if powerup ==1:
			
			speed =body.move_speed
			body.move_speed = 600
			
		if powerup==2:
			
			damage = body.damage
			body.damage=30
			
		if poweruptimer.is_stopped():
			body.move_speed=speed 
			body.damage = damage 
