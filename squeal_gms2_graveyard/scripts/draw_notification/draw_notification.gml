function draw_notification(  ) {
	
	var scale = window_get_width() / camera_get_view_width( CURRENT_VIEW );
	var yy = camera_get_view_width( CURRENT_VIEW );
	var xx = camera_get_view_height( CURRENT_VIEW );
	//var rot = min( abs( sin( siner / 16 ) ) );
	
	display_set_gui_size( view_wport[0], view_hport[0] );

	var c_mixed = c_black + merge_color( c_fuchsia, c_aqua, abs( sin( color_sin ) ) );

	if ( global.displaynotif )
	{		
		draw_sprite_ext( 
			spr_ui_notification,
			0, 
			400, 
			notif_y, 
			scale / 4, 
			scale / 4, 
			0,
			c_white, 
			1
			);
			draw_text(480/2,270/2,notif_time)
	}
}