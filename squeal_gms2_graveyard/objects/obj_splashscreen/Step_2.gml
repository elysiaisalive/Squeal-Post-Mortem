if !done && splash_alpha == 0
	splash_screen ++
	
if splash_screen = 3 && splash_alpha == 0
	room_goto(rm_debug);