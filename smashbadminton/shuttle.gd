extends Sprite2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2(200, 0)  # Move 200 px/sec to the right by default
	var screen_size = get_viewport_rect().size
	# Check boundaries
	# We'll use a known window size as an example (e.g., 800x600).
	# Adjust these numbers or detect the viewport size dynamically.
	
	
	if position.x < 0:
		position.x = 0
		velocity.x = -velocity.x   # Bounce (invert x-direction)

	if position.x > screen_size.x:
		position.x = screen_size.x
		velocity.x = -velocity.x   # Bounce
