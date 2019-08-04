extends RichTextLabel

func _ready():
	pass

func _on_root_typed_message_on_lose(typed_message):
	text = typed_message
