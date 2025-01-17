extends CanvasLayer

var config = {
	"video_particles": 0.5,
	"video_saturation": 0.5,
	"video_brightness": 0.5,
	"video_contrast": 0.5,
	"audio_master": 0.5,
	"audio_music": 0.5,
	"audio_soundeffects": 0.5,
}


onready var pages = [
	$main, $video, $audio, $language
]

onready var main = $main

var open = false

signal change_screen(thing)
signal exit_options
signal finish_load

# Called when the node enters the scene tree for the first time.
func _ready():
	load_game()


	env.environment.adjustment_brightness = 2 * config["video_brightness"]
	env.environment.adjustment_saturation = 2 * config["video_saturation"]
	env.environment.adjustment_contrast = 2 * config["video_contrast"]
	
	if "language" in config.keys():
		TranslationServer.set_locale(config["language"])
		yield(get_tree().create_timer(0.01), "timeout")

	
	lang()
	$"/root/game".lang()
	propagate_call("setup_keys")
	print("setup")

	
	emit_signal("change_screen","")

	#$main/VBoxContainer/VBoxContainer/video.grab_focus()


func open_options():
	open = true

	load_game()
	emit_signal("change_screen", "main")
	$main/VBoxContainer/VBoxContainer/video.grab_focus()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if $main.visible:
			_on_backmain_pressed()
		elif $video.visible || $audio.visible || $controls.visible || $language.visible:
			save_game()
			emit_signal("change_screen", "main")

func _on_video_pressed():
	emit_signal("change_screen", "video")


func _on_audio_pressed():
	emit_signal("change_screen", "audio")


func _on_controls_pressed():
	emit_signal("change_screen", "controls")
	

func _on_language_pressed():
	emit_signal("change_screen", "language")



func _on_back_pressed():
	emit_signal("change_screen", "main")
	save_game()

func _on_backmain_pressed():
	emit_signal("exit_options")
	$main.visible = false
	open = false
	#DO THETHIING in the future to connect w the rest


func _on_value_change(variable, value):
	config[variable] = value
	env.environment.adjustment_brightness = 2 * config["video_brightness"]
	env.environment.adjustment_saturation = 2 * config["video_saturation"]
	env.environment.adjustment_contrast = 2 * config["video_contrast"]

func save_game():
	#prepares the file
	var saves = File.new()
	saves.open("user://config.save", File.WRITE)
	
	#save game node stuff
	saves.store_line(to_json(config))
	print("game saved! " + str(config))
	
	saves.close()
	#emit_signal("finish_save")


func load_game():
	var save_game = File.new()
	if not save_game.file_exists("user://config.save"):
		return # Error! We don't have a save to load.

	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	save_game.open("user://config.save", File.READ)

	# Get the saved dictionary from the next line in the save file
	var node_data = parse_json(save_game.get_line())
	
	config = node_data

	save_game.close()
	print("loaded! " + str(config))
	emit_signal("finish_load")
	
	


func lang():
	propagate_call("reload_lang")
	


