/// @desc Loads the game config
function config_load() 
{
	// Loading / Overwriting the settings file
	if ( file_exists( APPDATA_PATH + "\\Config\\Config.dat" ) ) 
	{
		// Writing to the file
		ini_open( APPDATA_PATH + "\\Config\\Config.dat" );
		println( "Writing" );
		
		// Controls
		// global.inputs.key_primary	= ini_read_real( "Controls",			"Primary Key",				( global.inputs.key_primary ) );
		// global.inputs.key_secondary	= ini_read_real( "Controls",			"Secondary Key",			( global.inputs.key_secondary ) );
		// global.inputs.key_up			= ini_read_real( "Controls",			"Up Key",					( global.inputs.key_up ) );
		// global.inputs.key_left			= ini_read_real( "Controls",			"Left Key",					( global.inputs.key_left ) );
		// global.inputs.key_right			= ini_read_real( "Controls",			"Right Key",				( global.inputs.key_right ) );
		// global.inputs.key_down			= ini_read_real( "Controls",			"Down Key",					( global.inputs.key_down ) );
		// global.inputs.key_restart		= ini_read_real( "Controls",			"Restart Key",				( global.inputs.key_restart ) );
		// global.inputs.key_strafe		= ini_read_real( "Controls",			"Strafe Key",				( global.inputs.key_strafe ) );
		// global.inputs.key_zoom			= ini_read_real( "Controls",			"Zoom Key",					( global.inputs.key_zoom ) );
		// global.zoom_mode				= ini_read_real( "Controls",			"Zoom Mode",				( global.zoom_mode ) );
		// global.inputs.key_lockon		= ini_read_real( "Controls",			"Lock-On Key",				( global.inputs.key_lockon ) );
													 
		// Graphics									 
		cursor_scale					= ini_read_real( "Cursor Options",		"Cursor Scale",				cursor_scale );
		cursor_animationspeed			= ini_read_real( "Cursor Options",		"Cursor Animation Speed",	cursor_animationspeed );
		obj_control.cursor_index		= ini_read_real( "Cursor Options",		"Cursor",					obj_control.cursor_index );
		obj_control.cursor_type			= ini_read_real( "Cursor Options",		"Cursor Type",				obj_control.cursor_type );
		global.cursor_custom			= ini_read_real( "Cursor Options",		"Custom Cursor",			global.cursor_custom );
																				
		// Audio																
		global.settings.vol_master_volume			= ini_read_real( "Volume",				"Master Volume",			global.settings.vol_master_volume );
		global.settings.music_volume				= ini_read_real( "Volume",				"Music Volume",				global.settings.vol_music_volume );
		global.settings.vol_sfx_volume				= ini_read_real( "Volume",				"SFX Volume",				global.settings.vol_sfx_volume );
		global.settings.vol_stereo					= ini_read_real( "Volume",				"vol_stereo Mode",				global.settings.vol_stereo );
	
		ini_close();
		
		println( "Config File Loaded" );
		obj_control.loading = true;
	}
}