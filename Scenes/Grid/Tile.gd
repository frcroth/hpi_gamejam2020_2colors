extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var current_color = Globals.blue
var red_sprite = preload("res://Assets/Graphics/Tiles/red_tile/red_tile.png")
var blue_sprite = preload("res://Assets/Graphics/Tiles/blue_tile/blue_tile.png")
var sprite_pixels = 64


# Called when the node enters the scene tree for the first time.
func _ready():
	set_dimensions()
	update_color()
	
func set_dimensions():
	var new_extents = Vector2(Globals.tilesize/2, Globals.tilesize/2)
	$TileArea/TileCollisionShape.shape.set_extents(new_extents)
	$TileArea/TileCollisionShape.position = new_extents
	$TileArea/TileSprite.position = new_extents
	var new_scale = Globals.tilesize / sprite_pixels
	$TileArea/TileSprite.transform.scaled(Vector2(new_scale, new_scale))

func update_color():
	if current_color == Globals.blue:
		$TileArea/TileSprite.texture = blue_sprite 
	else:
		$TileArea/TileSprite.texture = red_sprite

func set_color(color):
	current_color = color
	update_color()

func swap_color():
	current_color = Globals.blue if (current_color == Globals.red) else Globals.red
	update_color()

func on_beat():
	swap_color()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
