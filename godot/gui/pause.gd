extends Control

var paused = false

onready var bt_continue = $VBoxContainer/VBoxContainer/button
onready var bt_options = $VBoxContainer/VBoxContainer/button2
onready var bt_quit = $VBoxContainer/VBoxContainer/button3

onready var base = get_node("/root/game")

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false


func _input(event):
	if event.is_action_pressed("pause") && base.state in ["play", "dialogue"]:
		base.state = "paused"
		visible = !visible
		openmenu()
	elif event.is_action_pressed("pause") && visible == true:
		base.state = "play"
		visible = !visible
		_on_continue_pressed()
		
func openmenu():
	if paused:
		get_parent().pause_mode = Node.PAUSE_MODE_STOP
	else:
		get_parent().pause_mode = Node.PAUSE_MODE_PROCESS
	get_parent().get_node("notebook").visible = false
	get_tree().paused = visible
	bt_continue.grab_focus()


func _on_continue_pressed():
	visible = false
	get_tree().paused = false
	base.state = "play"


func _on_quit_pressed():
	get_tree().paused = false
	base.save_game()
	Scenechanger.change_scene("res://bigscenes/mainmenu.tscn")
