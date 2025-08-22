extends Node

@onready var book = $Base/ResearchArea/Book

var dragging = false
var click_radius = 32 # Size of the sprite.

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		print("Dragging detected: ", (event.position - book.global_position).length())
		if (event.position - book.global_position).length() < click_radius:
			# Start dragging if the click is on the sprite.
			if not dragging and event.pressed:
				print("START")
				dragging = true
		# Stop dragging if the button is released.
		if dragging and not event.pressed:
			print("STOP")
			dragging = false

	if event is InputEventMouseMotion and dragging:
		# While dragging, move the sprite with the mouse.
		book.global_position = event.position
