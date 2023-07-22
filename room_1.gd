extends Node2D

var reading = false
var interactObject = "none"
var dialogue_box
var machine1_dialogue = ["A laundry machine.", "It seems very shiny inside."]
var machine2_dialogue = ["A laundry machine.", "Why does it have a magical aura?"]

func _ready():
	dialogue_box = $CanvasLayer/DialogueBox

func _process(delta):
	dialogue_box.position = $CanvasLayer.get_final_transform() * (get_global_transform() * dialogue_box.position)
	if reading == true:
		if dialogue_box.visible == true:
			return
		else:
			reading = false
	if Input.is_key_pressed(KEY_E):
		reading = true
		if interactObject == "machine1":
			dialogue_box.visible = true
			dialogue_box.start_reading(machine1_dialogue)
		elif interactObject == "machine2":
			dialogue_box.visible = true
			dialogue_box.start_reading(machine2_dialogue)

func _on_laundry_machine_1_body_entered(body):
	$LaundryMachine1/AnimatedSprite2D.play("interact")
	interactObject = "machine1"

func _on_laundry_machine_1_body_exited(body):
	$LaundryMachine1/AnimatedSprite2D.play("default")
	interactObject = "none"

func _on_laundry_machine_2_body_entered(body):
	$LaundryMachine2/AnimatedSprite2D.play("interact")
	interactObject = "machine2"
	
func _on_laundry_machine_2_body_exited(body):
	$LaundryMachine2/AnimatedSprite2D.play("default")
	interactObject = "none"

func _on_plant_body_entered(body):
	$Plant/AnimatedSprite2D.play("interact")
	interactObject = "plant"

func _on_plant_body_exited(body):
	$Plant/AnimatedSprite2D.play("default")
	interactObject = "none"

func _on_detergent_body_entered(body):
	$Detergent/AnimatedSprite2D.play("interact")
	interactObject = "detergent"
	

func _on_detergent_body_exited(body):
	$Detergent/AnimatedSprite2D.play("default")
	interactObject = "none"
