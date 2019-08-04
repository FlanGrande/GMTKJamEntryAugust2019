extends Node2D

onready var window = get_tree().get_root()

const MIN_BOMB_SPEED = 1 # speed of the bomb
const MAX_BOMB_SPEED = 3 # speed of the bomb
const BOMB_ACCELERATION = 0.1 # gravity force
var current_speed = MIN_BOMB_SPEED # speed is moving at now

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Created")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(position.y < window.size.y / 3):
		current_speed += BOMB_ACCELERATION
	
	if(current_speed > MAX_BOMB_SPEED):
		current_speed = MAX_BOMB_SPEED
	
	position.y += current_speed