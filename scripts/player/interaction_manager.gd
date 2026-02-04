extends Node3D

@onready var shape_cast = $ShapeCast3D

func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("player_interact")):
		check_interaction()

func _process(_delta: float) -> void:
	pass

func check_interaction():
	if shape_cast.is_colliding():

		var closest_obj = null;
		var shortest_dist = INF;

		for i in shape_cast.get_collision_count():
			var collider = shape_cast.get_collider(i);

			var dist = global_position.distance_squared_to(collider.global_position)

			if dist < shortest_dist:
				shortest_dist = dist
				closest_obj = collider

		if closest_obj.has_method("interact"):
			closest_obj.interact()
		else:
			push_warning("object marked as interactable has no method interact(). Obj name: " + closest_obj.name + " Warning from: " + self.name)
