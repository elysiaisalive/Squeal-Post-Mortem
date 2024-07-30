if ( bounce 
&& !flying )
{
	if ( gore_spd > 0 )
	{
		draw_sprite_ext
		(
			sprite_index,
			image_index,
			x + 1,
			y + 1,
			image_xscale,
			image_yscale,
			image_angle,
			c_black,
			0.50
		);
	};
	
	draw_sprite_ext
	(
		sprite_index,
		image_index,
		x,
		y - abs(lengthdir_x( gore_spd * 2, image_angle ) ),
		image_xscale,
		image_yscale,
		image_angle,
		image_blend,
		image_alpha
	);
};

if ( !bounce 
&& flying )
{
	draw_sprite_ext(
		sprite_index, 
		image_index, 
		x + 0.8 * gore_spd,
		y + 0.8 * gore_spd, 
		1, 
		1, 
		image_angle, 
		c_black, 
		0.50
	);
}
else
if ( !bounce 
&& !flying )
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
		image_alpha
	);
};