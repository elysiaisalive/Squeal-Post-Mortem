#region DEV
if (DEV) {
	if keyboard_check_direct(button) and window_has_focus() {
		if !(button_press) {
			button_press = true
			if (++global.camera_mode = e_cameraMode.length)
				global.camera_mode = 0
			if (global.camera_mode = e_cameraMode.perspective_firstperson) or (global.camera_mode = e_cameraMode.perspective_thirdperson)
				global.firstperson = true
			else
				global.firstperson = false
		}
	}
	else
		button_press = false
	
	
	if (global.camera_mode = e_cameraMode.perspective_thirdperson) {
		if mouse_wheel_up()
			thirdperson_distance = max(thirdperson_distance_min, thirdperson_distance - 8)
		if mouse_wheel_down()
			thirdperson_distance = min(thirdperson_distance_max, thirdperson_distance + 8)
	}
}
#endregion
