if ( IDE_MODE ) {
	draw_set_color( c_lime );
	draw_set_halign( fa_left );
	draw_set_valign( fa_top );
	draw_set_font( fntDebug );
	display_set_gui_size( window_get_width(), window_get_height() );
	
	var col = c_lime;
	var emote = " : D";
	
	if ( fps_average >= 600 ) {
		col = c_lime;
		emote = " : D";
	}
	else if ( fps_average >= 400 ) {
		col = c_yellow;
		emote = " : |";
	}
	else if ( fps_average <= 200 ) {
		col = c_red;
		emote = " ; (";
	}
	
	draw_set_color( col );
	
	if ( globalflags_get( GLOBALFLAGS.DEBUG_FPS ) ) {
		draw_text( 12, 12, "FPS Average " + string( fps_average ) + emote );
	};
	
	draw_set_color( c_lime );
	draw_text( 12, 12*3, string( "Runtime " + GM_runtime_version ) );
	draw_text( 12, 12*4, string( "Indev v" + GM_version ) );
	draw_text( 12, 12*5, string( "Debug Mode : {0}", global.debug ) );
	draw_text( 12, 12*6, string( "Master Volume : {0}", global.settings.vol_master_volume ) );
	draw_text( 12, 12*7, string( "Music Volume : {0}", global.settings.vol_music_volume ) );
	draw_text( 12, 12*8, string( "SFX Volume : {0}", global.settings.vol_sfx_volume ) );
	draw_text( 12, 12*9, string( "Ambience Volume : {0}", global.settings.vol_amb_volume ) );
	draw_text( 12, 12*10, string( "Current Save File : {0}", global.current_save ) );
	draw_text( 12, 12*11, string( "Current Save Slot : {0}", global.current_saveslot ) );
	
	draw_set_color( c_white );
}

if ( globalflags_is_set( GLOBALFLAGS.DRAW_TIMESTAMP ) ) {
	var timestamp_info = {
		user : environment_get_variable( "USERNAME" ),
		hours : date_get_hour( CURRENT_DATE ),
		minutes : date_get_minute( CURRENT_DATE ),
		seconds : date_get_second( CURRENT_DATE ),
		day : date_get_day( CURRENT_DATE ),
		month : date_get_month( CURRENT_DATE ),
		year : date_get_year( CURRENT_DATE ),
	}
	
	var _timestamp_string = string( "{0}\n{1}:{2}:{3}\n{4}/{5}/{6}", 
		timestamp_info.user, 
		timestamp_info.hours, timestamp_info.minutes, timestamp_info.seconds, 
		timestamp_info.day, timestamp_info.month, timestamp_info.year 
		);
	
	draw_set_halign( fa_center );
	draw_set_valign( fa_middle );
	
	draw_text( timestamp_x, timestamp_y, _timestamp_string );
}