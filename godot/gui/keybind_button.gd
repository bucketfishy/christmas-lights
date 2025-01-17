extends TextureButton

export(String) var text
export(String) var key
export(NodePath) var parent

var font_size = 32
var selecting = false

onready var label = $HBoxContainer/Control2/label
onready var input = $HBoxContainer/Control/key

signal value_change(variable, value)

func _ready():
	selecting = false
	setup_text(key)
	set_focus_mode(true)
	var dynamic_font = DynamicFont.new()
	dynamic_font.font_data = load("res://christmas lights.ttf")
	dynamic_font.size = font_size



func setup_keys():
	if key in get_node(parent).get_parent().config:
		InputMap.action_erase_event(key, InputMap.get_action_list(key)[0])
		print(get_node(parent).get_parent().config[key])
		
		var event = InputEventKey.new()
		event.scancode = get_node(parent).get_parent().config[key]
		InputMap.action_add_event(key, event)
		
	setup_text(key)
	
func setup_text(value):

	var thing = {
		"Left": "←",
		"Right":"→",
		"Up":"↑",
		"Down":"↓",
	}
	var map = InputMap.get_action_list(value)[0].as_text()
	if map in thing.keys():
		map = thing[map]
		
	label.bbcode_text = "%s" % [tr(text)]
	print(text + " " + key)
	print("RELOADED LANG! " + label.bbcode_text)
	
	input.bbcode_text = "[right]%s" % [map]
	
	if label.get_line_count() == 1:
		label.margin_top = 15
	else:
		label.margin_top = 0
	$front.visible = false
	$back.visible = false

	
	
func select_text():
	var thing = {
		"Left": "←",
		"Right":"→",
		"Up":"↑",
		"Down":"↓",
	}
	var map = InputMap.get_action_list(key)[0].as_text()
	if map in thing.keys():
		map = thing[map]
		
	label.bbcode_text = "[color=#add8ff]%s[/color]" % [tr(text)]
	input.bbcode_text = "[color=#add8ff][right]%s" % [map]
	$front.visible = true
	$back.visible = true
	
func _on_button_focus_entered():
	select_text()

func _on_button_focus_exited():
	setup_text(key)

func _on_button_mouse_entered():
	grab_focus()

func _input(event):
	
	if event is InputEventKey && selecting:
		selecting = false
		InputMap.action_erase_event(key, InputMap.get_action_list(key)[0])
		InputMap.action_add_event(key, event)
		
		
		emit_signal("value_change", key, event.scancode)
		
		
		select_text()
		yield(get_tree().create_timer(0.01), "timeout")
		grab_focus()


func _on_button_pressed():
	release_focus()
	selecting = true
	
	input.bbcode_text = "[color=#add8ff][right]%s" % ["?"]
	label.bbcode_text = "[color=#add8ff]%s[/color]" % [tr(text)]
	$front.visible = true
	$back.visible = true

func reload_lang():
	setup_keys()
