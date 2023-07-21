extends Node2D

@onready var label = $RichTextLabel

func _process(delta):
	if Input.is_action_pressed("ui_enter"):
		set_label("what")

func set_label(string):
	label.text = string

