extends Node2D

var interactObject = ""

var dialogue = {
	"beacon" : [],
	"code" : [],
	"door" : [],
	"heartLine" : [],
	"biohazard" : [["A biohazard container", "I don't think biological waste is supposed to glow green"], ["No, I can assure you the scissors aren't a biohazard"]],
	"heartThing" : [["A heart monitor", "It's not working..."], ["A heart monitor", "Hehe I fixed it"], ["A heart monitor", "It's already broken, no need to break it some more"]],
	"bed" : [["A bed", "It looks very uncomfy", "Good thing I'm not tired"], ["A bed", "What do you think you're doing, trying to cut up the bed?", "Clearly you need larger scissors for that"]],
	"outlet" : [["A broken wire, looks like it's for the heart monitor", "... looks dangerous", "Oh, what if I stuff the scissors into here!"], ["A broken wire, looks like it's for the heart monitor", "Still looks dangerous",]],
	"cart" : ["A surgical cart", "Not much equipment on it, what a cheap hospital", "Oo but there are scissors!"]
}

var startDia = ["Gah, another room", "Bleh, why do I feel so fizzy?", "*sigh* maybe I'll at least be able to vandalize more items here", "Something about aura of this room tells me that this is the final room of this hospital", "*sheds tear* so close to freedom", "Time to look around!"]
var endDia = ["I- YES! Finally!", "I get to leave this place- yes!", "After all of my hardships: running from nurses, scrubbing washing machines, and performing questionable electrical fixes, I've reached the end", "Truely a joyous occasion- wait why isn't the door opening-", "...", "ok..."]

var reading = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Inventory.visible = false
	for item in dialogue:
		get_node(item).visible = false
	$DiaCont/DialogueBox.visible = true
	reading = true
	$DiaCont/DialogueBox.start_reading(startDia)
	idle()
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $DiaCont/DialogueBox.reading == false and reading:
		if interactObject == "cart" and !$heartLine.visible and $scissors.visible: 
			$Inventory.addItem("res://assets/items/scissors.png", "scissors")
			$scissors.visible = false
		elif interactObject == "outlet" and $Inventory.item == "scissors":
			$Inventory.visible = false
			$heartLine.visible = true
			$scissors.texture = load("res://assets/backgrounds/scissors.png")
			$scissors.visible = true
			$radio.volume_db = 16
			$radio.stream = load("res://assets/audio/beep.ogg")
			$radio.play()
		reading = false
		$Player.set_physics_process(true)
	
	if Input.is_key_pressed(KEY_E) and interactObject != "":
		if interactObject == "biohazard" and $code.win:
			get_tree().change_scene_to_file("res://ending.tscn")
		elif dialogue.has(interactObject) and len(dialogue[interactObject]) > 0:
			reading = true
			interact()
		elif interactObject == "door": code()
		idle()
	
	if $Inventory.visible and Input.is_key_pressed(KEY_X):
		$scissors.visible = true
	if $code.visible and Input.is_key_pressed(KEY_X):
		$code.visible = false
		$Player.set_physics_process(true)
	
	if $code.win and !reading and !$beacon.visible:
		idle()
		$DiaCont/DialogueBox.visible = true
		reading = true
		$DiaCont/DialogueBox.start_reading(endDia)
	if $DiaCont/DialogueBox.idx == 3 and $code.win and !$beacon.visible:
		$beacon.visible = true
		$radio.stream = load("res://assets/audio/laserbeam.wav")
		$radio.play()
		$beacon/animated.play("start")
		await get_tree().create_timer(0.3).timeout 
		$beacon/animated.play("default")


func code():
	$code.visible = true

func idle():
	$Player/AnimatedSprite2D.play("idle")
	$Player.set_physics_process(false)


func interact():
	$DiaCont/DialogueBox.visible = true
	if $code.win:
		$DiaCont/DialogueBox.start_reading(["What are you waiting for, can't you hear the sounds of freedom?"])
	elif interactObject == "heartThing":
		if $heartLine.visible: $DiaCont/DialogueBox.start_reading(dialogue[interactObject][1])
		elif $Inventory.visible: $DiaCont/DialogueBox.start_reading(dialogue[interactObject][2])
		else: $DiaCont/DialogueBox.start_reading(dialogue[interactObject][0])
	elif interactObject == "outlet":
		if $heartLine.visible: $DiaCont/DialogueBox.start_reading(dialogue[interactObject][1])
		elif $scissors.visible: $DiaCont/DialogueBox.start_reading(dialogue[interactObject][0].slice(0,2))
		else: $DiaCont/DialogueBox.start_reading(dialogue[interactObject][0])
	elif interactObject == "cart":
		if $scissors.visible and !$heartLine.visible: changeInteract(0,3)
		else: changeInteract(0,2)
	elif interactObject == "biohazard":
		if $Inventory.visible: $DiaCont/DialogueBox.start_reading(dialogue[interactObject][1])
		else: $DiaCont/DialogueBox.start_reading(dialogue[interactObject][0])
	elif interactObject == "bed":
		if $Inventory.visible: $DiaCont/DialogueBox.start_reading(dialogue[interactObject][1])
		else: $DiaCont/DialogueBox.start_reading(dialogue[interactObject][0])
	elif typeof(dialogue[interactObject]) == TYPE_ARRAY:
		$DiaCont/DialogueBox.start_reading(dialogue[interactObject])


func changeInteract(range1, range2): # for dialogue changes after an item is picked
	$DiaCont/DialogueBox.start_reading(dialogue[interactObject].slice(range1, range2))


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
