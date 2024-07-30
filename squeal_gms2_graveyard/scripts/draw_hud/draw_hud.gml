function draw_hud(  ) 
{
	var scale = window_get_width() / camera_get_view_width( CURRENT_VIEW );
	var yy = camera_get_view_width( CURRENT_VIEW );
	var xx = camera_get_view_height( CURRENT_VIEW );
	//var rot = min( abs( sin( siner / 16 ) ) );
	
	display_set_gui_size( view_wport[0], view_hport[0] );

	draw_set_font( fnt_handwritten );
	
	// Vignette
	draw_set_alpha( vignette_alpha );
	gpu_set_blendmode( bm_subtract );
	draw_ellipse_color(
		-480,
		-270,
		480 * 2,
		270 * 2,
		c_black,
		col_vignette,
		false
	);
	draw_set_alpha( 1 );
	gpu_set_blendmode( bm_normal );
	
	draw_set_font( fnt_terminal );
	draw_set_color( c_white );
	
	draw_set_halign( fa_center );
	draw_set_valign( fa_middle );
	
	if ( global.level != undefined )
	{
		if ( global.level.lvl.IsLevelComplete() )
		{
			clear_displaytime = max( 0, clear_displaytime - 1 );
			clear_textdisplayed = true;
			
			if ( clear_textdisplayed )
			{				
				draw_text( 240, 200, "LEVEL COMPLETE" );
			}
			
			if ( clear_displaytime == 0 )
			{
				clear_textdisplayed = false;
			}
		}
		
		if ( global.level.lvl.FloorIsCleared() && !global.level.lvl.IsLevelComplete() )
		{	
			clear_displaytime = max( 0, clear_displaytime - 1 );
			clear_textdisplayed = true;
			
			if ( clear_textdisplayed )
			{		
				draw_text( 240, 200, "FLOOR CLEAR" );
			}
			
			if ( clear_displaytime == 0 )
			{
				clear_textdisplayed = false;
			}
		}
	}
}