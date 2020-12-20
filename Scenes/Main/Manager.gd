extends Spatial

onready var L1 = load("res://Scenes/Main/Levels/L1.tscn").instance(); 
onready var L2 = load("res://Scenes/Main/Levels/L2.tscn").instance();
onready var L3 = load("res://Scenes/Main/Levels/L3.tscn").instance();
onready var L4 = load("res://Scenes/Main/Levels/L4.tscn").instance();
onready var L5 = load("res://Scenes/Main/Levels/L5.tscn").instance();

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.env = $WorldEnvironment;
	add_child(L1);
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Global.eggCount <= 0):
		Global.nextLevel();
	pass

func initNextLevel():
	match(Global.level):
		1:
			L1.queue_free();
			add_child(L2);
			Global.totalEggs = Global.L2_EGGS;
		2: 
			L2.queue_free();
			add_child(L3);
			Global.totalEggs = Global.L3_EGGS;
		3:
			L3.queue_free();
			add_child(L4);
			Global.totalEggs = Global.L4_EGGS;
		4:
			L4.queue_free();
			add_child(L5);
			Global.totalEggs = Global.L5_EGGS;
		5:
			match(Global.dead):
				true:
					get_tree().change_scene("res://Scenes/DeathScreen.tscn");
					
				false:
					get_tree().change_scene("res://Scenes/Win.tscn");
			return;

	Global.level += 1;
