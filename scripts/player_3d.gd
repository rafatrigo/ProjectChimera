extends CharacterBody3D

@export_group("Camera")
@export_range(0.0, 1.0) var mouse_sensitivity := 0.25

@export_group("Movement")
@export var move_speed := 8.0
@export var acceleration := 20.0
@export var rotation_speed := 12.0

var _camera_input_direction := Vector2.ZERO
var _last_movement_direction := Vector3.BACK

@onready var _camera_pivot: Node3D = %CameraPivot
@onready var _camera: Camera3D = %Camera3D
@onready var _skin: Node3D = %RobotSkin

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		else:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			
func _unhandled_input(event: InputEvent) -> void:
	var is_camera_motion := (
		event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	)
	
	if is_camera_motion:
		_camera_input_direction = event.screen_relative * mouse_sensitivity
		
func _physics_process(delta: float) -> void:
	## CAMERA ##
	# vetical rotation
	_camera_pivot.rotation.x += _camera_input_direction.y * delta
	
	#horizontal rotation
	_camera_pivot.rotation.y -= _camera_input_direction.x * delta
	
	# prevent the camera to roll over the player
	_camera_pivot.rotation.x = clamp(_camera_pivot.rotation.x, -PI / 6.0, PI / 3.0)
	
	# reset the moving direction to zero, preventing the camera to keep moving
	_camera_input_direction = Vector2.ZERO
	
	## MOVEMENT ##
	
	var raw_input := Input.get_vector("move_left", "move_right", "move_front", "move_back")
	var forward := _camera.global_basis.z
	var right := _camera.global_basis.x
	
	var move_direction := forward * raw_input.y + right * raw_input.x
	move_direction.y = 0.0 # make sure that the character is moving parallel to the ground
	move_direction = move_direction.normalized()
	
	velocity = velocity.move_toward(move_direction * move_speed, acceleration * delta)
	
	move_and_slide()
	
	## SKIN MOVEMENT ##
	
	# store the last movement direction
	if move_direction.length() > 0.2:
		_last_movement_direction = move_direction
		
	var target_angle := Vector3.BACK.signed_angle_to(_last_movement_direction, Vector3.UP)
	_skin.global_rotation.y = lerp_angle(_skin.rotation.y, target_angle, rotation_speed * delta)
