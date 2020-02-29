extends Node2D

export var speed = 2
var screen_size
var player_number
onready var body = $Body

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	if player_number == 1:
		get_node("Body/PlayerSprite/TextureRect").texture = load("res://Assets/Graphics/Players/playerredplaceholder.png")
	else:
		get_node("Body/PlayerSprite/TextureRect").texture = load("res://Assets/Graphics/Players/playerblueplaceholder.png")

func handle_WASD_keys(delta):
	var velocity = Vector2()  # The player's movement vector.

	if Input.is_key_pressed(KEY_D):
		velocity.x += 1
	if Input.is_key_pressed(KEY_A):
		velocity.x -= 1
	if Input.is_key_pressed(KEY_S):
		velocity.y += 1
	if Input.is_key_pressed(KEY_W):
		velocity.y -= 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	body.move_and_collide(velocity)
	#position += velocity * delta
	#position.x = clamp(position.x, 0, screen_size.x)
	#position.y = clamp(position.y, 0, screen_size.y)

func handle_Arrow_keys(delta):
	
	var velocity = Vector2()  # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	body.move_and_collide(velocity)
	#position += velocity * delta
	#position.x = clamp(position.x, 0, screen_size.x)
	#position.y = clamp(position.y, 0, screen_size.y)	
	
func _process(delta):
	if player_number == 1:
		handle_WASD_keys(delta)
	else:
		handle_Arrow_keys(delta)
		
func speedup(time):
	speed *= 2
	var timer = Timer.new()
	timer.one_shot = true
	timer.set_wait_time(time)
	timer.connect("timeout", self, "speeddown")
	add_child(timer)
	timer.start()
	
func speeddown():
	speed /= 2
