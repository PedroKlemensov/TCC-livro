extends Node2D

@export var  mensagens : Array[String] = [] 

@onready var label = $Area2D/Panel/Label
@onready var panel = $Area2D/Panel

@onready var cunrret_index := 0

func _print():
	print("alo")

func _ready():
	label.text = mensagens[cunrret_index]

func _on_interation():
	_print()
	if cunrret_index >= mensagens.size() -1 :
		cunrret_index = 0
		label.text = mensagens [cunrret_index]
	else:
		cunrret_index += 1
		panel.visible = true
		label.visible = true
		label.text = mensagens[cunrret_index]


