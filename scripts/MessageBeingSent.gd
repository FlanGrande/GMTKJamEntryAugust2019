extends Label

func _ready():
	pass

func _on_Telegrafo_input_message_updated(input_message):
	text = input_message
