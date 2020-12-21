extends Control

var startPos;
var lastLevel = 0;
var fading = false;

onready var player = get_parent();
onready var fade = $Fade;

onready var day = $Day;
onready var eggs =$Eggs;

func _ready():
	startPos = player.global_transform;
	Global.connect("next", self, "nextLevel");
	Global.connect("updateUI", self, "updateUI");
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(fading):
		fade.color.a += 1 * delta;
	else:
		fade.color.a -= 1 * delta;
	
	if(fade.color.a > 1):
		player.global_transform = startPos;
		fading = false;
		Global.transition = false;
		get_parent().get_parent().initNextLevel();
		
	if(fade.color.a < 0):
		fade.color.a = 0;
		
	day.text = "Day: " + str(Global.level);
	var eggcount = max(Global.totalEggs - Global.eggCount, 0);
	
	eggs.text = "Eggs: " + str(eggcount) + " / " + str(Global.totalEggs);

func nextLevel(level):
	fading = true;
	pass

func updateUI(message):
	pass
