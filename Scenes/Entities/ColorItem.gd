extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.connect("body_entered", self, "pickup")
	
	
func pickup(body):
	body.get_parent().activate_colorstreak(20)
	print(body.get_parent())
	body.get_parent().pickup()
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
