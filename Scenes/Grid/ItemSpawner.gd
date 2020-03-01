extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var item_spawn_time = 5
var items = [preload("res://Scenes/Entities/SpeedItem.tscn"), preload("res://Scenes/Entities/ColorItem.tscn")]

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	var timer = Timer.new()
	timer.one_shot = true
	timer.set_wait_time(item_spawn_time)
	timer.connect("timeout", self, "spawn_new_item")
	add_child(timer)
	timer.start()
	spawn_new_item()

func spawn_new_item():
	var new_item = items[rng.randi_range(0, len(items) - 1)].instance()
	var radius = new_item.get_node('Area2D/CollisionShape2D').shape.radius
	var viewport_size = get_viewport_rect().size
	var new_x = rng.randf_range(radius , viewport_size.x - radius)
	var new_y = rng.randf_range(radius, viewport_size.y - radius)
	new_item.position = Vector2(new_x, new_y)
	new_item.z_index = 1
	get_parent().get_node('NoGlowLayer').add_child(new_item)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
