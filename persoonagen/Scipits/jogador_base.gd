extends CharacterBody2D

var _state_machine
@export var pause_menu_scene: PackedScene
@export_category("Variables")
@export var _move_speed: float = 64.0
@export var _animation_tree: AnimationTree = null
@onready var tuturial = %Tuturial
@onready var area = $Area




# Variable to hold the reference to the current teleporter
var current_teleporter = null

func _ready() -> void:
	_state_machine = _animation_tree["parameters/playback"]
	# Connect to the custom signals of teleporters
	for teleporter in get_tree().get_nodes_in_group("Teleporter"):
		teleporter.connect("player_entered", Callable(self, "on_teleporter_entered"))
		teleporter.connect("player_exited", Callable(self, "on_teleporter_exited"))

func _physics_process(_delta: float) -> void:
	_move()
	_animate()

func _move() -> void:
	var _direction: Vector2 = Vector2(
		Input.get_axis("move_leaft", "move_right"),
		Input.get_axis("move_up", "move_down")
	)
	
	if _direction != Vector2.ZERO:
		_animation_tree["parameters/idle/blend_position"] = _direction
		_animation_tree["parameters/walk/blend_position"] = _direction
	
	velocity = _direction.normalized() * _move_speed
	move_and_slide()

func _animate() -> void:
	if velocity.length() > 2:
		_state_machine.travel("walk")
		return
	_state_machine.travel("idle")

# Function to detect input
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interacao") and current_teleporter:
		current_teleporter.teleport_player()
	if Input.is_action_just_pressed("interacao"):
		var exit_area = area.get_overlapping_areas()
		for tuturial in exit_area:
			if tuturial.is_in_group("Tuturial"):
				tuturial._on_interation()

# Function to detect when the player enters a teleporter area
func on_teleporter_entered(teleporter: Area2D) -> void:
	current_teleporter = teleporter

# Function to detect when the player exits a teleporter area
func on_teleporter_exited(teleporter: Area2D) -> void:
	if current_teleporter == teleporter:
		current_teleporter = null
