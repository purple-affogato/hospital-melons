extends Node2D

var reading = false
var step1_cleared = false
var step2_cleared = false
var interactObject = "none"
var dialogue_box
var inventory
var dialogue = {
	"machine1" : 
		["A laundry machine.", 
		"It seems very shiny inside."],
	"machine2" : 
		["A laundry machine.", 
		"Why does it have such a magical aura?"],
	"detergent" : 
		["Laundry detergent. The quintessential item to peace and happiness.",
		"It has a dangerously tempting aura.",
		"AND SO! You grasp the laundry detergent. It fills you with vigor."],
	"plant" : 
		["A potted plant ... growing from a pot of red paint??", 
		"That's not something you see every day. It smells a little funny.", 
		"The paint colour reminds you of a colour commonly found on doctors?",
		"Wait, what? This hospital couldn't possibly engage in misconduct!!", 
		"Ehe~, don't worry about it~. Instead, worry about picking up this potted plant."],
	"step1" :
		["Staring at the red paint in your items, you feel a slight want to cause chaos.",
		"Nobody would get mad if you poured the paint into the laundry machine right?",
		"It would be like coloured detergent! The newest cultural phenomenon!",
		"With great confidence, you pour red paint into the laundry machine and start a cycle.",
		"The laundry cycle finishes and out pops a batch of bright red lab coats. Fitting attire for the doctors of this hospital.",
		"Did you just uncover one of hospital's seven mysteries? Possible, but you try not to think about it.",
		"*creaking sounds*",
		"Did something just open up just now?"],
	"toothbrush" :
		["It's a bit weird for a part of the wall to be removed only to reveal a toothbrush.",
		"Why is there a toothbrush on the wall? Why is the wall static all of a sudden? Those are unimportant questions.",
		"What matters is that you take the toothbrush off the wall. It must be something truly exciting."],
	"step2" :
		["Upon closer inspection, there are some specks of dust on this laundry machine.",
		"It really bothers you, but it's gross to touch dust with your bare hands. ",
		"So you decide to use the toothbrush in your hands to clean the laundry machine.",
		"*WHOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOSHHHHHH*"],
	"machine1-static" :
		["Nothing to see here.",
		"Definitely not suspiciously static and noisy-looking."],
	"machine2-portal" :
		["A portal appeared! Where could it lead?",
		"You jump in! Into the new world!"],
	"finish" :
		["What are you still doing here?",
		"You completed the room already. Get out."],
	"machines-detergent" :
		["Usually, you would put laundry detergent in a laundry machine to make your clothes crispy clean.",
		"But we don't do that in this household.",
		"You feel an invisible force pushing the laundry detergent away.",
		"Such a rebellious laundry machine."],
	"rack" :
		["A laundry rack.",
		"On it hangs bright white lab coats.",
		"A rather inaccurate representation of the underlying nature of this hospital."],
	"rack-detergent" :
		["Pouring laundry detergent directly on these lab coats won't clean them.",
		"At least use a laundry machine."],
	"start" :
		["After a running away from a horde of crazy doctors and nurses, you find yourself in a rather strange room.",
		"However, everything has been rather strange since you've entered this hospital.",
		"It's almost as any common sense you knew previously has become corrupted. (!?)",
		"Right now, you want to escape this hospital. It seems you have entered the laundry room?",
		"Not the first room you'd run to when you're stuck in a hospital.",
		"Nevertheless, it's time to take a look around and find a way out."]
	}

func _ready():
	dialogue_box = $DialogueLayer/DialogueBox
	inventory = $Inventory
	inventory.visible = false
	dialogue_box.visible = true
	dialogue_box.start_reading(dialogue["start"])
	reading = true
	$Player.set_physics_process(false)
	$Player/AnimatedSprite2D.animation = "idle"

func _process(delta):
	handle_inventory()
	if reading:
		if dialogue_box.visible == true:
			handle_sfx()
		else:
			handle_item_switch()
			reading = false
			$Player.set_physics_process(true)
	elif Input.is_key_pressed(KEY_E):
		if dialogue.has(interactObject) and len(dialogue[interactObject]) > 0:
			reading = true
			dialogue_box.visible = true
			$Player.set_physics_process(false)
			$Player/AnimatedSprite2D.animation = "idle"
			handle_item_interaction()

