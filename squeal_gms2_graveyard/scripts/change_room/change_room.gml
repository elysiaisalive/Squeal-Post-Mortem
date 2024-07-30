function change_floor( next_room, checkpoint = false )
{

	// Set the player to persistent when changing floors
	obj_player.persistent			= true;
	obj_hud.persistent				= true;
	obj_cursor.persistent			= true;
	obj_camera_control.persistent	= true;
	room_persistent					= true;
	
	room_goto( next_room );

	println( "Floor Changed to" + " " + "Room" + " [" + string( room_get_name( next_room ) ) + "] " );
}

function change_room( next_room )
{
	room_goto( next_room );
}