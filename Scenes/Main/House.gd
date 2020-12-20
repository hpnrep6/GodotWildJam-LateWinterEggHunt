extends Spatial

const MIN_DARK = 27;
const START_DARK = 200;
const DARK_SPEED = 50;

var playerIn = false;
var darkness = START_DARK;

func _ready():
	Global.connect("next", self, "resetDark");
	Global.nav = $Navigation;

func resetDark(level):
	darkness = START_DARK + 400;
	Global.env.environment.set_fog_depth_enabled(false);
	
func _process(delta):
	
	if(Global.env == null):
		return;
		
	if(Global.blinded):
		Global.env.environment.set_fog_depth_enabled(true);
		Global.env.environment.set_fog_depth_end(20);
		return;
	
	if(playerIn):
		Global.env.environment.set_fog_depth_enabled(true);
		darkness -= DARK_SPEED * delta;
		darkness = clamp(darkness, MIN_DARK, 200);
		
		Global.env.environment.set_fog_depth_end(darkness);
	else:
		darkness += DARK_SPEED * delta;
		darkness = clamp(darkness, MIN_DARK, 200);
		
		Global.env.environment.set_fog_depth_end(darkness);
		
	if(darkness >= 200):
		Global.env.environment.set_fog_depth_enabled(false);

func _on_Basement_body_entered(body):
	if(body.name == Global.PLAYER_NAME):
		Global.setBasement(true);
		playerIn = true;

func _on_Basement_body_exited(body):
	if(body.name == Global.PLAYER_NAME):
		Global.setBasement(false);
		playerIn = false;


