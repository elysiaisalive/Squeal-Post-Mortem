/// @desc Saves the current game progress to the currently selected save slot
/// @param {int} ?slot
function save_progress( _slot = -1 ) {
	if ( _slot != -1 ) {
    	global.current_saveslot = _slot;
	}
	
    if ( directory_exists( SAVE_PATH + $"profile_0{global.current_saveslot}" ) ) {
        var _current_directory = SAVE_PATH + $"profile_0{global.current_saveslot}";
        var _current_file = _current_directory + $"/0{global.current_saveslot}.squeal";
        var _temp_buffer = buffer_create( 1, buffer_grow, 1 );
        
        buffer_seek( _temp_buffer, buffer_seek_start, 0 );
        
        try {
            var _player_stats = base64_encode( SnapToJSON( global.player_stats ) );
            
            buffer_write( _temp_buffer, buffer_string, _player_stats );
            buffer_write( _temp_buffer, buffer_u8, global.difficulty );
            buffer_write( _temp_buffer, buffer_u8, global.current_chapter );
            
            buffer_save( _temp_buffer, _current_file );
            buffer_delete( _temp_buffer );
            
            global.current_save = _current_file;
            
	        eventhandler_publish( "ev_savedprogress" );
            print( $"Save Progress success in slot {global.current_saveslot}" );
        }
        catch(e) {
            print( $"Error saving progress in slot {global.current_saveslot}" );
        }
    }
    else {
        directory_create( SAVE_PATH + $"{global.current_saveslot}" );
    }
}