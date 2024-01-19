# Joystick input with per axis dead zones. It's a little squared off at small inputs, but saves you from drift at small and large inputs

func handleInput():
	var left = Input.get_action_strength("ui_left")
	var right = Input.get_action_strength("ui_right")
	var up = Input.get_action_strength("ui_up")
	var down = Input.get_action_strength("ui_down")

	var horizontal = right - left
	var vertical = down - up
	var moveDirection = Vector2(horizontal, vertical).normalized()
	
	velocity = moveDirection * speed
