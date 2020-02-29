extends Node2D

var beating = true
var timefactor = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	beating_loop()


func start_beating():
	beating = true
	
func stop_beating():
	beating = false
	
func beating_loop():
	yield (get_tree().create_timer(0.5),"timeout")
	while beating:
		yield (get_tree().create_timer(Globals.beattime*timefactor),"timeout")
		$AudioStreamPlayer.play(0)
		get_parent().get_tree().call_group("beatable","on_beat")
		
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
