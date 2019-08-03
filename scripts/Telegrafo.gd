extends Node2D

# SIGNALS
signal dot_or_dash(character)
signal input_chain_updated(input_chain)
signal input_message_updated(input_message)

# NODES
onready var timer_Telegraph_Dash = get_node("timer_Telegraph_Dash") # Timer to detect dot or dash
onready var timer_Telegraph_Clear_Input = get_node("timer_Telegraph_Clear_Input") # Timer to reset the character input
onready var fx_Telegraph = get_node("fx_Telegraph") # Timer to reset the character input

# CONSTANTS
const MESSAGE = "peace"
const morse_code = {
	"a": ".-", 
	"b": "-...", 
	"c": "-.-.", 
	"d": "-..", 
	"e": ".",
	"f": "..-.",
	"g": "--.",
	"h": "....",
	"i": "..",
	"j": ".---",
	"k": "-.-",
	"l": ".-..", 
	"m": "--",
	"n": "-.",
	"o": "---",
	"p": ".--.",
	"q": "--.-",
	"r": ".-.",
	"s": "...",
	"t": "-",
	"u": "..-",
	"v": "...-",
	"w": ".--",
	"x": "-..-",
	"y": "-.--",
	"z": "--..",
	"0": "-----",
	"1": ".----",
	"2": "..---",
	"3": "...--",
	"4": "....-",
	"5": ".....",
	"6": "-....",
	"7": "--...",
	"8": "---..",
	"9": "----.",
	".": "-.-.",
	",": "--..-",
	"?": "..--.",
}


# MECHANICS
const DOT_DASH_TIME_IN_SECONDS = 0.2 # This is the threshold between a dot and a dash
const INPUT_CLEAR_INTERVAL_IN_SECONDS = 1 # Idle time needed to clear the input
var input_pressed = false # Is it pressed now?
var current_input = "" # Current dot or dash
var input_chain = "" # Sequence of input dots and dashes.
var input_message = ""

# FX
var FX_TELEGRAPH_SHORT = load("res://fx/telegraph_short.ogg")
var FX_TELEGRAPH_LONG = load("res://fx/telegraph_long.ogg")


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	
	#print(morse_code.a)
	
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	
	# We detect and record the input here. Some timers are started here too.
	check_telegraph_input()
	
	# If the player is idle for a second, we clear the input chain and check if a letter was written.
	if(timer_Telegraph_Clear_Input.get_time_left() <= 0):
		check_input_is_correct()
		input_chain = ""
	
	pass

# Check if telegraph is pressed and figure out if it's a dot or a dash.
func check_telegraph_input():
	# Start press
	if(Input.is_action_just_pressed("telegrafo")):
		input_pressed = true
		
		# Set timer to detect dot or dash
		timer_Telegraph_Dash.set_wait_time(DOT_DASH_TIME_IN_SECONDS)
		timer_Telegraph_Dash.start()
		
		# Play long sound
		fx_Telegraph.set_stream(FX_TELEGRAPH_LONG)
		fx_Telegraph.play()
	
	# Finish press
	if(Input.is_action_just_released("telegrafo")):
		input_pressed = false
		# Reset input clearing timer to a second
		timer_Telegraph_Clear_Input.set_wait_time(INPUT_CLEAR_INTERVAL_IN_SECONDS)
		timer_Telegraph_Clear_Input.start()
		
		if(timer_Telegraph_Dash.get_time_left() <= 0): # Dash
			current_input = "-"
		else: # Dot
			# Stop sound earlier if it's a dot.
			fx_Telegraph.stop()
			current_input = "."
		
		input_chain += current_input
	
	emit_signal("dot_or_dash", current_input)
	emit_signal("input_chain_updated", input_chain)

# Check for successful input.
func check_input_is_correct():
	if(input_chain != ""):
		for key in morse_code:
			if(morse_code[key] == input_chain):
				input_message += key
				emit_signal("input_message_updated", input_message)
				break
			else:
				# input_chain is not a morse character 
				# print("Not found")
				pass