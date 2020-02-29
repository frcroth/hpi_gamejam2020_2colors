extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var current_color = Globals.blue


# Called when the node enters the scene tree for the first time.
func _ready():
	update_color()
	swap_color()

func update_color():
	$TileArea/TileColor.color = Color(current_color)

func swap_color():
	current_color = Globals.blue if (current_color == Globals.red) else Globals.red
	update_color()

func on_beat():
	swap_color()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
