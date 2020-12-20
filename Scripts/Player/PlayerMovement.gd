extends KinematicBody

const MAX_STEP_HEIGHT = .5;
const speed = 13; # 13

var acceleration = 10
var gravity = 50;
var jump = 15;

var mouseSensitivity = 0.1

var direction = Vector3()
var velocity = Vector3()
var fall = Vector3()

var footstep;
var footstepDelay = 0;

onready var head = $Head
onready var ray = $RayMin;
onready var rayMax = $RayMax;
onready var fade = $UI/Fade;

onready var rng = RandomNumberGenerator.new();

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);
	Global.player = self;
	footstep =  AudioStreamPlayer2D.new();
	footstep.set_volume_db(-3);
	add_child(footstep);
	footstep.stream = load("res://Audio/footstep.wav");

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouseSensitivity))
		head.rotate_x(deg2rad(-event.relative.y * mouseSensitivity))
		head.rotation.x = clamp(head.rotation.x, deg2rad(-90), deg2rad(90))

func _physics_process(delta):
	checkStep();
	movement(delta);

func checkStep():
	if(!is_on_floor()):
		return;
	if(ray.is_colliding() && !rayMax.is_colliding()):
		fall.y = 11;

func movement(delta):
	var hasMoved = false # variable to check if the player should be moving or not, prevents sliding down slopes (and stairs)
	var moveSpeed = speed
	
	direction = Vector3()
	if Input.is_action_pressed("moveForward"):
		hasMoved = true
		direction -= transform.basis.z
	elif Input.is_action_pressed("moveBackward"):
		hasMoved = true
		direction += transform.basis.z
	if Input.is_action_pressed("moveLeft"):
		hasMoved = true
		direction -= transform.basis.x
	elif Input.is_action_pressed("moveRight"):
		hasMoved = true
		direction += transform.basis.x
		
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			fall.y = jump
			hasMoved = true
	else:
		hasMoved = true
		fall.y -= gravity * delta

	direction = direction.normalized()
	velocity = velocity.linear_interpolate(direction * moveSpeed, acceleration * delta)
	if hasMoved == true:
		velocity = move_and_slide(velocity, Vector3.UP)
		move_and_slide(fall, Vector3.UP)
		playSound(delta);
		
func playSound(delta):
	footstepDelay -= delta;
	if(footstepDelay < 0):
		if(Global.basement):
			return;
		footstep.play();
		var x = rng.randf_range(0, 1920);
		footstep.set_position(Vector2(x, 0));
		footstepDelay = 0.3;
