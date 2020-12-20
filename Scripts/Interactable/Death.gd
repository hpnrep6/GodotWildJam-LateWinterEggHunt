extends Spatial

onready var animation = $Animation;

# Called when the node enters the scene tree for the first time.
func _ready():
	animation.play("DeathRun");
	animation.get_animation("DeathRun").set_loop(true);
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
