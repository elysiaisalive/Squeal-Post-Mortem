draw_sprite_ext
(
	sprite_index,
	image_index,
	x + 1,
	y + 1,
	image_xscale,
	image_yscale,
	direction,
	c_black,
	0.5
)
draw_sprite_ext
(
	sprite_index,
	image_index,
	x,
	y - abs(lengthdir_x(grenade_spd * 2, direction)),
	image_xscale,
	image_yscale,
	direction,
	image_blend,
	image_alpha
)