extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.connect("body_entered", self, "pickup")
	
	
func pickup(body):
	$Particles2D.emitting = true
	body.get_parent().speedup(5)
	body.get_parent().pickup()
	$Area2D/ItemSprite.visible = false
	$Area2D/CollisionShape2D.disabled = true
	# wait for particle effects
	yield (get_tree().create_timer(1),"timeout")
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
