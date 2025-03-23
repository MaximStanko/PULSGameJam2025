extends Control

const narrator_prefab = preload("res://assets/prefabs/narrator.tscn")
const narrator_audio_manager_prefab = preload("res://assets/prefabs/narratorAudioManager.tscn")

const narrator_fieldsize := Vector2(340, 40)
const narrator_position := Vector2(23, 23)

var narrator
var audio_manager

func _ready():
	z_index = 10
	initialize_narrator()

func initialize_narrator():
	if get_children().size() == 0:
		narrator = narrator_prefab.instantiate()
		add_child(narrator)
		narrator.size = narrator_fieldsize
		narrator.position = narrator_position
		
		audio_manager = narrator_audio_manager_prefab.instantiate()
		add_child(audio_manager)
		
		narrator.character_printed.connect(play_next_narrator_sound)

func narrate(string: String, conditional := (func (): return true), clear_delay := -1.0, cascading_delay := 0.05):
	if conditional.call():
		var narrating_timer = narrator.narrate(string, cascading_delay)
		if clear_delay > 0:
			delayed_clear_string(narrating_timer, clear_delay, string)
		return narrating_timer
	return Global.delay(0.01)

func clear():
	narrator.clear()

func delayed_clear_string(narrating_timer, wait_delay, string):
	await narrating_timer
	await Global.delay(wait_delay)
	if string == narrator.get_current_string():
		clear()

func play_next_narrator_sound(char: String):
	audio_manager.play_sound(char)

func move_to_position(pos: Vector2):
	narrator.position = pos

func reset_position():
	narrator.position = narrator_position

func set_volume(volume_percentage: float):
	audio_manager.volume_db = (1.0 - volume_percentage) * (-80)
