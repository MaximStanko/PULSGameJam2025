extends AnimatableBody2D

signal value_changed(value: float)

@onready var slider_ui: HSlider = get_child(0).get_child(0)
@onready var slider_collider: CollisionShape2D = get_child(1)

@export var fills_up: bool = false

func _ready():
	slider_collider.fills_up = fills_up
	value_changed.emit(self.get_value())

func get_value():
	return slider_ui.value

func _on_slider_value_changed(value: float):
	value_changed.emit(value)
