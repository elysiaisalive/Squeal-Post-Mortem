char_spd -= char_frc * delta;
char_spd = clamp( char_spd, 0, 256 );

x += dcos( direction ) * char_spd * delta;
y -= dsin( direction ) * char_spd * delta;

if ( animated )
{
	image_index += animspd * delta;
	
	if ( char_spd <= 0 && image_index > ( image_number - 1 ) )
	{
		animspd = 0;
		done = true;
	}
}

if ( char_spd > 0 )
{
	trail_timer = max( 0, trail_timer - 1 * delta );
	trail_timer = clamp( trail_timer, 0, trail_timermax );

	if ( trail_timer == 0 )
	{
		var inst = instance_create_depth( x, y, -10, obj_char_generic )
		inst.sprite_index = spr_effect_chartrail_med;
		inst.image_index = floor( random( sprite_get_number( sprite_index ) ) );
		inst.animated = false;
		inst.direction = self.direction;
		inst.image_angle = inst.direction;
		inst.surfacetype = obj_surface_manager.GetSurf();
	
		trail_timer = random_range( 1, 1.5 );
	}
}

if ( done ) 
{
	surface_set_target( surfacetype );
	
	draw_sprite_ext(
		sprite_index, 
		image_index, 
		x * obj_surface_manager.scale, 
		y * obj_surface_manager.scale, 
		image_xscale * obj_surface_manager.scale, 
		image_yscale * obj_surface_manager.scale, 
		image_angle, 
		image_blend, 
		image_alpha
	);
		
	surface_reset_target();
	instance_destroy();
}
