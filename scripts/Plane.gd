extends Node2D

onready var window = get_tree().get_root()
onready var timer = get_node("timer_PlaneBomb")

const PLANE_SPEED = 2 # speed of the plane
var current_speed = PLANE_SPEED # speed is moving at now
var active = false # plane active or not
var can_drop_bombs = false
var next_bomb_time_in_seconds = 10; # next bomb will be dropped on this many milliseconds

func _ready():
	timer.set_wait_time(rand_range(5, 10))
	timer.start()
	pass # Replace with function body.

# A lot of hardcore values on this one. Time passed fast!
func _process(delta):
	if(active):
		if(position.x < -800):
			current_speed = PLANE_SPEED
			get_node("Sprite").flip_h = false
		
		if(position.x > window.size.x + 600):
			current_speed = -1 * PLANE_SPEED
			get_node("Sprite").flip_h = true
		
		if(position.x > -200 and position.x < window.size.x - 300):
			can_drop_bombs = true
		else:
			can_drop_bombs = false
		
		position.x += current_speed

func _on_timer_PlaneBomb_timeout():
	#drop bomb and reset timer
	timer.set_wait_time(rand_range(5, 10))
	
	if(can_drop_bombs):
		print("TIMEOUT")
		var bomb_instance = load("res://scenes/SmallBomb.tscn").instance()
		bomb_instance.position = position
		get_parent().get_node("Bombs").add_child(bomb_instance)
