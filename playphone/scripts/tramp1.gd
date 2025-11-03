extends Area2D

@export var boost_strength: float = 120.0  # how high it launches


func _ready() -> void:
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)


var b = null


func _on_body_entered(body):
	if body is CharacterBody2D:
		b = body


func _on_body_exited(body):
	if body is CharacterBody2D:
		b = null


func _process(_delta: float) -> void:
	if b != null:
		b.velocity.y = -boost_strength
