function screen_fade( color = c_black, alpha = screen_alpha){

	// This function creates a screen sized rectangle of color that will fade in or out.
	
	var scale = window_get_width() / camera_get_view_width(CURRENT_VIEW);
	
	var x1 = window_get_width();
	var y1 = window_get_height();
	
	draw_set_alpha( alpha )
	{
		draw_rectangle_color( 
			0, 
			0, 
			x1 + y1 * scale, 
			y1 + x1 * scale, 
			color, 
			color, 
			color, 
			color,
			false
			)
	}
	draw_set_alpha( 1 )	
	
	screen_alpha = clamp( screen_alpha, 0, 1 );
}