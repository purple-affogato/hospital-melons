extends CanvasLayer

var cnt = 0
var isNum = null
var code = [0,0,0,0]
var ans = [2,4,1,2]
var win = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _input(event):
	if visible and cnt < 4 and event is InputEventKey:
		print(event.keycode)
		isNum = null
		for i in 10:
			if event.keycode == i + 48:
				isNum = i
				break
		if isNum != null && !event.is_pressed():
			code[cnt] = isNum
			cnt += 1
			get_node("code" + str(cnt)).text = "[center]" + str(isNum)	
			get_node("rect" + str(cnt)).color = "#b1c497"
		if cnt >= 4:
			if ans == code:
				for i in range(1,5):
					get_node("rect" + str(i)).color = "#0dff4d"
				get_parent().get_node("radio").stream = load("res://assets/audio/W.wav")
				get_parent().get_node("radio").play()
				await get_tree().create_timer(0.5).timeout
				visible = false
				win = true
				
				get_parent().get_node("Player").set_physics_process(true)
			else:
				for i in range(1,5):
					get_node("rect" + str(i)).color = "#fe414e"
				get_parent().get_node("radio").stream = load("res://assets/audio/wrong.wav")
				get_parent().get_node("radio").play()
				await get_tree().create_timer(0.5).timeout
				for i in range(1,5):
					get_node("rect" + str(i)).color = "#49dd6d"
				cnt = 0
				for i in range(1,5):
					get_node("code" + str(i)).text = "[center]0"
