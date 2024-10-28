extends Area2D





func _on_body_entered(body):
	print("entered body")
	
	if body.is_in_group("player"):
		self.visible = false
		print("player hit")
