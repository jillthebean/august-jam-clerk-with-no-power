extends RigidBody2D

var dragging = false
var offset = Vector2.ZERO

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		offset = event.position - self.global_position;
		
		if ($CollisionShape2D.shape.get_rect().has_point(offset)):
			# Start dragging if the click is on the sprite.
			if not dragging and event.pressed:
				dragging = true
		# Stop dragging if the button is released.
		if dragging and not event.pressed:
			dragging = false

	if event is InputEventMouseMotion and dragging:
		# While dragging, move the sprite with the mouse.
		self.move_and_collide(event.position - self.global_position - offset)
