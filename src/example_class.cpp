#include "example_class.hpp"

void ExampleClass::_bind_methods() {
	godot::ClassDB::bind_method(D_METHOD("print_type", "variant"), &ExampleClass::print_type);
	godot::ClassDB::bind_method(D_METHOD("sum", "a", "b"), &ExampleClass::sum);
}

void ExampleClass::print_type(const Variant &p_variant) const {
	print_line(vformat("Type: %d", p_variant.get_type()));
}

int64_t ExampleClass::sum(int64_t a, int64_t b) {
	return a + b;
}
