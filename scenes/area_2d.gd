extends Area2D

signal collected

@onready var animationPlayer = get_child(0)
@onready var particles = get_child(1) 

var hasEntered = false

func _on_body_entered(body):
	if body.is_in_group("player") and not hasEntered:
		particles.set_emitting(false)
		animationPlayer.play("disappear")
		hasEntered = true
