extends KinematicBody2D

var last_foot = -1 # 0 is left and 1 is right.
var is_running = false
var last_is_running = null
var game_end = true

var velocity = Vector2()
const SPEED = 40
const GRAVITY = 100
var last_move = OS.get_unix_time()

func _ready():
	pass

func _process(_delta):
	if game_end:
		return
	var now = OS.get_unix_time()
	if Input.is_action_just_pressed("ui_right") and (last_foot == 0 or last_foot == -1):
		is_running = true
		last_foot = 1
		last_move = now
	elif Input.is_action_just_pressed("ui_right") and last_foot == 1:
		is_running = false
		last_move = now
	elif Input.is_action_just_pressed("ui_left") and (last_foot == 1 or last_foot == -1):
		is_running = true
		last_foot = 0
		last_move = now
	elif Input.is_action_just_pressed("ui_left") and last_foot == 0:
		is_running = false
		last_move = now
	else:
		if now - last_move >= 1.1:
			is_running = false

	velocity.y += GRAVITY
	velocity.x = SPEED * (1 if is_running else 0)
	velocity = move_and_slide(velocity, Vector2.UP)
	var slide_count = get_slide_count()
	if slide_count:
		var collision = get_slide_collision(slide_count - 1)
		var collider = collision.collider
		if collider and collider.name == "Mushroom":
			get_parent().end_game("User")
	update_animation()
	
func update_animation():
	if last_is_running != null and is_running == last_is_running:
		return
	last_is_running = is_running

	if is_running:
		$PlayerAnimatedSprite.play("Run")
	else:
		$PlayerAnimatedSprite.play("Idle")
			
func stop_player():
	game_end = true
	$PlayerAnimatedSprite.play("Idle")
	
func start_game():
	game_end = false
	is_running = false
	last_is_running = null
	last_foot = -1
	
func go_to_start_line():
	self.position = Vector2(125, 400)
	
	
