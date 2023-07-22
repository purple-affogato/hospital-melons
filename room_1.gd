extends Node2D

func _ready():
	pass

func _process(delta):
	pass


func _on_laundry_machine_1_body_entered(body):
	$LaundryMachine1/AnimatedSprite2D.play("interact")


func _on_laundry_machine_1_body_exited(body):
	$LaundryMachine1/AnimatedSprite2D.play("default")
