extends Node2D

var dialogue1 = [
	"You've finally made it out of the hospital!",
	"Full of elation, you take a look around.",
	"That's strange... it's almost as if the world around seems a little fractured, maybe even corrupted.",
	"You feel an uncomfortable itch in your skin.",
	"Hesitantly, you take a look back at the rather strange hospital that once trapped you in its clutches.",
	"And then..."]
var dialogue2 = [
	"Oh my.",
	"A bit dark, isnt it?"
]

var step1 = false
var step2 = false
var reading = false

func _ready():
	pass

func _process(delta):
	if reading:
		if not $DialogueBox.visible:
			reading = false
			if not step1:
				step1 = true
			elif step1 and not step2:
				step2 = true
		else:
			return
	if not step1:
		$DialogueBox.start_reading(dialogue1)
		reading = true
	elif not step2:
		$TextureRect.texture = load("res://assets/backgrounds/final-bg.png")
		await get_tree().create_timer(1.5).timeout
		$DialogueBox.visible = true
		$DialogueBox.start_reading(dialogue2)
		reading = true
	else:
		get_tree().change_scene_to_file("res://menu.tscn")
