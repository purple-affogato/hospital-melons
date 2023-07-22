extends Node2D

var reading = false
var interactObject = "none"
var machine1_dialogue = ["A laundry machine.", "It seems very shiny inside."]

func _ready():
	pass

func _process(delta):
	if reading == true:
		return
	if Input.is_key_pressed(KEY_E):
		reading = true
		if interactObject == "machine1":
			$DialogueBox.visible = true
			$DialogueBox.start_reading(machine1_dialogue)

func _on_laundry_machine_1_body_entered(body):
	$LaundryMachine1/AnimatedSprite2D.play("interact")
	interactObject = "machine1"


func _on_laundry_machine_1_body_exited(body):
	$LaundryMachine1/AnimatedSprite2D.play("default")
