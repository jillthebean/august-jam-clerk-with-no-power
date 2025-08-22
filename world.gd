extends Node

@onready var book: RigidBody2D = $Base/ResearchArea/Book

var dragging = false
var click_radius = 32 # Size of the sprite.

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		print("Dragging detected: ", (event.position - book.global_position).length())
		if (event.position - book.global_position).length() < click_radius:
			# Start dragging if the click is on the sprite.
			if not dragging and event.pressed:
				dragging = true
		# Stop dragging if the button is released.
		if dragging and not event.pressed:
			dragging = false

	if event is InputEventMouseMotion and dragging:
		# While dragging, move the sprite with the mouse.
		book.move_and_collide(event.position - book.global_position)
