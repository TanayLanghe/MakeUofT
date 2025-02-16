extends CharacterBody2D

const SPEED = 800  # Movement speed
var p1Score = 0
var p2Score = 0

func _ready():
	await get_tree().process_frame
	get_window().mode = Window.MODE_FULLSCREEN
	var label = get_node("../Label")
	label.visible = false
	velocity.x =  -SPEED

func _physics_process(delta):
	var screen_size = get_viewport_rect().size
	if position.x >= screen_size.x - 47:
		velocity.x = 0
		velocity.y = 0
		hide()
		update_score("p1")
	if position.x <= 56:
		velocity.x = 0
		velocity.y = 0
		hide()
		update_score("p2")
	if position.y <= 132:
		velocity.y = 0
		velocity.x = 0
		hide()
		if position.x <= 1018:
			update_score("p1")
	if position.y >= screen_size.y - 134:
		velocity.y = 0
		velocity.x = 0
		hide()
		if position.x > 1018:
			update_score("p2")
		
	move_and_slide()
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y - 150)
	
func update_score(player : String):
	var label = get_node("../Label")
	if player == "p1":
		p1Score += 1
	elif player == "p2":
		p2Score += 1
	label.visible = true
	label.text = str(p1Score) + " : " + str(p2Score)
	position = Vector2(976, 500)
	await get_tree().create_timer(1.0).timeout
	label.visible = false
	if p1Score == 1 or p2Score == 1:
		game_end()
	show()

func game_end():
	var end = get_node("../GameEnd")
	var winner = get_node("../PlayerWin")
	if p1Score > p2Score:
		winner.text = "Player 1 Wins!!"
	elif p2Score > p1Score:
		winner.text = "Player 2 Wins!!"
	end.visible = true
	winner.visible = true
	Engine.time_scale = 0
	
