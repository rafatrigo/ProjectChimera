extends CharacterBody3D

@onready var head = $CameraPivot
@onready var camera = $CameraPivot/Camera3D

const MOUSE_SENSITIVITY = 0.0005
const SPEED = 5.0
const RUN_MULTIPLIER = 2.0

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * MOUSE_SENSITIVITY)
		head.rotate_x(-event.relative.y * MOUSE_SENSITIVITY)
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-80), deg_to_rad(80))

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(_delta):
	var current_speed = SPEED
	if Input.is_action_pressed("running"):
		current_speed *= RUN_MULTIPLIER

	var input_y = Input.get_axis("move_down", "move_up");
	var input_dir = Input.get_vector("move_left", "move_right", "move_front", "move_back")

	var direction = (transform.basis * Vector3(input_dir.x, input_y, input_dir.y)).normalized()

	velocity = direction * current_speed

	move_and_slide()
