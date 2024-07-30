if ( global.room_clean )
{
	var _level = global.level.lvl;
	
	if ( _level )
	{
		room_persistent = false;
		println( "Resetting Room [" + room_get_name( room ) + "]" );
		
		if ( room_clean_index < array_length( _level._floors ) )
		{
			room_goto( _level._floors[room_clean_index][0] );
			room_clean_index++;
		}
		else {
			audio_cleanup();
			
			global.room_clean = false;
			room_persistent = false;
			room_clean_index = 0;
			room_goto( global.exit_room );
			_level.ExitLevel();
		}
	}
	else
	{
		println( "Failed to clean rooms" );
	}
}