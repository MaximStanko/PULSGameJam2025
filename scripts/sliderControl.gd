extends AnimatableBody2D

signal value_changed(value: float)

@onready var slider_ui: HSlider = get_child(0).get_child(0)
@onready var slider_collider: CollisionShape2D = get_child(1)
@onready var slider_unfilled: StyleBox = slider_ui.get_theme_stylebox("slider")
@onready var slider_filled: StyleBox = slider_ui.get_theme_stylebox("grabber_area")

@export var fills_up: bool = false

func _ready():
	slider_collider.fills_up = fills_up
	value_changed.emit(self.get_value())
	if not fills_up:
		slider_ui.add_theme_stylebox_override("grabber_area", slider_unfilled)
		slider_ui.add_theme_stylebox_override("grabber_area_highlight", slider_unfilled)

func get_value():
	return slider_ui.value

func _on_slider_value_changed(value: float):
	value_changed.emit(value)
