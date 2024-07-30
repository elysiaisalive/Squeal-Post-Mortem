gui().Tick();

// pause on focus loss
// if ( os_is_paused() && instance_exists( obj_player ) )
// {
// 	pause_game();
// }

// block input when tabbed out
global.input_blocked = false;

if ( !window_has_focus() ) {
	global.input_blocked = true;
}

// Lock the mouse inside of the window
if ( ( global.input_mouse_lock ) && !( global.input_blocked ) && DoMouseLock() ) {
	display_mouse_lock( window_get_x(), window_get_y(), window_get_width(), window_get_height() );
}
else {
	display_mouse_unlock();
};

#region R to Restart
// move this to objIngame when not lazy
if ( instance_exists( obj_player ) 
&& obj_player.char_state == CSTATE.DEAD ) {
	if ( input_check_pressed( "key_restart" ) ) {
		
		with( obj_audio ) {
			CullSound( room_width + room_height );
		}
	
		room_persistent					= false;
		
		timescale = 1;
		gamestate_tempload();
	};
};

if ( screen_alpha > 0 )
{
	screen_alpha = max( 0, screen_alpha - 0.01 );
}

#endregion