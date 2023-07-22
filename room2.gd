extends Node2D

var interactObject = ""
var biohazard = ["A biohazard container", "I don't think biological waste is supposed to glow green"]
var heartThing = ["A heart monitor", "It's not working..."]
var bed = ["A bed", "It looks very uncomfy", "Good thing I'm not tired"]
var outlet = ["A broken wire, looks like it's for the heart monitor", "... looks dangerous"]
var cart = ["A Surgical cart", "Not much equipment on it, what a cheap hospital", "Oo but there are scissors!"]

var reading = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Inventory.visible = false
	$door.visible = false
	$biohazard.visible = false
	$heartThing.visible = false
	$heartLine.visible = false
	$bed.visible = false
	$outlet.visible = false
	$cart.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $DiaCont/DialogueBox.reading == false and reading:
		if interactObject == "cart":
			$Inventory.addItem("res://assets/items/scissors.png", "scissors")
		reading = false
	
	if Input.is_key_pressed(KEY_E):
		reading = true
	
	if reading and $DiaCont/DialogueBox.reading == false:
		if interactObject == "door":
			pass
		elif interactObject == "biohazard":
			$DiaCont/DialogueBox.visible = true
			$DiaCont/DialogueBox.start_reading(biohazard)
		elif interactObject == "heartThing":
			$DiaCont/DialogueBox.visible = true
			$DiaCont/DialogueBox.start_reading(heartThing)
		elif interactObject == "bed":
			$DiaCont/DialogueBox.visible = true
			$DiaCont/DialogueBox.start_reading(bed)
		elif interactObject == "outlet":
			$DiaCont/DialogueBox.visible = true
			$DiaCont/DialogueBox.start_reading(outlet)
		elif interactObject == "cart":
			print("playing")
			$DiaCont/DialogueBox.visible = true
			if $Inventory.visible == false:
				$DiaCont/DialogueBox.start_reading(cart)
			else:
				$DiaCont/DialogueBox.start_reading(cart.slice(0,2))


func _on_door_body_entered(body):
	$door.visible = true
	interactObject = "door"


func _on_biohazard_body_entered(body):
	$biohazard.visible = true
	interactObject = "biohazard"


func _on_heart_thing_body_entered(body):
	$heartThing.visible = true
	interactObject = "heartThing"


func _on_bed_body_entered(body):
	$bed.visible = true
	interactObject = "bed"


func _on_outlet_body_entered(body):
	$outlet.visible = true
	interactObject = "outlet"


func _on_cart_body_entered(body):
	$cart.visible = true
	interactObject = "cart"


func _on_door_body_exited(body):
	$door.visible = false
	interactObject = ""


func _on_biohazard_body_exited(body):
	$biohazard.visible = false
	interactObject = ""


func _on_heart_thing_body_exited(body):
	$heartThing.visible = false
	interactObject = ""


func _on_bed_body_exited(body):
	$bed.visible = false
	interactObject = ""


func _on_outlet_body_exited(body):
	$outlet.visible = false
	interactObject = ""


func _on_cart_body_exited(body):
	$cart.visible = false
	interactObject = ""
