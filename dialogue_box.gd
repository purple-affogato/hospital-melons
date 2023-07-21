extends Node2D

@onready var label = $RichTextLabel

func _process(delta):
	if Input.is_key_pressed(KEY_ENTER): # this is how you check for the enter key
		set_label("what")

func set_label(string):
	label.text = string # and this is how you change the text label

