/// @desc Saves the game config
function config_save() 
{
	/* 
		TO DO : Switch lots of this to save all the proper values for settings, etc.
	*/
	
	
	
	create_directory( APPDATA_PATH + "\\Config\\" );
	create_directory( APPDATA_PATH + "\\Config\\Cursors" );
	create_directory( APPDATA_PATH + "\\Lang\\" );
	create_directory( APPDATA_PATH + "\\Crashlogs\\" );
	
	// If the save file exists, delete it
	delete_file( APPDATA_PATH + "\\Config\\Config.dat" );

	ini_open( APPDATA_PATH + "\\Config\\Config.dat" );

	// Write the options to the file

	// Controls
	// ini_write_real( "Controls",				"Primary Key",				( global.inputs.key_primary ) );
	// ini_write_real( "Controls",				"Secondary Key",			( global.inputs.key_secondary ) );
	// ini_write_real( "Controls",				"Up Key",					( global.inputs.key_up ) );
	// ini_write_real( "Controls",				"Left Key",					( global.inputs.key_left ) );
	// ini_write_real( "Controls",				"Right Key",				( global.inputs.key_right ) );
	// ini_write_real( "Controls",				"Down Key",					( global.inputs.key_down ) );
	// ini_write_real( "Controls",				"Restart Key",				( global.inputs.key_restart ) );
	// ini_write_real( "Controls",				"Strafe Key",				( global.inputs.key_strafe ) );
	// ini_write_real( "Controls",				"Zoom Key",					( global.inputs.key_zoom ) );
	// ini_write_real( "Controls",				"Zoom Mode",				( global.zoom_mode ) );
	// ini_write_real( "Controls",				"Lock-On Key",				( global.inputs.key_lockon ) );
				    
	// Graphics	    
	ini_write_real( "Cursor Options",		"Cursor Scale",				cursor_scale );
	ini_write_real( "Cursor Options",		"Cursor Animation Speed",	cursor_animationspeed );
	ini_write_real( "Cursor Options",		"Cursor",					obj_control.cursor_index );
	ini_write_real( "Cursor Options",		"Cursor Type",				obj_control.cursor_type );
	ini_write_real( "Cursor Options",		"Custom Cursor",			global.cursor_custom );
				    
	// Audio	    
	ini_write_real( "Volume",				"Master Volume",			global.settings.vol_master_volume );
	ini_write_real( "Volume",				"Music Volume",				global.settings.vol_music_volume );
	ini_write_real( "Volume",				"SFX Volume",				global.settings.vol_sfx_volume );
	ini_write_real( "Volume",				"vol_stereo Mode",				global.settings.vol_stereo );

	ini_close();
	
	println( "Config File Saved" );
	obj_control.saving = true;
}