extends Node2D

@onready var label = $RichTextLabel

func _process(delta):
	if Input.is_key_pressed(KEY_ENTER):
		set_label("what")

func set_label(string):
	label.text = string

