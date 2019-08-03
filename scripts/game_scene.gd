extends Node2D

signal message_changed(message)
signal typed_message_on_lose(typed_message)

# NODES
onready var timer_Bomb = get_node("timer_Bomb") # Timer to detect dot or dash

# List of posible words
var posible_words = [
	"peace", 
	"surrender", 
	"help", 
	"evacuate", 
	"spare", 
	"mercy",
	"troops",
	"soldiers",
	"defense",
	"tanks",
	"strategy",
	"bomb"
]
var message = "peace" # Word that stops the bomb and wins the game

var bomb_time_in_seconds = 10 # Change to 60
var boom = false # If boom is true, you lost the game
var menu_input_chain = "" # Input after releasing for one second
var input_message = "" # Message written so far
var game_started = false
var lock_telegraph = false

# TO DO: music
var MUSIC_MENU = load("res://music/music_menu.ogg")
var MUSIC_WIN = load("res://music/music_win.ogg")
var MUSIC_LOSE = load("res://music/music_lose.ogg")
#var MUSIC_BG = load("")

func _ready():
	#TO DO random messages
	randomize()
	
	get_node("Game_UI").visible = false
	get_node("Menu_UI").visible = true
	get_node("GameOver_UI/Win").visible = false
	get_node("GameOver_UI/Lose").visible = false
	timer_Bomb.set_wait_time(5000000)
	timer_Bomb.start()
	
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	
	if(menu_input_chain == ".-.--" and not game_started):
		start_game()
	
	if(game_started):
		check_win_condition()
		check_lose_condition()
	
	if(Input.is_key_pressed(KEY_ESCAPE)):
		get_tree().quit()
	
	pass

func new_message():
	message = posible_words[int(rand_range(0, posible_words.size()-1))]
	emit_signal("message_changed", message)

func start_game():
	new_message()
	timer_Bomb.set_wait_time(bomb_time_in_seconds)
	timer_Bomb.start()
	boom = false
	game_started = true
	lock_telegraph = false
	get_node("Game_UI").visible = true
	get_node("Menu_UI").visible = false
	get_node("GameOver_UI/Win").visible = false
	get_node("GameOver_UI/Lose").visible = false
	get_node("Background/fx_background_war").play()

func stop_game():
	get_node("Game_UI").visible = false
	get_node("Menu_UI").visible = false
	timer_Bomb.stop()
	boom = false
	game_started = false
	input_message = ""
	lock_telegraph = true
	get_node("Background/fx_background_war").stop()
	get_node("Background/music_player").stop()
	

func check_win_condition():
	if(input_message == message):
		get_node("GameOver_UI/Win").visible = true
		stop_game()

func check_lose_condition():
	if(boom):
		get_node("GameOver_UI/Lose").visible = true
		emit_signal("typed_message_on_lose", input_message)
		stop_game()

func _on_timer_Bomb_boom():
	boom = true


func _on_Telegrafo_input_message_updated(mess):
	input_message = mess


func _on_Telegrafo_menu_input_chain_updated(m_i_c):
	menu_input_chain = m_i_c
