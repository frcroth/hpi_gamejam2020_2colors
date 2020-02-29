extends Node

var blue = Color("075c91")
var red = Color("910b07")

var tilesize = 64.0
var beattime = 1.0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func set_bpm(bpm):
	beattime = 1/(bpm/60)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
