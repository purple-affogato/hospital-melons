extends CharacterBody2D

const SPEED = 300.0
var flip = false

func _physics_process(delta):
	if Input.is_action_pressed("right"):
		velocity.x = SPEED
		if flip:
			scale.x = -1
			flip = false
		$AnimatedSprite2D.play("walk")
		print("PLAYING")
	elif Input.is_action_pressed("left"):
		velocity.x = -SPEED
		if !flip:
			scale.x = -1
			flip = true
		$AnimatedSprite2D.play("walk")
	else:
		$AnimatedSprite2D.play("idle")
		velocity.x = 0

	print(scale.x)
	move_and_slide()
