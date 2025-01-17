extends Node2D

export var spawns: int
export var scene_id = ""
export var notebookitem:String
onready var player = get_node("/root/game/player")
onready var rope = get_node("/root/game/rope")
onready var camera = get_node("/root/game/camera")
onready var base = get_node("/root/game")
onready var debug = get_node("/root/game/gui/debug")

export var totalitem = 0
export var color = 0

var item = [] setget set_item

signal change_done


var lastspawn = ""
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var colors = [
	"#b0b0b0",
	"#f37b81",
	"#ffca95",
	"#f8f296",
	"#93fa9f",
	"#85bfff",
	"#dd9aff"
]


# Called when the node enters the scene tree for the first time.
func _ready():
	
	$tilemap.modulate = colors[color]
	item = []
	for i in range(totalitem):
		item.append(float(i+1))
		get_node("item" + str(i+1)).connect("remove_item", self, "remove_item")
		get_node("item" + str(i+1)).number = float(i+1.0)
		
	print("scene load: item list " + str(item))
	base.connect("ready", self, "_on_finish_load")
	
	
	print(scene_id)
	print(base.scenes.keys())
	
	yield(base, "finish_load")
	
	if !(scene_id in base.scenes):
		#if it's first time visiting
		if notebookitem:
			get_node("/root/game/notebook/notebook").collected.append(notebookitem)
			get_node("/root/game/notebook/notebook").update_book()
			get_node("/root/game/gui/notif").show_notif("notebook")
	


func _on_finish_load():
	base.update_debug("room_name", scene_id)

	
	
		
func remove_item(id):
	print("item id " + str(id) + " picked up and gone! " + str(item))
	item.erase(float(id))
	print("item left: " + str(item))
	base.update_debug("item", item)
	
func set_item(val):
	#var new = []
	item = val.duplicate()
	print("save/load new item counts: " + str(item) + " on scene " + scene_id)
	base.update_debug("item", item)
	
	
func on_scene_change(id):
	for i in range(spawns):
		var spawn = get_node("spawn" + str(i+1))
		if spawn.id == id:
			print(id + ' -> ' + spawn.id)
			player.global_position = spawn.global_position
			rope.global_position = player.global_position + Vector2(-19, 15)
			#camera.global_position = player.global_position	
		lastspawn = id
	emit_signal("change_done")
			

func save():
	var save_dict = {
		"lastspawn": lastspawn,
		"item": item
	}
	return save_dict

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
