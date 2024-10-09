extends Control

func resume():
	get_tree().paused = false
	$PanelContainer.visible = false  # Esconde o menu de pausa

# Esta função pausa o jogo
func pause():
	get_tree().paused = true
	$PanelContainer.visible = true  # Mostra o menu de pausa

# Esta função verifica o pressionamento da tecla "esc"
func testesc():
	if Input.is_action_just_pressed("pause"):
		print("Hello, Godot 4!")
		if get_tree().paused:
			resume()
		else:
			pause()




func _on_button_pressed():
	resume()
