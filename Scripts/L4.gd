extends Spatial

var triggered = false;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Area_body_entered(body):
	if(body.name == Global.PLAYER_NAME):
		if(!triggered):
			Global.trigDeath();
			triggered = true;
