extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$spr_Prota/AnimationPlayer.play("idle")
	pass # Replace with function body.

func change_anim(name):
	$spr_Prota/AnimationPlayer.play(name)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Telegrafo_typing_updated(typing):
	if(typing):
		$spr_Prota/AnimationPlayer.play("press")
	else:
		$spr_Prota/AnimationPlayer.play("idle")