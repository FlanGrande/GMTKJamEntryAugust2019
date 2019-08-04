extends Timer

signal boom() # Lose the game
signal second(time) # Sends time left

func _ready():
	pass

func _process(delta):
	emit_signal("second", int(round(get_time_left())))
	
	if(get_time_left() <= 0):
		emit_signal("boom")
	
	pass