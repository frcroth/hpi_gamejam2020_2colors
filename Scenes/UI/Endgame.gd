extends Control

var endtexts = ["Blue won!", "Red won!"]

# Called when the node enters the scene tree for the first time.
func _ready():
	$MainButton.connect("pressed",self,"start_game")
	player_won(Globals.player_won)

func start_game():
	get_tree().change_scene("res://Scenes/Grid/Board.tscn")

func player_won(player_num):
	$WinnerColorRect.color = Globals.colors[player_num]
	$WinnerLabel.text = endtexts[player_num]
	$PointsRedLabel.text += str(Globals.wins[1])
	$PointsBlueLabel.text += str(Globals.wins[0])
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
