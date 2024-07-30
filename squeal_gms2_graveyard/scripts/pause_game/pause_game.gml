function pause_game( pause_rm = rm_pause ) 
{
	// Create a sprite from the application surface for the pause menu
	var _w = surface_get_width( application_surface );
	var _h = surface_get_height( application_surface );
	
	global.pause_png = sprite_create_from_surface( application_surface, 0, 0, _w, _h, false, false, 0, 0 );
	
	sprite_save( global.pause_png, 0, APPDATA_PATH + "pause_temp.png" );
	
	global.pause = true;
	global.last_room = room;
	
	room_persistent = true;
	music_pause();
	
	room_goto( pause_rm );
	
	println( "Paused" );
}