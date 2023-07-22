extends Node2D

var reading = false
var interactObject = "none"
var dialogue_box
var dialogue = {
	"machine1" : ["A laundry machine.", "It seems very shiny inside."],
	"machine2" : ["A laundry machine.", "Why does it have a magical aura?"],
	"detergent" : [],
	"plant" : ["A potted plant ... growing from a pot of red paint??", "That's not something you see every day. It smells a little funny.", "The paint colour reminds you of"],
	}

func _ready():
	dialogue_box = $CanvasLayer/DialogueBox

func _process(delta):
	dialogue_box.position = $CanvasLayer.get_final_transform() * (get_global_transform() * dialogue_box.position)
	if reading == true:
		if dialogue_box.visible == true:
			
			return
		else:
			reading = false
			
	elif Input.is_key_pressed(KEY_E):
		if dialogue.has(interactObject) and len(dialogue[interactObject]) > 0:
			reading = true
			dialogue_box.visible = true
			dialogue_box.start_reading(dialogue[interactObject])
			get_node("Player").set_physics_process(false)

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
