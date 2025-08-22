extends RigidBody2D

var dragging = false
var offset = Vector2.ZERO

@export var pages: Array[CompressedTexture2D]
@export var currentPage = 0

func _ready() -> void:
	currentPage = clamp(currentPage, 0, pages.size())
	$Sprite2D.texture = pages[currentPage]

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

func turnPageRight():
	if (currentPage >= pages.size() - 1):
		return
	currentPage+=1
	$Sprite2D.texture = pages[currentPage]
	if (currentPage == pages.size() -1):
		$Sprite2D/TurnPageRight/TurnIndicatorRight.visible = false

func turnPageLeft():
	if (currentPage <= 0):
		return
	currentPage-=1
	$Sprite2D.texture = pages[currentPage]
	if (currentPage == 0):
		$Sprite2D/TurnPageLeft/TurnIndicatorLeft.visible = false

func _on_turn_page_right_mouse_entered() -> void:
	$Sprite2D/TurnPageRight/TurnIndicatorRight.visible = true && currentPage < pages.size() - 1


func _on_turn_page_right_mouse_exited() -> void:
	$Sprite2D/TurnPageRight/TurnIndicatorRight.visible = false


func _on_turn_page_right_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event is InputEventMouseButton
		and event.button_index == MOUSE_BUTTON_LEFT
		and event.is_pressed()
	):
		turnPageRight()

func _on_turn_page_left_mouse_entered() -> void:
	$Sprite2D/TurnPageLeft/TurnIndicatorLeft.visible = true && currentPage > 0


func _on_turn_page_left_mouse_exited() -> void:
	$Sprite2D/TurnPageLeft/TurnIndicatorLeft.visible = false


func _on_turn_page_left_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event is InputEventMouseButton
		and event.button_index == MOUSE_BUTTON_LEFT
		and event.is_pressed()
	):
		turnPageLeft()
