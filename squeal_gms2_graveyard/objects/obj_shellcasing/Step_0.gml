if ( animated || shell_sprite == spr_debris_zvedza ) 
{
	shell_index += ( shell_spd / 2 ) * delta;
}

shell_spd -= shell_frc * delta;
shell_spd = clamp( shell_spd, 0, 256 );

x += dcos( direction ) * shell_spd * delta;
y -= dsin( direction ) * shell_spd * delta;

if ( shell_spd > 0 )
{
	smoke_timer = max( 0, smoke_timer - 1 * delta );
	
	if ( smoke_timer == 0 )
	{
		repeat( random_range( 1, 2 ) )
		{
			spawn_particle( 
				obj_particle_generic, 
				spr_effect_smoke_tiny2, 
				0.1, 
				random(360), 
				random(360), 
				random_range( 0.4, 0.8 ), 
				x, 
				y, 
				random_range( 1, 2 ), 
				random_range( 0.2, 0.3 ), 
				1, 
				true 
				);
		}
		smoke_timer = smoke_maxtimer;
	}
}

shell_dir += spin;
spin *= 0.95;

// bounce collision
zsp += weight * delta;
z += zsp * delta;
if ( z >= ground_z ) {
	
	shell_frc = ground_frc;
	
	z = ground_z;
	if ( abs( zsp ) >= weight ) 
	&& ( shell_spd > weight ) {
		zsp = -abs( zsp * bounce );
		spin = zsp * 8 * sign( angle_rot );
		shell_spd *= bounce_frc;
		direction += random_range( -45, 45 );
		
		if ( !sound_single 
		|| !sound_played ) {
			sound_played = true;
			playsound_at( choose( snd_shellcasing ), x, y, 16, 16 * 12, random_range( 0.80, 1.90 ) );
		}
	}
	else {
		zsp = 0;
		
		if ( shell_spd == 0 ) {
			spin = 0;
			surface_set_target( obj_surface_manager.GetSurf() );
			draw_sprite_ext
			(
				shell_sprite, 
				shell_index, 
				shell_x * obj_surface_manager.scale, 
				shell_y * obj_surface_manager.scale, 
				image_xscale * obj_surface_manager.scale, 
				image_yscale * obj_surface_manager.scale, 
				shell_dir, 
				image_blend, 
				image_alpha
			);
			surface_reset_target();
			instance_destroy();
		}
	}
}
else {
	shell_frc = air_frc;
	depth = z - height;
	
	zscale = min( zscale + ( zscale_inc ), zscale_amount );
	shadow_x = x - ( z * zscale * 0.125 );
	shadow_y = y - ( z * zscale * 0.25 );
	shell_x = x;
	shell_y = y + ( z * zscale );
}