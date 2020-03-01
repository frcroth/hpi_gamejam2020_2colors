extends Node2D

var type = "speed"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.connect("body_entered", self, "pickup")
	
func init(item_type):
	type = item_type
	$AnimationPlayer.play("ItemDefaultAnimation")
	if(type == "speed"):
		$Area2D/ItemSprite.texture = load("res://Assets/Graphics/Items/speedup/speedup.png")
	if(type == "color"):
		$Area2D/ItemSprite.texture = load("res://Assets/Graphics/Items/color/color.png")
	if(type == "cross"):
		$Area2D/ItemSprite.texture = load("res://Assets/Graphics/Players/playerblueplaceholder.png")
	
func do_item_effect(body):
	if(type == "speed"):
		body.get_parent().speedup(5)
	if(type == "color"):
		body.get_parent().activate_colorstreak(10)
	if(type == "cross"):
		body.get_parent().create_color_cross()

func pickup(body):
	$Particles2D.emitting = true
	do_item_effect(body)
	body.get_parent().pickup()
	$Area2D/ItemSprite.visible = false
	$Area2D/CollisionShape2D.call_deferred("set_disabled",true)
	# wait for particle effects
	yield (get_tree().create_timer(1),"timeout")
	queue_free()

