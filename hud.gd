extends CanvasLayer

signal start_game


var start_time := 0
var timer_running := false


func _show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()


func _on_start_button_pressed():
	$StartButton.hide()
	$YellowScreen.hide()
	$MessageLabel.hide()
	$ScanLines.hide()

	start_time = Time.get_ticks_msec()
	timer_running = true

	$TimeLabel.text = "00:00.00"

	start_game.emit()


func _process(_delta):
	if timer_running:
		var elapsed = Time.get_ticks_msec() - start_time

		var minutes = elapsed / 60000
		var seconds = (elapsed / 1000) % 60
		var centiseconds = (elapsed / 10) % 100
		

		$TimeLabel.text = "%02d:%02d.%02d" % [
			minutes,
			seconds,
			centiseconds
		]

func stop_timer():
	timer_running == false

func _on_message_timer_timeout():
	$MessageLabel.hide()
	
func time() -> String:
	return $TimeLabel.text 
	
