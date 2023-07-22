extends CanvasLayer


# Called when the node enters the scene tree for the first time.
var item

func _ready():
	visible = true

func addItem(imgPath, itemName):
	if !visible:
		$item.texture = load(imgPath)
		item = itemName
		visible = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if visible and Input.is_key_pressed(KEY_X):
		visible = false
	if !visible:
		item = ""
