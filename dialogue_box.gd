extends Control

@onready var label = $RichTextLabel
var dialogue = []
var idx = 0
var reading = false

func _process(delta):
	print(InputEventKey)
	if reading == true and Input.is_action_just_released("enter"): # this is how you check for the enter key
		if idx+1 == len(dialogue):
			reading = false
			visible = false
		else:
			idx += 1
			label.text = dialogue[idx]

func start_reading(array):
	dialogue = array
	idx = 0
	label.text = dialogue[idx]
	reading = true
