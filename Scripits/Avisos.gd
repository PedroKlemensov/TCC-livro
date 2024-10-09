extends Area2D

@export var mensagens : Array[String] = []

@onready var label = $Panel/Label
@onready var panel = $Panel



var player = null


func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))
	panel.visible = false
	

signal player_entered
signal player_exited

# Function to detect when a body enters the teleporter area
func _on_body_entered(body):
	if body.is_in_group("Player"):
		player = body
		panel.visible =true
		emit_signal("player_entered", self)

# Function to detect when a body exits the teleporter area
func _on_body_exited(body):
	if body.is_in_group("Player"):
		player = null
		panel.visible =false
		emit_signal("player_exited", self)
		
