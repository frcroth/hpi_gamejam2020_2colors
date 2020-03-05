extends Node2D

export var speed = 4
var screen_size
var player_number
var current_color
var colorstreak_active
var controlsinverted = false
onready var body = $Body

var foo = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	if player_number == 0:
		get_node("Body/PlayerSprite").frames = load("res://Assets/Graphics/Players/playerblue/playerblue.tres")
		current_color = Globals.blue
		add_to_group("player0")
	else:
		get_node("Body/PlayerSprite").frames = load("res://Assets/Graphics/Players/playerred/playerred.tres")
		current_color = Globals.red
		add_to_group("player1")


func handle_keys():
	var velocity = Vector2()  # The player's movement vector.
	if player_number == 0:
		if Input.is_key_pressed(KEY_D):
			velocity.x += 1
		if Input.is_key_pressed(KEY_A):
			velocity.x -= 1
		if Input.is_key_pressed(KEY_S):
			velocity.y += 1
		if Input.is_key_pressed(KEY_W):
			velocity.y -= 1
	elif player_number == 1:
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
		
		if controlsinverted:
			velocity = velocity*-1.0
		
		body.move_and_collide(velocity)
		var body_pos = body.position
		body.position = Vector2(0, 0)
		position = position + body_pos
		if colorstreak_active:
			var current_tile = current_tile()
			var inverted_player_color = Globals.red if current_color == Globals.blue else Globals.blue
			get_parent().playfield[current_tile.y][current_tile.x].set_color(inverted_player_color)
	
	
func current_tile():
	var center_pos = position + Vector2(Globals.tilesize / 2, Globals.tilesize / 2)
	var x_tile = int(center_pos.x / Globals.tilesize)
	var y_tile = int(center_pos.y / Globals.tilesize)
	return Vector2(x_tile, y_tile)
	
func is_dead():
	var current_tile = current_tile()
	return get_parent().playfield[current_tile.y][current_tile.x].current_color != current_color

func _process(delta):
	handle_keys()
		
func item_timer(time, revert_method):
	var timer = Timer.new()
	timer.one_shot = true
	timer.set_wait_time(time)
	timer.connect("timeout", self,revert_method )
	add_child(timer)
	timer.start()
			
func speedup(time):
	speed *= 2
	item_timer(time,"speeddown")
	
func speeddown():
	speed /= 2
	
func activate_colorstreak(time):
	colorstreak_active = true
	item_timer(time,"deactivate_colorstreak")
	
func deactivate_colorstreak():
	colorstreak_active = false
	
func invert_controls(time):
	controlsinverted = true
	item_timer(time,"deactivate_inverted_controls")

func deactivate_inverted_controls():
	controlsinverted = false
	
func pickup():
	$PickupPlayer.play(0)

func get_opponent():
	if(player_number==1):
		return get_parent().get_tree().get_nodes_in_group("player0")[0]
	else:
		return get_parent().get_tree().get_nodes_in_group("player1")[0]

func die():
	Globals.player_lost(player_number)

func on_beat():
	if Globals.PLAYERS_CAN_DIE:
		# give some time to change tile
		yield (get_tree().create_timer(Globals.GOODWILLTIME),"timeout")
		# now you have to be on the right tile!
		
		if(is_dead()):
			print("Player ", player_number ," is dead!")
			die()
