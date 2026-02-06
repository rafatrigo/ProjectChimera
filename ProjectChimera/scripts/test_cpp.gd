extends Node3D

func _ready() -> void:
	var example := ExampleClass.new()
	example.print_type("Hello")
	print(example.sum(1,2))
