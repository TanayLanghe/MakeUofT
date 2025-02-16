extends Area2D
signal hit

@export var speed = 800 # How fast player moves in pixels/sec
var screen_size # Size of the game window

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size 
	position = Vector2(1345, 360)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("p2move_right"):
		velocity.x += 1
	if Input.is_action_pressed("p2move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("p2move_down"):
		velocity.y += 1
	if Input.is_action_pressed("p2move_up"):
		velocity.y -= 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	position += velocity * delta
	position = position.clamp(Vector2(screen_size.x/2 + 75, 0), Vector2(screen_size.x - 240, screen_size.y - 330))
	
	if velocity.x != 0 || velocity.y != 0:
		$AnimatedSprite2D.animation = "walk"
	else: 
		$AnimatedSprite2D.animation = "default"

func start():
	$CollisionShape2D.disabled = false

func _on_body_entered(body: Node2D) -> void:
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
