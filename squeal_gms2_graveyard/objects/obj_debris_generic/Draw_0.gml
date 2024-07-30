if ( bounce )
{
	if ( debris_spd > 0 )
	{
		gpu_set_blendmode( bm_add );
		draw_sprite_ext
		(
			sprite_index,
			image_index,
			x + 1,
			y + 1,
			image_xscale,
			image_yscale,
			debris_dir,
			c_black,
			0.6
		)
		gpu_set_blendmode( bm_normal );
	}
	draw_sprite_ext
	(
		sprite_index,
		image_index,
		x,
		y - abs(lengthdir_x(debris_spd * 2, debris_dir)),
		image_xscale,
		image_yscale,
		debris_dir,
		image_blend,
		image_alpha
	)
}
else
{
	draw_sprite_ext(
		sprite_index, 
		image_index, 
		x + debris_spd * 0.25, 
		y + debris_spd * 0.25, 
		debris_spd * 0.07, 
		debris_spd * 0.07, 
		debris_dir,
		c_black,
		0.5
		);	

	draw_sprite_ext(
		sprite_index, 
		image_index, 
		x, 
		y, 
		flyscale, 
		flyscale, 
		debris_dir,
		c_white,
		1
		);
}

if (flip)
{
	draw_sprite_ext(
		sprite_index, 
		image_index, 
		(x + debris_spd * 0.45), 
		(y + debris_spd * 0.45), 
		sin(flipscale), 
		image_yscale, 
		debris_dir,
		c_black,
		0.5
		)	

	draw_sprite_ext(
		sprite_index, 
		image_index, 
		x, 
		y, 
		sin(flipscale), 
		image_yscale, 
		debris_dir,
		c_white,
		1
		)
}
else
{
	draw_sprite_ext(
		sprite_index, 
		image_index, 
		x + debris_spd * 0.25, 
		y + debris_spd * 0.25, 
		flyscale + debris_spd * 0.07, 
		flyscale + debris_spd * 0.07, 
		debris_dir,
		c_black,
		0.5
		)	

	draw_sprite_ext(
		sprite_index, 
		image_index, 
		x, 
		y, 
		flyscale, 
		flyscale, 
		debris_dir,
		c_white,
		1
		)
}