extends Area2D

@export var messages : Array[String] = []

@onready var mensagem_diario = %mensagem_diario
@onready var panel = $Panel

@onready var current_message_index := 0

func _ready():
	mensagem_diario.text = messages[current_message_index]
	
func _on_player_interaction():
	if current_message_index >= messages.size() -1:
		current_message_index = 0
		mensagem_diario.text = messages[current_message_index]
	else:
		current_message_index += 1
		panel.visible = true
		mensagem_diario.visible = true
		mensagem_diario.text = messages[current_message_index]
func _unhandled_input(event):
	if(event.is_action_pressed("ui_cancel")):
		panel.visible = false
		mensagem_diario.visible = false
