exception_unhandled_handler( function exceptionHandler( exception ) {	
	var year	= string( current_year );
	var month	= string( current_month );
	var day		= string( current_day );
	var time	= date_time_string( date_current_datetime() );
	var date	= day + "_" + month + "_" + year;	
	var _buildType = $"buildtype : {GM_build_type}\n";
	var _runTime = $"runtime : {GM_runtime_version}\n\n";
	var name = "crash_" + date + $"_{exception.script}" + ".txt";
	
	audio_play_sound_ext( {
		sound : snd_crash,
		gain : 0.05
	} );
	
	var crash_string = choose( "Shit! Ground is shaking!", "Uh Oh! Something fucked up!", "It's over!", "Game Broke", "How did we get here?" ) + "\n\n";
	
	// Display error message
	np_setpresence( "Game Crashed ...", "NULL", "crashed", "crashed" );
	show_message( string( game_display_name ) + " " + "has encountered a problem and needs to close.\n\n" + "Object Error : " + exception.script + "\n\n Please check the game folder and report this bug to the ETS discord!" );
	
	var crashlog = file_text_open_write( LOGS_PATH + name );
	
	file_text_write_string( crashlog, $"Please report this log to the Itch.io or the Discord!\n" );
	file_text_write_string( crashlog, _buildType );
	file_text_write_string( crashlog, _runTime );
	file_text_write_string( crashlog, "Crash Time" + " - " + date + " at " + time + "\n" + crash_string + string( exception ) );
	file_text_close( crashlog );
	
	// Print Error message to console
    show_debug_message( game_display_name + " " + " HAS ENCOUNTERED AN ERROR ... " + string( exception ) );
});