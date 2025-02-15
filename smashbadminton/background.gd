extends TextureRect

func _ready():
	var screen_size = get_viewport_rect().size  # Get screen dimensions

	# Get original texture size
	var texture_size = texture.get_size()

	# Calculate the best scale to fit while maintaining aspect ratio
	var scale_factor = max(screen_size.x / texture_size.x, screen_size.y / texture_size.y)

	# Apply the scaling while maintaining aspect ratio
	size = texture_size * scale_factor
	position = (screen_size - size) / 2  # Center the image
