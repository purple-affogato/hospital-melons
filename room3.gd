extends Node2D

var reading = false
var objectTouched = "none"
var coffeeDialogue = ["Yummy yummy (cold) coffee."]
var room3Intro = ["You're almost there! Welcome to room 3.","Please make sure no eyes are staring at you before you go, or you will be heartbroken and too disturbed to leave."]
var pinataDialogue = ["Aharharhar I am Moony the Pinata, what have you to give me?"]
var wrongObjectDialoge = ["Wrong item key! Please try something else."]
var mustacheDialogue = ["catto with a mustache, catto with a MUSTACHE"]
	

# Called when the node enters the scene tree for the first time.
func _ready():
	$DialogueBox.start_reading(room3Intro)	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if reading == true:
		return
	if Input.is_key_pressed(KEY_E):
		reading = true
		if objectTouched == "coffee":
			$DialogueBox.visible = true
			$DialogueBox.start_reading(coffeeDialogue)	
			$coffee/AnimatedSprite2D.visible = false
		#if object in item booth == coffee
		if objectTouched == "pinata":
			$DialogueBox.visible = true
			$DialogueBox.start_reading(pinataDialogue)
			var frames = [0,1,2,4,0,1,2,3,4]	
			$pinata/AnimationPlayer.play("Move position")
		#if objectTouched == "mustache":
			#$DialogueBox.visible = true
		#	$DialogueBox.start_reading(mustacheDialogue)
			

func _on_coffee_body_entered(body):
	$coffee/AnimatedSprite2D.frame = 1
	objectTouched = "coffee"

func _on_coffee_body_exited(body):
	$coffee/AnimatedSprite2D.frame = 0
	

func _on_pinata_body_entered(body):
	$pinata/AnimatedSprite2D.frame = 1
	objectTouched = "pinata"

func _on_pinata_body_exited(body):
	$pinata/AnimatedSprite2D.frame = 0


func _on_mustache_body_entered(body):
	$mustache/AnimatedSprite2D.frame = 1
	objectTouched = "mustache"

func _on_mustache_body_exited(body):
	$mustache/AnimatedSprite2D.frame = 0
