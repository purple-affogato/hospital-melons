extends Node2D

var reading = false
var step1_cleared = false
var interactObject = "none"
var dialogue_box
var inventory
var dialogue = {
	"machine1" : 
		["A laundry machine.", 
		"It seems very shiny inside."],
	"machine2" : 
		["A laundry machine.", 
		"Why does it have a magical aura?"],
	"detergent" : 
		["Laundry detergent. The quintessential item to peace and happiness.",
		"It has a dangerously tempting aura."],
	"plant" : 
		["A potted plant ... growing from a pot of red paint??", 
		"That's not something you see every day. It smells a little funny.", 
		"The paint colour reminds you of a colour commonly found on doctors?",
		"Wait, what? This hospital couldn't possibly engage in misconduct!!", 
		"Ehe~, don't worry about it~. Instead, worry about picking up this potted plant."],
	"step1" :
		["Staring at the red paint in your items, you feel a slight want to cause chaos.",
		"No one would get mad if you poured the paint into the laundry machine right?",
		"It would be like coloured detergent! The new cultural phenomenon!",
		"With great confidence, you pour red paint into the laundry machine and start a cycle.",
		"The laundry cycle finishes and out pops a batch of bright red lab coats. Fitting attire for the doctors of this hospital.",
		"Did you just uncover one of hospital's seven mysteries? Possible but you try not to think about it.",
		"*creaking sounds*",
		"Did something just open up just now?"]
	}

func _ready():
	dialogue_box = $DialogueLayer/DialogueBox
	inventory = $Inventory
	inventory.visible = false

func _process(delta):
	handle_inventory()
	if reading:
		if dialogue_box.visible == true:
			return
		else:
			handle_item_switch()
			reading = false
			$Player.set_physics_process(true)
	elif Input.is_key_pressed(KEY_E):
		if dialogue.has(interactObject) and len(dialogue[interactObject]) > 0:
			reading = true
			dialogue_box.visible = true
			$Player.set_physics_process(false)
			handle_item_interaction()
	else:
		if step1_cleared:
			inventory.visible = false
			$Toothbrush.visible = true

func handle_item_interaction():
	if interactObject == "plant":
		if not $Plant.visible:
			dialogue_box.visible = false
		else:
			dialogue_box.start_reading(dialogue[interactObject])
	elif interactObject == "machine1" and inventory.item == "plant":
		dialogue_box.start_reading(dialogue["step1"])
		step1_cleared = true
	else:
		dialogue_box.start_reading(dialogue[interactObject])

# handles adding and removing items from inventory after dialogue finishes
func handle_item_switch():
	if step1_cleared:
		if interactObject == "machine1" and inventory.item == "plant":
			inventory.visible = false
			$LaundryMachine1/AnimatedSprite2D.play("static")
		if interactObject == "toothbrush":
			inventory.visible = false
			inventory.addItem("res://assets/items/toothbrush-item.png", "toothbrush")
			
	else:
		if interactObject == "detergent":
			inventory.visible = false
			inventory.addItem("res://assets/items/detergent-item.png", "detergent")
		elif interactObject == "plant":
			inventory.visible = false
			inventory.addItem("res://assets/items/plant-item.png", "plant")
	handle_inventory()

# handles which items are visible based on the inventory
func handle_inventory():
	# reset visibility
	$Plant.visible = true
	$Detergent.visible = true
	if step1_cleared:
		$Toothbrush.visible = true
		
	if inventory.item == "plant":
		$Plant.visible = false
	elif inventory.item == "detergent":
		$Detergent.visible = false
	elif inventory.item == "toothbrush":
		$Toothbrush.visible = false

func _on_laundry_machine_1_body_entered(body):
	if $LaundryMachine1/AnimatedSprite2D.animation == "static":
		interactObject = "machine1-static"
	else:
		$LaundryMachine1/AnimatedSprite2D.play("interact")
		interactObject = "machine1"

func _on_laundry_machine_1_body_exited(body):
	if $LaundryMachine1/AnimatedSprite2D.animation != "static":
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

func _on_toothbrush_body_entered(body):
	$Toothbrush/ColorRect.visible = true
	interactObject = "toothbrush"

func _on_toothbrush_body_exited(body):
	$Toothbrush/ColorRect.visible = false
	interactObject = "none"
