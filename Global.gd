extends Node

const PLAYER_NAME = "Player"
const L1_EGGS = 10; # 10
const L2_EGGS = 11; # 11
const L3_EGGS = 7; # 7
const L4_EGGS = 18; # 18
const L5_EGGS = 34; # 34

var env;

var doorsActive = true;

var eggCount = L1_EGGS;

var eggGlow = true;

var transition = false;

var level = 1;

var dead = false;

var blinded = false;

var nav;

var basement = false;

var player;

var music;

var bling;

var totalEggs = L1_EGGS;

func _ready():
	music = AudioStreamPlayer.new();
	music.stream = load("res://Audio/background.ogg");
	add_child(music);
	music.set_volume_db(-12);
	music.play();
	
	bling = AudioStreamPlayer.new();
	bling.stream = load("res://Audio/bling.wav");
	bling.set_volume_db(2);
	
	add_child(bling);

func reset():
	level = 1;
	dead = false;
	blinded = false;
	transition = false;
	doorsActive = true;
	eggGlow = true;
	eggCount = L1_EGGS;
	totalEggs = L1_EGGS;
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_pressed("ui_cancel")):
		get_tree().change_scene("res://Scenes/Title.tscn");

func foundEgg():
	eggCount -= 1;
	bling.play();

func nextLevel():

	match level:
		1:
			eggCount = L2_EGGS;
		2: 
			eggCount = L3_EGGS;
		3:
			eggCount = L4_EGGS;	
		4:
			eggCount = L5_EGGS;
		5: 
			eggCount = 1;
	emit_signal("next", level);
	transition = true;

func setBasement(inBasement):
	basement = inBasement;
	if(basement):
		music.stop();
	else:
		music.play();

func updateUI(message):
	emit_signal("updateUI", message);
	
func trigDeath():
	emit_signal("triggerDeath");
	
signal next(level);
	
signal updateUI(message);

signal triggerDeath();
