if ( parent_inst ) {
	if ( instance_exists( parent_inst ) ) {
		x = parent_inst.x + xoff;
		y = parent_inst.y + yoff;
	}
}

if ( sprite_index != -1 )
{
	draw_sprite_ext(
		sprite_index, 
		anim_index, 
		x,
		y, 
		particle_scale, 
		particle_scale, 
		image_angle, 
		c_white, 
		particle_alpha
	);
}