if ( surface_exists( shadow ) )
{	
	surface_set_target( shadow );
	
	with( obj_wall )
	{
		draw_sprite_ext(
			sprite_index, 
			image_index,
			x,
			y,
			image_xscale,
			image_yscale,
			image_angle,
			image_blend,
			1
		);
	};

	surface_reset_target();
	
	draw_surface_ext( shadow, obj_solid.shadow_depth, obj_solid.shadow_depth, 1, 1, 0, c_black, 0.45 );	
}