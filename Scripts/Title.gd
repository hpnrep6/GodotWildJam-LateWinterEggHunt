extends Control

func _ready():
	Input.set_mouse_mode(Input.CURSOR_ARROW);
func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/Main/HouseMain.tscn");
	Global.reset();

