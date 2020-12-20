extends Spatial

const COOLDOWN = 2.5;
const DELAY = 1.7;
const UI_OPEN = "Open door";
const UI_CLOSE = "Close door";

var delay = 0
var opened = false;
var canInteract = false;
var cooldown = 0;

onready var pivot = $Pivot;
onready var animation = $Animation;

var open;

var close;

# Called when the node enters the scene tree for the first time.
func _ready():
	open = AudioStreamPlayer.new();
	close = AudioStreamPlayer.new();

	add_child(open);
	add_child(close);

	open.set_volume_db(2);
	close.set_volume_db(2);
	
	open.stream = load("res://Audio/open.wav");
	close.stream = load("res://Audio/close.wav");
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	cooldown -= delta;
	
	if(delay > 0):
		delay -= delta;
		if(delay <= 0):
			close.play();
			
	if(!canInteract):
		return;
		
	if(cooldown > 0):
		return;
		
	if(Input.is_action_pressed("interact")):
		match opened:
			true: 
				animation.play("DoorClose");
				opened = false;
				cooldown = COOLDOWN;
				delay = DELAY;
				Global.updateUI(UI_OPEN);
				print(3)
			false: 
				animation.play("DoorOpen");
				opened = true;
				cooldown = COOLDOWN;
				open.play();
				Global.updateUI(UI_OPEN);

func _on_Area_body_entered(body):
	if(!Global.doorsActive):
		return;
		
	if(body.name == Global.PLAYER_NAME):
		canInteract = true;
		
	match opened:
		true:
			Global.updateUI(UI_CLOSE);
		false:
			Global.updateUI(UI_OPEN);

func _on_Area_body_exited(body):
	if(!Global.doorsActive):
		return;
		
	if(body.name == Global.PLAYER_NAME):
		canInteract = false;
		
	Global.updateUI("");
