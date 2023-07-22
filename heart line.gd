extends Sprite2D

const SPEED = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if visible:
		position.x += SPEED * delta
	if position.x >= 510:
		position.x = -377
