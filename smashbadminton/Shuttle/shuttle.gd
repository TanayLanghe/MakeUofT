extends CharacterBody2D

const SPEED = 400  # Movement speed
var p1Score = 0
var p2Score = 0
var start = false

func _ready():
	await get_tree().process_frame
	get_window().mode = Window.MODE_FULLSCREEN
	var label = get_node("/root/Main/Label")  # Get parent (Main), then Label
	label.visible = false
	reset_play_state("p1")

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
	if velocity.x > 0:
		velocity.x = velocity.x - 1
	elif velocity.x < 0:
		velocity.x = velocity.x + 1
	elif velocity.x == 0 and start == true:
		velocity.y = 0
		velocity.x = 0
		hide()
		if position.x < 1018:
			update_score("p2")
		elif position.x > 1018:
			update_score("p1")
	move_and_slide()
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y - 150)
	
func update_score(player : String):
	start = false
	position = Vector2(1018, 500)
	var label = get_node("/root/Main/Label")# Get parent (Main), then Label
	if player == "p1":
		p1Score += 1
	elif player == "p2":
		p2Score += 1
	label.visible = true
	label.text = str(p1Score) + " : " + str(p2Score)
	await get_tree().create_timer(1.0).timeout
	label.visible = false
	if p1Score >= 5 or p2Score >= 5:
		game_end()
	else:
		reset_play_state(player)
	
func reset_play_state(player: String):
	var turn = get_node("../PlayersTurn")
	if player == "p1":
		turn.text = "Player 1's Turn!\n Press swing to serve!"
		turn.visible = true
		while true:
			await get_tree().process_frame  # Waits for the next frame
			if Input.is_action_just_pressed("ui_accept"):  # Checks every frame
				break
		turn.visible = false
		var rac1 = get_node("/root/Main/Player1/P1Racket")
		var pos = rac1.global_position
		position = Vector2(pos.x + 15, pos.y - 200)
		velocity.x = SPEED
		start = true
		
	if player == "p2":
		turn.text = "Player 2's Turn!\n Press swing to serve!"
		turn.visible = true
		while true:
			await get_tree().process_frame  # Waits for the next frame
			if Input.is_action_just_pressed("ui_accept"):  # Checks every frame
				break
		turn.visible = false
		var rac2 = get_node("/root/Main/Player2/P2Racket")
		var pos = rac2.global_position
		position = Vector2(pos.x - 100, pos.y)
		velocity.x = -SPEED
		start = true
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
	

func _on_p_1_racket_body_entered(body) -> void:
	randomize()
	start = true
	var rac1 = get_node("/root/Main/Player1/P1Racket")
	if body is CharacterBody2D and rac1.swing == true:
		var shift = randf_range(30, 100)
		body.velocity.x = SPEED
		if body.position.y >= 506:
			body.velocity.y = -shift
		if body.position.y < 506:
			body.velocity.y = shift
		rac1.swing = false
		

func _on_p_2_racket_body_entered(body) -> void:
	randomize()
	start = true
	var rac2 = get_node("/root/Main/Player2/P2Racket")
	if body is CharacterBody2D and rac2.swing == true:
		var shift = randf_range(30, 100)
		body.velocity.x = -SPEED
		if body.position.y >= 506:
			body.velocity.y = -shift
		if body.position.y < 506:
			body.velocity.y = shift
		rac2.swing = false
