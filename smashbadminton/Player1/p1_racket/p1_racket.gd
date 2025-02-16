extends Area2D
signal hit

@export var speed = 800 # How fast racket moves in pixels/sec
var screen_size # Size of the game window
var swing = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size 
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("p1_hit"):
		swing = true
		$AnimatedSprite2D.play()
		$AnimatedSprite2D.animation = "swing"
	else:
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.animation = "default"

func start():
	$CollisionShape2D.disabled = false
