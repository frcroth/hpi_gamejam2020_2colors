extends Node2D

export var speed = 2
var screen_size
var player_number
var current_color
var colorstreak_active
onready var body = $Body

var foo = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	if player_number == 1:
		get_node("Body/PlayerSprite").frames = load("res://Assets/Graphics/Players/playerblue/playerblue.tres")
		current_color = Globals.blue
	else:
		get_node("Body/PlayerSprite").frames = load("res://Assets/Graphics/Players/playerred/playerred.tres")
		current_color = Globals.red

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
		var body_pos = body.position
		body.position = Vector2(0, 0)
		position = position + body_pos
	
		print("self: " + str(position))
		print("body: " + str(body.position))
		print("tile: " + str(current_tile()))
		
		var current_tile = current_tile()
		get_parent().playfield[current_tile.y][current_tile.x].set_color(current_color)

	

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
	var body_pos = body.position
	body.position = Vector2(0, 0)
	position = position + body_pos
	
func current_tile():
	var center_pos = position + Vector2(Globals.tilesize / 2, Globals.tilesize / 2)
	var x_tile = int(center_pos.x / Globals.tilesize)
	var y_tile = int(center_pos.y / Globals.tilesize)
	return Vector2(x_tile, y_tile)
	
func is_dead():
	var current_tile = current_tile()
	return get_parent().playfield[current_tile.y][current_tile.x].current_color != current_color

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
	
func activate_colorstreak(time):
	colorstreak_active = true
	var timer = Timer.new()
	timer.one_shot = true
	timer.set_wait_time(time)
	timer.connect("timeout", self, "deactivate_colorstreak")
	add_child(timer)
	timer.start()
	
func deactivate_colorstreak():
	colorstreak_active = false
	
func pickup():
	$PickupPlayer.play(0)
	

