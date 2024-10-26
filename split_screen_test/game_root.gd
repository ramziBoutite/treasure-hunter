extends Node


var calable = Callable(self,"set_bullet")

var Player2 = preload("res://player/Player.tscn")

func _ready():
	var world = $HBoxContainer/SubViewportContainer1/SubViewport.world_2d
	$HBoxContainer/SubViewportContainer2/SubViewport.world_2d=world
	
	var player2=Player2.instantiate()
	$HBoxContainer/SubViewportContainer2/SubViewport.add_child(player2)
	player2.current_player="2"
	player2.find_child("Ship_sprite").modulate = 
	player2.position = Vector2(500,200)
	
	for childe in $HBoxContainer/SubViewportContainer1/SubViewport/split_screen_map.get_children():
		print(childe)
		if childe.is_in_group("player"):
			print("player ")
			childe.connect("player_fired_bullet",calable)

	for childe in $HBoxContainer/SubViewportContainer2/SubViewport.get_children():
		print(childe)
		if childe.is_in_group("player"):
			print("player ")
			childe.connect("player_fired_bullet",calable)



func set_bullet(bullet,bulletrotation,firing_pos,target):
	$HBoxContainer/SubViewportContainer1/SubViewport/split_screen_map.add_child(bullet)
	bullet.set_direction(bulletrotation,firing_pos,target)
