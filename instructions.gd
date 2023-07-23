extends Control

var idx = 0
var text = [
	["Introduction", "Welcome to Hospital Madness! In this game, the player has been trapped a rather strange hospital. There are 3 rooms that the player has to escape from. In each room, there are clues that the player can interact with to figure out how to escape. In accordance to theme, corruption, the logic that the player has to follow to figure how to escape is completely nonsensical! Hence, a \"corruption of logic\"!"],
	["Key Controls", "To move the player, use the left and right arrow keys, or A and D.\n\nTo interact with an item, click E when the item changes colours. You can also pick up certain items, but you can only carry one item at a time. The item you're holding will appear in the bottom left corner. To drop an item, press X.\n\nWhen reading dialogue, click ENTER to go to the next line."],
	["Other Controls", "In the 2nd room, there will be a code you can enter. You can enter it using the number keys. However, you cannot backspace once you enter a number. :)"],
	["Precautions", "So, about the 2nd room, I know, it had the spotlight on the last page. It has slight glitch and distortion affects. If this bothers you, we advise against playing the game."],
	["Credits", "Made by:\npurple-affogato, The Gecko, brrr"],
	["Time to Play!", "Now that you know everything it's time to play the game. >:) Click the up arrow key to go back to the main menu."]
]

# Called when the node enters the scene tree for the first time.
func _ready():
	$Title.text = text[idx][0]
	$Description.text = text[idx][1]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("ui_left"):
		idx = (idx + len(text) - 1) % len(text)
	elif Input.is_action_just_released("ui_right"):
		idx = (idx + 1) % len(text)
	elif Input.is_action_just_released("ui_up"):
		get_tree().change_scene_to_file("res://menu.tscn")
	$Title.text = text[idx][0]
	$Description.text = text[idx][1]
