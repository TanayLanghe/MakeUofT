extends CharacterBody2D

const SPEED = 800  # Movement speed
var screen_width = 0  # Will be set dynamically

func _ready():
	await get_tree().process_frame
	get_window().mode = Window.MODE_FULLSCREEN


func _physics_process(delta):
	var screen_size = get_viewport_rect().size
	# Get movement input (left and right)
	var direction = Input.get_axis("ui_left", "ui_right")
	var vert_direction = Input.get_axis("ui_up", "ui_down")
	if direction:
		velocity.x = direction * SPEED  # Move left or right
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)  # Smooth stopping
	if vert_direction:
		velocity.y = vert_direction * SPEED  # Move left or right
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	
	move_and_slide()
	position.x = clamp(position.x, -30, screen_size.x)
	position.y = clamp(position.y, 30, screen_size.y+50)
	
