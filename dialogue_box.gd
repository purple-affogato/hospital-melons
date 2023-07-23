extends Control

@onready var label = $RichTextLabel
var dialogue = []
var idx = 0
var reading = false

func _process(_delta):
	if not visible:
		return
	if reading == true and Input.is_action_just_released("enter"):
		idx += 1
		if idx == len(dialogue):
			reading = false
			visible = false
		else:
			label.text = dialogue[idx]

func start_reading(array):
	dialogue = array
	idx = 0
	label.text = dialogue[idx]
	reading = true
