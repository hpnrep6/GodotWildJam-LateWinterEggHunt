extends Control

onready var fade = $Fade;

var timer = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	fade.color.a = 1;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(timer < 5):
		fade.color.a -= delta / 2;
	else:
		fade.color.a += delta / 2;
		
	if(timer > 13):
		get_tree().change_scene("res://Scenes/Title.tscn");
		
	timer += delta;
	
	
