extends TextureButton

@export var scenePath: String

func _ready():
	pressed.connect(Callable(self, "change_scene"))

func change_scene():
	Global.goto_scene(scenePath)
