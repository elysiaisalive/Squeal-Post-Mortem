draw_sprite_ext(
	spr_justice_camerabase, 
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
	spr_justice_camerabase, 
	0,
	x,
	y,
	image_xscale,
	image_yscale,
	image_angle,
	image_blend,
	1
);

// Camera Top
draw_sprite_ext(
	spr_justice_camerahead, 
	image_index,
	x + shadow_depth,
	y + shadow_depth,
	image_xscale,
	image_yscale,
	cam_movetype,
	c_black,
	0.5
);
	
draw_sprite_ext(
	spr_justice_camerahead, 
	anim_spd,
	x,
	y,
	image_xscale,
	image_yscale,
	cam_movetype,
	image_blend,
	1
);

draw_sprite_ext(
	spr_justice_cameralight, 
	cam_lightindex,
	x,
	y,
	image_xscale,
	image_yscale,
	cam_movetype,
	image_blend,
	1
);