extends Node2D

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
	playfield = generate_random_playfield(height,width)
	init_playfield()


func init_playfield():
	for y in range(height):
		for x in range(width):
			var new_tile = tile.instance()
			new_tile.current_color = Globals.blue if playfield[y][x] == 0 else Globals.red
			new_tile.position = Vector2(x * Globals.tilesize, y * Globals.tilesize)
			new_tile.update_color()
			add_child(new_tile)
			
func generate_random_playfield(h,w):
	#Noise based?
	var matrix = []
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	for x in range(width):
    	matrix.append([])
    	for y in range(height):
        	matrix[x].append(rng.randi_range(0,1))
			
	return matrix
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
