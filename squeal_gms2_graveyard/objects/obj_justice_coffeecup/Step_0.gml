event_inherited();

if ( image_index >= 0 )
{
	smoke_time = max( 0, smoke_time - 1 * delta );
	
	if ( smoke_time <= 0 )
	{
		repeat( random_range( 2, 4 ) )
		{
			spawn_particle( 
				obj_particle_generic, 
				spr_effect_smoke_tiny2, 
				random_range( 0.010, 0.050 ), 
				image_angle + random_range( -10, 40 ), 
				random( 360 ), 
				random_range( 0.4, 0.8 ), 
				x, 
				y, 
				random_range( 0.050, 0.40 ), 
				random_range( 0.0010, 0.0020 ), 
				1, 
				true,
				,
				z - ( height + 8 )
				,
				,
				random_range( 0.010, 0.020 )
			);
		};
		
		smoke_time = random_range( 5, smoke_maxtime );
	};
};

spd -= frc * delta;
spd = clamp( spd, 0, 3 );

x += dcos(direction) * spd * delta;
y -= dsin(direction) * spd * delta;

image_index += spd / 4;

if ( knocked_over && spd == 0 )
{
	instance_destroy();
	
	var inst = instance_create_depth( x, y, -15, obj_gore_generic );
	
	inst.sprite_index = spr_effect_coffeespill;
	inst.gore_spd = 0;
	inst.image_angle = random_range( -360, 360 );
	inst.done = false;
	
	repeat( random_range( 6, 8 ) )
	{
		var inst = instance_create_depth( x, y, -15, obj_gore_generic )
		inst.sprite_index = spr_effect_coffeespray;
		inst.gore_spd = random_range( 2, 3 );
		inst.gore_frc = random_range( 0.1, 0.2 );
		inst.direction = random_range( -360, 360 );
		inst.image_angle = inst.direction;
		inst.done = false;
		inst.splat = true;
		inst.splatter_sprite = spr_effect_coffeespill;
	}
	
	repeat( random_range( 4, 6 ) )
	{
		var inst = instance_create_depth( x, y, -15, obj_debris_generic )
		inst.sprite_index = spr_debris_coffeecup;
		inst.image_index = floor( random( image_index ) );
		inst.debris_spd = random_range( 2, 3 );
		inst.debris_frc = random_range( 0.1, 0.2 );
		inst.direction = random_range( -360, 360 );
		inst.image_angle = inst.direction;
		inst.done = false;
	}
	
	playsound_at( snd_break_glass, x, y );
}

