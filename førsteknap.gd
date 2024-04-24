extends Button


func _on_Button_pressed():
	$"../videosound".play()
	$"../flash".show()
	$"../Timer".start()
	$"../motorsound".play()
	

func _on_Timer_timeout():
	get_tree().change_scene("res://login 2.tscn")
