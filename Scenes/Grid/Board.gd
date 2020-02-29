extends Node2D

onready var player_scene = load("res://Scenes/Entities/Player.tscn")
var player1
var player2
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var width = 4
var height = 4
var playfield = [[1, 0, 1, 0],
				 [0, 1, 0, 1],
				 [1, 0, 1, 0],
				 [0, 1, 0, 1]]

onready var tile = preload("res://Scenes/Grid/Tile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	init_playfield()
	init_players()


func init_playfield():
	for y in range(height):
		for x in range(width):
			var new_tile = tile.instance()
			new_tile.current_color = Globals.blue if playfield[y][x] == 0 else Globals.red
			new_tile.position = Vector2(Globals.tilesize + 2 * x * Globals.tilesize, Globals.tilesize + 2 * y * Globals.tilesize)
			new_tile.update_color()
			add_child(new_tile)

func init_players():
	var player1 = player_scene.instance()
	player1.position = Vector2(0,0)
	player1.player_number = 1
	print(get_node("player1/PlayerSprite/TextureRect"))
	add_child(player1)
	
	var player2 = player_scene.instance()
	player2.position = Vector2(width * Globals.tilesize, height * Globals.tilesize)
	player2.player_number = 2
	add_child(player2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
