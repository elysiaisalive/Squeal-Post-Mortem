if ( globalflags_get( GLOBALFLAGS.DEBUG_NODEGRAPH ) )
{
	if ( surface_exists( surf ) && redraw )
	{
		surface_set_target( surf );
		
		draw_set_color( c_white );
		draw_set_alpha( 0.50 );
		
		for( var w = 0; w < ds_grid_width( nav_grid ); ++w )
		{
			for( var h = 0; h < ds_grid_height( nav_grid ); ++h )
			{
				var _val = nav_grid[# w, h];
				
				draw_set_color( _val == -1 ? c_red : c_lime );
				draw_rectangle( w * cell_w + grid_offset, h * cell_h + grid_offset, ( w + 1 ) * cell_w + grid_offset, ( h + 1 ) * cell_h + grid_offset, false );
				draw_set_color( c_white );
				
				draw_line_color( 0 + grid_offset, h * cell_h + grid_offset, nav_grid_w + grid_offset, h * cell_h + grid_offset, c_white, c_white );
				draw_line_color( w * cell_w + grid_offset, 0 + grid_offset, w * cell_w + grid_offset, nav_grid_h + grid_offset, c_white, c_white );
			};
		};
		
		draw_set_alpha( 1 );
		surface_reset_target();
	};
	
	draw_surface( surf, 0, 0 );
}