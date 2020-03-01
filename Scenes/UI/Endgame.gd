extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$MainButton.connect("pressed",self,"start_game")
	player_won(Globals.player_won)

func start_game():
	get_tree().change_scene("res://Scenes/Grid/Board.tscn")

func player_won(player_num):
	if (player_num == 1): #blue
		$ColorRect.color = Globals.blue
		$RichTextLabel.text = "Blue won!"
	else:
		$ColorRect.color = Globals.red
		$RichTextLabel.text = "Red won!"
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
