if ( bounce )
{
	if ( !place_free( x + hspeed * 2 * delta, y ) )
	{
		hspeed = -hspeed * delta;
	}
	if ( !place_free( x, y + vspeed * 2 * delta ) ) 
	{
		vspeed = -vspeed * delta;
	}
	
	if ( debris_spd < 0.02 )
	{
		debris_frc = 0.005 ;
	}
	else 
	{
		debris_frc = 0.05;
	}
	
	image_angle = debris_dir;
	
	debris_spd -= debris_frc * delta;
	debris_spd = clamp( debris_spd, 0, 256 );
	
	x += dcos( direction ) * debris_spd * delta;
	y -= dsin( direction ) * debris_spd * delta;
	
	debris_dir += ( 20 - debris_spd ) * delta;
}

image_angle = debris_dir;

if ( animated )
{
	image_index += ( debris_spd / 2 ) * delta;
}

debris_spd -= debris_frc * delta
debris_spd = clamp( debris_spd, 0, 15 );

x += dcos(direction) * debris_spd * delta
y -= dsin(direction) * debris_spd * delta

if ( flip && debris_spd > 0 )
{
	debris_dir += flyspeed * debris_spd;
	flipscale += flipspeed
}

if ( flying && debris_spd > 0 ) 
{
	debris_dir += flyspeed * debris_spd;
	flyscale += 0.05
}
flyscale = 1 * debris_spd / 3
flyscale = 1 * debris_spd / 3
flyscale = clamp(flyscale, 1, 4)


if ( flaming )
{
	flame_timer = max( 0, flame_timer - 1 * delta );
	
	if ( flame_timer == 0 )
	{
		flameamount ++;
		
		repeat( random_range( 1, 2 ) )
		{
			spawn_particle(
				obj_particle_generic,
				choose( spr_effect_dragonsbreathfireball, spr_effect_fire_wisp2, spr_effect_ignited_small2 ),
				0.2,
				random_range( -360, 360 ),
				random_range( -360, 360 ),
				1,
				x + random_range( -8, 8 ),
				y + random_range( -8, 8 ),
				1,
				random_range( 0.1, 0.2 ),
				1,
				false,
				true,
				-256,
				true
			);
		}
		
		flame_timer = random_range( 4, flame_maxtimer );		
		flame_timer = clamp( flame_timer, 0, flame_maxtimer );
		flameamount = clamp( flameamount, 0, flameamountmax );
		flameamount = floor( flameamount );
	}
}
if ( debris_spd <= 0 && BakeToSurface && !flaming )
{
	surface_set_target(obj_surface_manager.GetSurf())
	draw_sprite_ext(
		sprite_index, 
		image_index, 
		x * obj_surface_manager.scale, 
		y * obj_surface_manager.scale, 
		image_xscale * obj_surface_manager.scale, 
		image_yscale * obj_surface_manager.scale, 
		debris_dir, 
		image_blend, 
		image_alpha
		)
	surface_reset_target();
	instance_destroy();
}
else
if ( debris_spd <= 0 && BakeToSurface && flaming && flameamount == 25 )
{
	surface_set_target(obj_surface_manager.GetSurf())
	draw_sprite_ext(
		sprite_index, 
		image_index, 
		x * obj_surface_manager.scale, 
		y * obj_surface_manager.scale, 
		image_xscale * obj_surface_manager.scale, 
		image_yscale * obj_surface_manager.scale, 
		debris_dir, 
		image_blend, 
		image_alpha
		)
	surface_reset_target();
	instance_destroy();
}


