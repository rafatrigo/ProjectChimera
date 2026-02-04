extends CharacterBody3D

@export_group("Camera")
@export_range(0.0, 1.0) var mouse_sensitivity := 0.25

var _camera_input_direction := Vector2.ZERO

@onready var _camera_pivot: Node3D = %CameraPivot

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
	# vetical rotation
	_camera_pivot.rotation.x += _camera_input_direction.y * delta
	
	#horizontal rotation
	_camera_pivot.rotation.y -= _camera_input_direction.x * delta
	
	# prevent the camera to roll over the player
	_camera_pivot.rotation.x = clamp(_camera_pivot.rotation.x, -PI / 6.0, PI / 3.0)
	
	# reset the moving direction to zero, preventing the camera to keep moving
	_camera_input_direction = Vector2.ZERO
	
