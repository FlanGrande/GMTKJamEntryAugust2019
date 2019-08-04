extends Node2D

var open = false

# FX
var FX_NOTEBOOK = load("res://fx/notebook.ogg")

# Called when the node enters the scene tree for the first time.
func _ready():
	open = false
	pass # Replace with function body.

func open():
	if(not open):
		$AnimationPlayer.play("open")
		open = true

func close():
	if(open):
		$AnimationPlayer.play("close")
		open = false

func _on_Telegrafo_typing_updated(typing):
	if(typing):
		close()
	else:
		open()