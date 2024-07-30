if ( sprite_index != -1 )
{
	if ( shadow_depth != 0 )
	{
		draw_sprite_ext(
			sprite_index,
			image_index,
			x + 1,
			y + 1,
			image_xscale,
			image_yscale,
			image_angle,
			c_black,
			0.5
		);
	}
	
	draw_sprite_ext(
		sprite_index,
		image_index,
		x,
		y,
		image_xscale,
		image_yscale,
		image_angle,
		c_white,
		image_alpha
	);
}
