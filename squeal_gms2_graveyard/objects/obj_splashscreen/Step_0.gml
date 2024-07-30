// Skip Button
if mouse_check_button_pressed(mb_any) {
	skip = true;
	done = true;
	splash_timer = 0;
	splash_alpha = 0;
	//room_goto_next();
	
	if ( globalflags_get( GLOBALFLAGS.IDE ) ) { room_goto( rm_debug ); };
	
	//audio_stop_sound(snd_ui_computer_bootup);
	//playsound(snd_ui_computer_loop, true)
	//audio_sound_gain(snd_ui_computer_loop, 0.1, 0);
	println("Skipping!")
}

#region PC Timer
pc_timer = min(pc_timer - 1)

if pc_timer <= 0 {
	pc_on = true;
}
#endregion

#region Timers
if !done {
	splash_alpha = max(0, splash_alpha + 0.01);
}

if !done && splash_timer == 0
	splash_timer = 60 * 2

if splash_alpha == 1 {
	done = true;
	if pc_on
		splash_timer = max(0, splash_timer - 1);
}

if splash_alpha == 0
	done = false;

if done && splash_timer == 0 {
	splash_alpha = max(0, splash_alpha - 0.01);	
}
#endregion

animate += 0.2
animate = clamp(animate, 0, 7);
splash_alpha = clamp(splash_alpha, 0, 1);
splash_timer = clamp(splash_timer, 0, 60 * 3);
looptime = clamp(looptime, 0, looptimemax)
pc_timer = clamp(pc_timer, 0, pc_timermax)
splash_screen = floor(splash_screen);