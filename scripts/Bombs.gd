extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BombsTrigger_area_shape_entered(area_id, area, area_shape, self_shape):
	pass


func _on_BombsTrigger_area_entered(area):
	print("BOOOOM")
