extends Node

var blue = Color("075c91")
var red = Color("910b07")
var colors = [red, blue]

var tilesize = 64.0
var beattime = 0.66
var GOODWILLTIME = 0.3
var player_won = 0
var PLAYERS_CAN_DIE = true

var wins = [0, 0]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func player_lost(player_number):
	player_won = 1^ player_number
	wins[player_won] += 1
	get_tree().change_scene("res://Scenes/UI/Endgame.tscn")
	

func set_bpm(bpm):
	beattime = 1/(bpm/60)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
