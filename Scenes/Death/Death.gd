extends KinematicBody

const TURN_TIME = 3;
const SPEED_1 = 600;
const SPEED_2 = 250;

onready var TURN_STEP = PI / TURN_TIME;

var nodes = [];
var node = 0;

var triggered = false;
var triggering = false;
var triggerTime = 0;

var speed = SPEED_1;

onready var animation = $Off/Death/Animation;
onready var timer = $Timer;

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.connect("triggerDeath", self, "trigger");
	animation.get_animation("DeathRun").set_loop(true);
	pass # Replace with function body.

func trigger():
	animation.play("DeathRun");
	triggering = true;

func _physics_process(delta):
	if(triggering && !triggered):
		rotation.y += TURN_STEP * delta;
		triggerTime += delta;
		if(triggerTime > TURN_TIME):
			timer.start();
			triggered = true;
		return;
	
	if(!triggered):
		return;		
			
	match(Global.level):
		4:
			speed = SPEED_1;
		5: 
			speed = SPEED_2;
			
	if(node < nodes.size()):
		var dir = (nodes[node] - global_transform.origin);
		if(dir.length() < 3):
			node += 1;
		else:
			move_and_slide(dir.normalized() * speed * delta, Vector3.UP);
			
	if(Global.player != null):
		look_at(Global.player.global_transform.origin, Vector3.UP);
		rotation = Vector3(0, rotation.y, 0);

func moveTo(target):
	nodes = Global.nav.get_simple_path(global_transform.origin, target);
	node = 0;

func _on_Timer_timeout():
	moveTo(Global.player.global_transform.origin);


func _on_Area_body_entered(body):
	if(body.name == Global.PLAYER_NAME):
		match Global.level:
			4:
				Global.blinded = true;
			5:
				Global.dead = true;
		Global.eggCount = 0;
