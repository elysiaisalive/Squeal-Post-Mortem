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
	0.5
);
if ( spd > 0 )
{
	draw_sprite_ext
	(
		sprite_index,
		image_index,
		x,
		y - abs( lengthdir_x( spd / 2, image_angle ) ),
		1,
		1,
		image_angle,
		image_blend,
		image_alpha
	);
}
else
{
	draw_sprite_ext
	(
		sprite_index,
		image_index,
		x,
		y - abs( lengthdir_x( spd / 2, image_angle ) ),
		1,
		1,
		image_angle,
		image_blend,
		image_alpha
	);
};