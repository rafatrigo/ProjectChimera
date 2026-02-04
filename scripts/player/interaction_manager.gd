extends Node3D

@onready var interaction_ray = $RayCast3D

func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("player_interact")):
		check_interaction()

func _process(_delta: float) -> void:
	pass

func check_interaction():
	if interaction_ray.is_colliding():
		var collider = interaction_ray.get_collider()
		if collider.has_method("interact"):
			collider.interact()
