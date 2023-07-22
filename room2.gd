extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$door.visible = false
	$biohazard.visible = false
	$heartThing.visible = false
	$bed.visible = false
	$outlet.visible = false
	$cart.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_door_body_entered(body):
	$door.visible = true


func _on_biohazard_body_entered(body):
	$biohazard.visible = true


func _on_heart_thing_body_entered(body):
	$heartThing.visible = true


func _on_bed_body_entered(body):
	$bed.visible = true


func _on_outlet_body_entered(body):
	$outlet.visible = true


func _on_cart_body_entered(body):
	$cart.visible = true


func _on_door_body_exited(body):
	$door.visible = false


func _on_biohazard_body_exited(body):
	$biohazard.visible = false


func _on_heart_thing_body_exited(body):
	$heartThing.visible = false


func _on_bed_body_exited(body):
	$bed.visible = false


func _on_outlet_body_exited(body):
	$outlet.visible = false


func _on_cart_body_exited(body):
	$cart.visible = false
