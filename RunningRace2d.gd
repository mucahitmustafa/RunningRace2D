extends Node

func _ready():
	$ReplayGameButton.hide()
	pass

func end_game(winner):
	$PcPlayer.stop_player()
	$Player.stop_player()
	$ReplayGameButton.show()
	if winner == "PC":
		$ReplayGameButton.text = "You Lost! Replay Game"
	else:	
		$ReplayGameButton.text = "You Win! Replay Game"


func _on_StartGameButton_pressed():
	$StartGameButton.hide()
	$Player.start_game()
	$PcPlayer.start_player_if_not()


func _on_ReplayGameButton_pressed():
	$Player.go_to_start_line()
	$PcPlayer.go_to_start_line()
	$ReplayGameButton.hide()
	$Player.start_game()
	$PcPlayer.start_player_if_not()
