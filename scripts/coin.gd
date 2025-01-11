extends Area2D

@onready var manager = %Manager
@onready var animation_player = $AnimationPlayer

func _on_body_entered(body):
	manager.addPoint()
	animation_player.play("pickup")
