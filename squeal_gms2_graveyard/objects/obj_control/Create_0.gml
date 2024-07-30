#macro DEV true

application_surface_draw_enable( true );

currentlevel	= 0;

// timestamp_timer = new cTimer( 60 * 10, true );
timestamp_x = camera_get_view_width( CURRENT_VIEW ) / 2;
timestamp_y = camera_get_view_height( CURRENT_VIEW ) / 2;

// Init Collectibles
init_collectibles();

// Init Game Levels
//init_levellist();

#region Game Events
eventhandler_subscribe( self.id, "ev_gameend", function() {
	file_delete( APPDATA_PATH + "console.txt" );
	game_end();
} );

eventhandler_subscribe( self.id, "ev_gamepause", function() {
	pause_game();
} );

eventhandler_subscribe( self.id, "ev_gameunpause", function() {
	unpause_game();
} );

eventhandler_subscribe( self.id, "ev_gamecheckpoint", function() {
	instance_create_depth( 0, 0, 0, obj_saver );
} );

eventhandler_subscribe( self.id, "ev_playerspawn", function() {
	eventhandler_publish( "ev_gamecheckpoint" );
} );
#endregion

room_clean_index			= 0;
post_shader					= -1;
							
anim						= 0;
animspeed					= 0.1;
text_timer					= 60 * 4;

// Saving / Loading vars for saving icon
saving						= false;
loading						= false;

save_created				= false;
							
screen_alpha				= 1;
							
zoomblur_scale				= 0;

depth						= 1024;
							
_debugoverlay				= false;

LevelCheckpoint = function()
{
	screen_alpha = 1;
	instance_create_depth( x, y, depth, obj_saver );
};

#region Audio
audio_music_fadeout = false;
audio_music_fadein	= false;
console_timer		= 50;
#endregion
#region Files
// Cursor
cursor_index				= 0;
cursor_type					= 0;

// Option Loading
//config_load();

#region Cursor
// Cursor 
scr_loadcursor();

cursor_option[CURSOR.DEFAULT][0]	= sprCursor_Joe;
cursor_option[CURSOR.DEFAULT][1]	= sprCursor_Derby;
cursor_option[CURSOR.ALT][0]		= sprCursor_Alt1;
cursor_option[CURSOR.ALT][1]		= sprCursor_Alt2;
cursor_option[CURSOR.ALT][2]		= sprCursor_Alt3;
cursor_option[CURSOR.ALT][3]		= sprCursor_Alt4;
cursor_option[CURSOR.CUSTOM][0]		= global.cursor_custom;
#endregion

#endregion
// Input
global.input_mouse_lock		= true;
global.input_blocked		= false;
global.firstperson			= false;

DoMouseLock = function() 
{
	var result = false;
	
	if ( instance_exists( obj_player ) )
	{
		result = true;
	}
	
	return result;
}

// Video
global.video_width			= 0;
global.video_height			= 0;
global.video_surf			= -1;
_vid_wprev					= 0;
_vid_hprev					= 0;
_vid_updates				= 0;
_vid_aspect					= (480 / 270);


// Rich Presence
np_initdiscord("929342457395703858", 0, 0);

// stats and Achievements
milliseconds = 0;