extends Button

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("pressed",self,"show_credits")
	
func show_credits():
	get_parent().get_node("AnimationPlayer").play("LabelAnimation")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
