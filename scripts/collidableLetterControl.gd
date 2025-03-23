extends RigidBody2D

const max_snap_force := 3000.0
const snap_force_multiplier := 300.0

var held: bool = false

func _ready():
	input_event.connect(_on_input_event)

func _on_input_event(_viewport, input, _shape_idx):
	if input.is_action_type():
		if input.is_pressed():
			held = true

func _physics_process(delta: float):
	if not Input.is_mouse_button_pressed(MouseButton.MOUSE_BUTTON_LEFT):
		held = false
	if held:
		var mouse_dir = Global.mouse_pos() - position
		apply_force(mouse_dir.normalized() * 
			clamp(mouse_dir.length() ** 2.4 * snap_force_multiplier, 0, max_snap_force))
