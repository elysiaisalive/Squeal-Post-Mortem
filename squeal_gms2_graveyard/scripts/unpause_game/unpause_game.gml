function unpause_game( unpause_rm = global.last_room ) 
{
	// Unpauses the game and removes the pause menu BG from memory
	global.pause = false;
	
	sprite_delete( global.pause_png );
	
	room_persistent = false;
	
	//instance_activate_object( obj_character );
	//instance_activate_object( obj_hud );
		
	room_goto( unpause_rm );
	music_unpause();
	
	println( "Unpaused" );	
}