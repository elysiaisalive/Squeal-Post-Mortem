draw_sprite_ext(
	spr_justice_fan_bottom, 
	0,
	x + shadow_depth,
	y + shadow_depth,
	image_xscale,
	image_yscale,
	image_angle,
	c_black,
	0.5
	);
	
draw_sprite_ext(
	spr_justice_fan_bottom, 
	0,
	x,
	y,
	image_xscale,
	image_yscale,
	image_angle,
	image_blend,
	1
	);

// Fan Top
draw_sprite_ext(
	sprite_index, 
	image_index,
	x,
	y,
	image_xscale,
	image_yscale,
	fan_move,
	image_blend,
	1
	);