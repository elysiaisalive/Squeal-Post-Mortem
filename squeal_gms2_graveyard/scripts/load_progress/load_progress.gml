/// @desc Loads the current game progress to the currently selected save slot
/// @param {int} ?slot
function load_progress( _slot = -1 ) {
    var _save_buffer = -1;
    
	if ( _slot != -1 ) {
    	global.current_saveslot = _slot;
	}

    if ( directory_exists( SAVE_PATH + $"profile_0{global.current_saveslot}" ) ) {
        var _current_directory = SAVE_PATH + $"profile_0{global.current_saveslot}";
        var _current_file = _current_directory + $"/0{global.current_saveslot}.squeal";
        
        print( $"Attempting Load Progress in slot {global.current_saveslot}" );
        _save_buffer = buffer_load( _current_file );
    }
    else {
        directory_create( SAVE_PATH + $"profile_0{global.current_saveslot}" );
    }
    
    buffer_seek( _save_buffer, buffer_seek_start, 0 );
    
    try {
        global.player_stats = SnapFromJSON( base64_decode( buffer_read( _save_buffer, buffer_string ) ) );
        global.difficulty = buffer_read( _save_buffer, buffer_u8 );
        global.current_chapter = buffer_read( _save_buffer, buffer_u8 );
        
	    eventhandler_publish( "ev_loadprogress" );
        print( $"Load Progress success in slot {global.current_saveslot}" );
    }
    catch(e) {
        print( $"Error loading progress in slot {global.current_saveslot}" );
    }
    
    buffer_delete( _save_buffer );
}