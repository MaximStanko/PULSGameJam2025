extends StaticBody2D

signal was_pressed

@onready var button: TextureButton = get_child(0).get_child(0)
@onready var collider: CollisionShape2D = get_child(1)

@export var togglable: bool = false
@export var normalTexture: Texture2D
@export var pressedTexture: Texture2D
@export var hoverTexture: Texture2D

func _ready():
	button.toggle_mode = togglable
	button.set_texture_normal(normalTexture)
	button.set_texture_pressed(pressedTexture)
	button.set_texture_hover(hoverTexture)

func _on_area_entered(area):
	if area.is_in_group("playerFeet"):
		button.set_texture_normal(hoverTexture) 

func _on_area_exited(area):
	if area.is_in_group("playerFeet"):
		button.set_texture_normal(normalTexture) 

func get_size():
	return collider.shape.extents

func _on_button_pressed():
	was_pressed.emit()
