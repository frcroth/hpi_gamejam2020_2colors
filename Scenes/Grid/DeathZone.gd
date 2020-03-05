extends Node2D


var deathzone_started = false

onready var upper = $UpperArea
onready var right = $RightArea
onready var lower = $LowerArea
onready var left = $LeftArea
var areas = []


# Called when the node enters the scene tree for the first time.
func _ready():
	if Globals.ENABLE_DEATH_ZONE:
		yield (get_tree().create_timer(Globals.death_zone_start),"timeout")
		deathzone_started = true
		areas = [upper,right,lower,left]
		#$Area2D.connect("body_entered", self, "entered")

func entered(body):
	if(body.get_parent().get_name()=="Player"):
		#unused
		pass
		
func body_in_area(body):
	for area in areas:
		if(area.overlaps_body(body)):
			return true
	return false

func _process(delta):
	if deathzone_started:
		upper.position.y += Globals.death_zone_speed
		lower.position.y -= Globals.death_zone_speed
		right.position.x -= Globals.death_zone_speed
		left.position.x += Globals.death_zone_speed
