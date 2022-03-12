extends KinematicBody2D

var is_running = false
var game_end = false

var velocity = Vector2()
const SPEED = 35
const GRAVITY = 100

func _ready():
	pass

func _process(_delta):
	if game_end:
		return

	if is_running:
		velocity.x = SPEED

	velocity.y += GRAVITY
	velocity = move_and_slide(velocity, Vector2.UP)
	var slide_count = get_slide_count()
	if slide_count:
		var collision = get_slide_collision(slide_count - 1)
		var collider = collision.collider
		if collider and collider.name == "Mushroom":
			get_parent().end_game("PC")
		

func start_player_if_not():
	if is_running:
		return

	is_running = true
	game_end = false
	$PcPlayerAnimatedSprite.play("Run")
	
func stop_player():
	is_running = false
	game_end = true
	$PcPlayerAnimatedSprite.play("Idle")

func go_to_start_line():
	self.position = Vector2(125, 400)

