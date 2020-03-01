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
	playfield = []
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	for y in range(height):
		playfield.append([])
		for x in range(width):
			
			var color
			if x == 0 && y == 0:
				color = Globals.blue
			elif x == width - 1 && y == height - 1:
				color = Globals.red
			else:
				color = Globals.red if rng.randi_range(0,1) == 0 else Globals.blue
			
			var new_tile = tile.instance()
			new_tile.current_color = color
			playfield[y].append(new_tile)
			new_tile.position = Vector2(tilestart + x * Globals.tilesize, tilestart + y * Globals.tilesize)
			new_tile.update_color()
			add_child(new_tile)

func init_players():
	var topleft = playfield[0][0].position
	var bottomright = topleft + Vector2((width-1) * Globals.tilesize, (height - 1) * Globals.tilesize)
	
	player1 = player_scene.instance()
	player1.position = topleft
	player1.player_number = 0
	add_child(player1)
	
	player2 = player_scene.instance()
	player2.position = bottomright
	player2.player_number = 1
	add_child(player2)
#

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
