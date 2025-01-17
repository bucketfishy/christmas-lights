extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var line = {
	"":[],

	"silver_intro":[
		["s", "SILVER_INTRO_1", "NAME_SILVER"],
		["s", "SILVER_INTRO_2", "NAME_SILVER"],
		["s", "SILVER_INTRO_2a", "NAME_RAIN"],
		["s","SILVER_INTRO_3", "NAME_SILVER"],
		["s","SILVER_INTRO_4", "NAME_SILVER"],
		["s","SILVER_INTRO_4a", "NAME_RAIN"],
		["s","SILVER_INTRO_5", "NAME_SILVER"],
		["s","SILVER_INTRO_6", "NAME_SILVER"],
		["a", "get_item", "berry", 5],
		["e", "silver_give1"]
	],
	"silver_intro_repeat1":[
		["s", "SILVER_INTRO_REPEAT1_1", "NAME_SILVER"],
		["a", "get_notebook", "doodle2_3"]
	],
	"silver_intro_repeat2":[
		["s", "SILVER_INTRO_REPEAT2_1", "NAME_SILVER"]
	],
	
	"sage_intro":[
		["s", "SAGE_INTRO_1", "NAME_SAGE"],
		["s", "SAGE_INTRO_1a", "NAME_RAIN"],
		["s", "SAGE_INTRO_2", "NAME_SAGE"],
		["c", "give_berry", 1, "sage_introgift", "sage_introgiftcancel", "NAME_SAGE"]
	],
	
	"sage_introrepeat":[
		["s", "SAGE_INTROREPEAT_1", "NAME_SAGE"],
		["c", "give_berry", 1, "sage_introgift", "sage_introgiftcancel", "NAME_SAGE"]
	],
	
	"sage_introgift":[
		["a", "get_item", "berry", -1],
		["s", "SAGE_INTROGIFT_1", "NAME_SAGE"],
		["s", "SAGE_INTROGIFT_1a", "NAME_RAIN"],
		["a", "get_acc", "plant"],
		["s", "SAGE_INTROGIFT_2", "NAME_SAGE"],
		["s", "SAGE_INTROGIFT_3", "NAME_SAGE"],
		["s", "SAGE_INTROGIFT_3a", "NAME_RAIN"],
		["s", "SAGE_INTROGIFT_4", "NAME_SAGE"],
		["s", "SAGE_INTROGIFT_5", "NAME_SAGE"],
		["e", "dialogue_nextline"]
	],
	
	"sage_introgiftcancel":[
		["s", "SAGE_INTROGIFTCANCEL_1a", "NAME_RAIN"]
	],
	
	"sage_introgiftrepeat":[
		["s", "SAGE_INTROGIFTREPEAT_1", "NAME_SAGE"]
	],
	
	'berrymover1':[
		["c", "insert_berry", 15, "berrymover1_accept", ""]
	],
	"berrymover1_accept":[
		["a", "get_item", "berry", -15],
		["a", "get_notebook", "doodle3_2"]
	],
	
	"fir_intro":[
		["s", "FIR_INTRO_1", "NAME_FIR"],
		["s", "FIR_INTRO_2", "NAME_FIR"],
		["s", "FIR_INTRO_3", "NAME_FIR"],
		["c", "give_berry", 5, "fir_aftersled", "", "NAME_FIR"]
	],
	
	"fir_beforesled":[
		["s", "FIR_BEFORESLED_1", "NAME_FIR"],
		["c", "give_berry", 5, "fir_aftersled", "", "NAME_FIR"]
	],
	
	"fir_aftersled":[
		["a", "get_ability", "slide"],
		["e", "sled_disappear"],
		["s", "FIR_AFTERSLED_1", "NAME_FIR"],
		["s", "FIR_AFTERSLED_2", "NAME_FIR"],
		["s", "FIR_AFTERSLED_3", "NAME_FIR"],
	],
	
	"fir_nothing":[
		["s", "FIR_NOTHING_1", "NAME_FIR"],
		["s", "FIR_NOTHING_2", "NAME_FIR"],
	]
}
