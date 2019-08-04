extends Node2D

signal shake_everything(pos)

onready var window = get_tree().get_root()

# FX
var FX_BOMB_EXPLOSION = load("res://fx/small_bomb.ogg")
var FX_BOMB_FALLING = load("res://fx/falling_bomb.ogg")

const MIN_BOMB_SPEED = 1 # speed of the bomb
const MAX_BOMB_SPEED = 3 # speed of the bomb
const BOMB_ACCELERATION = 0.1 # gravity force
const DETONATION_TIME = 1
var current_speed = MIN_BOMB_SPEED # speed is moving at now

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Created")
	connect("shake_everything", get_parent().get_parent().get_parent(), "_on_Bomb_shake_everything")
	get_parent().get_parent().get_node("aux_fx").set_stream(FX_BOMB_FALLING)
	get_parent().get_parent().get_node("aux_fx").play()
	$Timer.set_wait_time(DETONATION_TIME)
	$Timer.start()
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(position.y < window.size.y / 3):
		current_speed += BOMB_ACCELERATION
	
	if(current_speed > MAX_BOMB_SPEED):
		current_speed = MAX_BOMB_SPEED
	
	position.y += current_speed
	
	if($Timer.get_time_left() <= 0):
		explode()

func explode():
	#boom
	emit_signal("shake_everything", position)
	get_parent().get_parent().get_node("aux_fx").set_stream(FX_BOMB_EXPLOSION)
	get_parent().get_parent().get_node("aux_fx").play()
	queue_free()