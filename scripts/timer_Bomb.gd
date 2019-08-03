extends Timer

signal boom()
signal second(time)

var counter = 0

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	emit_signal("second", int(round(get_time_left())))
	
	if(get_time_left() <= 0):
		emit_signal("boom")
	
	counter += 1
	pass