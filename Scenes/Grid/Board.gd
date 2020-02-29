extends Node2D

onready var player_scene = load("res://Scenes/Entities/Player.tscn")
var player1
var player2
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var width = 11
var height = 11
var playfield = []

onready var tile = preload("res://Scenes/Grid/Tile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	init_playfield()
	init_players()


func init_playfield():
	var tilestart = (get_viewport_rect().size.x - width * Globals.tilesize) / 2
	playfield = generate_random_playfield(height,width)
	for y in range(height):
		for x in range(width):
			var new_tile = tile.instance()
			new_tile.current_color = Globals.blue if playfield[y][x] == 0 else Globals.red
			new_tile.position = Vector2(tilestart + x * Globals.tilesize, tilestart + y * Globals.tilesize)
			new_tile.update_color()
			add_child(new_tile)

func init_players():
	player1 = player_scene.instance()
	player1.position = Vector2(0,0)
	player1.player_number = 1
	add_child(player1)
	
	player2 = player_scene.instance()
	player2.position = Vector2(width * Globals.tilesize, height * Globals.tilesize)
	player2.player_number = 2
	add_child(player2)


func generate_random_playfield(h,w):
	#Noise based?
	var matrix = []
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	for x in range(w):
    	matrix.append([])
    	for y in range(h):
        	matrix[x].append(rng.randi_range(0,1))
			
	return matrix
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
