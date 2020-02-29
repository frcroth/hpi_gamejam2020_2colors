extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$RedRect.color = Globals.red
	$BlueRect.color = Globals.blue
	$MainButton.connect("pressed",self,"start_game")

func start_game():
	get_tree().change_scene("res://Scenes/Grid/Board.tscn")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
