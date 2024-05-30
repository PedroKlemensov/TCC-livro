extends Area2D

# Export variables to define the target position for teleportation
@export var target_position: Vector2

# Variable to hold the reference to the player
var player = null

# Define custom signals
signal player_entered
signal player_exited

# Function to detect when a body enters the teleporter area
func _on_body_entered(body):
	if body.is_in_group("Player"):
		player = body
		emit_signal("player_entered", self)

# Function to detect when a body exits the teleporter area
func _on_body_exited(body):
	if body.is_in_group("Player"):
		player = null
		emit_signal("player_exited", self)

# Function to teleport the player
func teleport_player():
	if player:
		player.global_position = target_position

# Connect signals
func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))
