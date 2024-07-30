event_inherited();

if ( player_inrad )
{
	scr_draw_outline(  
		x,
		y,
		image_index,
		1,
		image_angle,
		c_white,
		sin(outline_a)
	);
}

draw_self();