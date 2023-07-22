extends Node2D

var interactObject = ""

var dialogue = {
	"door" : [],
	"heartLine" : [],
	"biohazard" : ["A biohazard container", "I don't think biological waste is supposed to glow green"],
	"heartThing" : ["A heart monitor", "It's not working..."],
	"bed" : ["A bed", "It looks very uncomfy", "Good thing I'm not tired"],
	"outlet" : {["A broken wire, looks like it's for the heart monitor", "... looks dangerous", "What if I stuff the scissors into here..."] : [[0,2], [0,3]]},
	"cart" : {["A Surgical cart", "Not much equipment on it, what a cheap hospital", "Oo but there are scissors!"] : [[0,3], [0,2]]}
}

var reading = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Inventory.visible = false
	for item in dialogue:
		get_node(item).visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $DiaCont/DialogueBox.reading == false and reading:
		if interactObject == "cart": $Inventory.addItem("res://assets/items/scissors.png", "scissors")
		if interactObject == "outlet" and $Inventory.item == "scissors":
			$Inventory.visible = false
			$heartLine.visible = true
		reading = false
		$Player.set_physics_process(true)
	
	if Input.is_key_pressed(KEY_E) and dialogue.has(interactObject) and len(dialogue[interactObject]) > 0:
		reading = true
		interact()
		$Player.set_physics_process(false)


func interact():
	$DiaCont/DialogueBox.visible = true
	if typeof(dialogue[interactObject]) == TYPE_ARRAY:
		$DiaCont/DialogueBox.start_reading(dialogue[interactObject])
	else: changeInteract(dialogue[interactObject].values().slice(0,1)[0][0], dialogue[interactObject].values().slice(0,1)[0][1])


func changeInteract(range1, range2): # for dialogue changes after an item is picked
	$DiaCont/DialogueBox.visible = true
	if $Inventory.visible == false: $DiaCont/DialogueBox.start_reading(dialogue[interactObject].keys().slice(0,1)[0].slice(range1[0],range1[1]))
	else: $DiaCont/DialogueBox.start_reading(dialogue[interactObject].keys().slice(0,1)[0].slice(range2[0],range2[1]))


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