func handle_item_interaction():
	if (interactObject == "plant" and not $Plant.visible) or (interactObject == "detergent" and not $Detergent.visible) or (interactObject == "toothbrush" and not $Toothbrush.visible):
			dialogue_box.visible = false
	elif not step1_cleared:
		if interactObject == "machine1" and inventory.item == "plant":
			dialogue_box.start_reading(dialogue["step1"])
			step1_cleared = true
		elif (interactObject == "machine1" or interactObject == "machine2") and inventory.item == "detergent":
			dialogue_box.start_reading(dialogue["machines-detergent"])
		elif interactObject == "rack" and inventory.item == "detergent":
			dialogue_box.start_reading(dialogue["rack-detergent"])
		else:
			dialogue_box.start_reading(dialogue[interactObject])
	
	elif step1_cleared and not step2_cleared:
		if interactObject == "machine2" and inventory.item == "toothbrush":
			dialogue_box.start_reading(dialogue["step2"])
			step2_cleared = true
		elif (interactObject == "toothbrush" and not $Toothbrush.visible):
			dialogue_box.visible = false
		elif interactObject == "plant" or interactObject == "detergent":
			dialogue_box.start_reading(dialogue[interactObject].slice(0, len(dialogue[interactObject]) - 1))
		else:
			dialogue_box.start_reading(dialogue[interactObject])
	else:
		if interactObject == "machine2-portal":
			dialogue_box.start_reading(dialogue[interactObject])
		else:
			dialogue_box.start_reading(dialogue["finish"])

# handles adding and removing items from inventory after dialogue finishes
func handle_item_switch():
	if step1_cleared and not step2_cleared:
		if interactObject == "machine1" and inventory.item == "plant":
			inventory.visible = false
			$LaundryMachine1/AnimatedSprite2D.play("static")
			interactObject = "machine1-static"
		elif interactObject == "toothbrush":
			inventory.visible = false
			inventory.addItem("res://assets/items/toothbrush-item.png", "toothbrush")
	elif step2_cleared:
		if interactObject == "machine2" and inventory.item == "toothbrush":
			inventory.visible = false
			$LaundryMachine2/AnimatedSprite2D.play("portal interact")
			interactObject = "machine2-portal"
		elif interactObject == "machine2-portal":
			get_tree().change_scene_to_file("res://room2.tscn")
	else:
		if interactObject == "detergent":
			inventory.visible = false
			inventory.addItem("res://assets/items/detergent-item.png", "detergent")
		elif interactObject == "plant":
			inventory.visible = false
			inventory.addItem("res://assets/items/plant-item.png", "plant")
	handle_inventory()

# handles sfx based on which line of dialogue is being read. calling when reading = true
func handle_sfx():
	var text = dialogue_box.get_node("RichTextLabel").text
	if text == dialogue["step2"][2]:
		$Radio.position = $LaundryMachine2.position
		$Radio.stream = load("res://assets/audio/whoosh.wav")
	elif text == dialogue["step1"][5]:
		$Radio.position = $Toothbrush/CollisionShape2D.position
		$Radio.stream = load("res://assets/audio/creaking.ogg")
	elif interactObject == "machine1-static" and dialogue_box.idx == 0:
		$Radio.position = $LaundryMachine1.position
		$Radio.stream = load("res://assets/audio/static-noise.ogg")
	else:
		return
	$Radio.play()

# handles which items are visible based on the inventory
func handle_inventory():
	# reset visibility
	$Plant.visible = true
	$Detergent.visible = true
	if step1_cleared and not step2_cleared:
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
	if step2_cleared:
		$LaundryMachine2/AnimatedSprite2D.play("portal interact")
		interactObject = "machine2-portal"
	else:
		$LaundryMachine2/AnimatedSprite2D.play("interact")
		interactObject = "machine2"
	
func _on_laundry_machine_2_body_exited(body):
	if step2_cleared:
		$LaundryMachine2/AnimatedSprite2D.play("portal")
	else:
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

func _on_laundry_rack_body_entered(body):
	$LaundryRack/AnimatedSprite2D.play("interact")
	interactObject = "rack"

func _on_laundry_rack_body_exited(body):
	$LaundryRack/AnimatedSprite2D.play("default")
	interactObject = "none"
