extends Spatial

const MAX_SIZE = 0.5;
const SCALE_SPEED = 0.4;

var farFromPlayer = true;
var scaleDir = 0;
var destroyed = false;

var sound;

	
onready var glow = $egg2;

func _process(delta):
	if(Global.eggGlow && farFromPlayer):
		if(glow.scale.x >= MAX_SIZE):
			scaleDir = -1;
		elif(glow.scale.x <= 0):
			scaleDir = 1;
			
		var scaleby = SCALE_SPEED * delta * scaleDir;
		
		glow.scale += Vector3(scaleby, scaleby, scaleby);
	else:
		glow.scale = Vector3(0,0,0);
	
		
func _on_Area_body_entered(body):
	if(body.name == Global.PLAYER_NAME && !destroyed):
		destroyed = true;
		Global.foundEgg();
		queue_free();

func _on_Area2_body_exited(body):
	if(body.name == Global.PLAYER_NAME):
		farFromPlayer = true;



func _on_Area2_body_entered(body):
	if(body.name == Global.PLAYER_NAME):
		farFromPlayer = false;
