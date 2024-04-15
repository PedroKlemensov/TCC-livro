extends CharacterBody2D

var _state_machine

@export_category("Variables")
@export var _move_speed:float = 64.0

@export var _animation_tree: AnimationTree = null

func _ready() -> void:
	_state_machine = _animation_tree["parameters/playback"]
	

func _physics_process(_delta: float) -> void:
	_move()
	_animete()
	

func _move() -> void:
	var _direction: Vector2 = Vector2(
		Input.get_axis("move_leaft","move_right"),
		Input.get_axis("move_up","move_down")
	)
	
	if _direction != Vector2.ZERO:
		_animation_tree["parameters/idle/blend_position"] = _direction
		_animation_tree["parameters/walk/blend_position"] = _direction
	velocity = _direction.normalized() * _move_speed
	move_and_slide()
	prints(_direction)
func _animete() -> void:
	if velocity.length() >2:
		_state_machine.travel("walk")
		return
	_state_machine.travel("idle")

