if ( flying && gore_spd > 0 )
{
	image_angle += flying_speed * gore_spd * delta;
}

if ( bounce && !flying )
{
	if ( !place_free( x + hspeed * 2 * delta, y ) )
	{
		hspeed = -hspeed * delta;
	}
	if ( !place_free( x, y + vspeed * 2 * delta ) ) 
	{
		vspeed = -vspeed * delta;
	}
	
	if ( gore_spd < 0.020 )
	{
		gore_frc = 0.0050 ;
	}
	else 
	{
		gore_frc = 0.050;
	}
	
	image_angle = image_angle;
	
	gore_spd -= gore_frc * delta;
	gore_spd = clamp( gore_spd, 0, 256 );
	
	x += dcos( direction ) * gore_spd * delta;
	y -= dsin( direction ) * gore_spd * delta;
	
	image_angle += ( 20 - gore_spd ) * delta;
}
else
{
	gore_spd -= gore_frc * delta;
	gore_spd = clamp( gore_spd, 0, 256 );
	
	x += dcos( direction ) * gore_spd * delta;
	y -= dsin( direction ) * gore_spd * delta;
};

if ( animated )
{
	image_index += advancespeed * delta;
	
	if ( ( image_index > ( image_number - 1 ) ) )
	{
		advancespeed = 0;
		done = true;
	}
}
else
if ( BakeToSurface && ( gore_spd <= 0 ) )
{
	advancespeed = 0;
	done = true;
}

if ( splat && ( gore_spd == 0 ) ) 
{
	var inst = instance_create_depth( x, y, -16, obj_gore_bloodsplat );
	
	inst.sprite_index = splatter_sprite;
	inst.image_index = floor( random( image_index ) );
	inst.image_angle = random_range( -360, 360 );
	inst.animated = false;
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