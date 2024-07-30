draw_set_alpha( 0.80 + sin( glow_sin ) );
gpu_set_blendmode( bm_add );
draw_circle_color( x, y, abs( sin( glow_sin ) ) * glow_size, glow_c1, glow_c2, false );
gpu_set_blendmode( bm_normal );
draw_set_alpha( 1 );

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
};