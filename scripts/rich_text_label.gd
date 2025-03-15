extends RichTextLabel

var message = "This is a text, which will be told by a narrator.\nThere is absolutely nothing you need to worry about, it's just gonna work."
var cascading_delay = 0.05
var char_timers

func _ready():
	bbcode_enabled = true
	text = message
	fade_text(message, cascading_delay)

func fade_text(string, cascading_delay):
	char_timers = []
	var i = 0
	
	for char in string:
		char_timers.append ({
			letter   = char,
			delay    = cascading_delay * i,
		})
		
		i += 1

func _process(delta):
	text = ""
	for c_timer in char_timers:
		var color   = Color(1,1,1,1)

		if(c_timer.delay > 0.0):
			c_timer.delay -= delta
			color.a = 0.0

		text += '[color=#' + color.to_html() + ']' + c_timer.letter + '[/color]'
