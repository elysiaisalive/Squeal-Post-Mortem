function effects_debris_windowglass( xx = x, yy = y, dir )
{
	#region Glass Debris
	repeat( random_range( 32, 48 ) ) 
	{
		var inst = instance_create_depth( x, y, -15, obj_debris_generic );
		inst.sprite_index = spr_debris_glass_small;
		inst.image_index = floor( random( sprite_get_number( inst.sprite_index ) ) );
		inst.x = xx + random_range( -16, 16 ) + lengthdir_x( 8, dir );
		inst.y = yy + random_range( -16, 16 ) + lengthdir_y( 8, dir );
		inst.debris_spd = random_range( 4, 6 );
		inst.debris_frc = random_range( 0.2, 0.3 );
		inst.direction = dir + random_range( -45, 45 );
		inst.image_angle += inst.direction;
	}
	
	repeat( random_range( 10, 12 ) ) 
	{
		var inst = instance_create_depth( x, y, -15, obj_debris_generic );
		inst.sprite_index = spr_debris_glass_big;
		inst.image_index = floor( random( sprite_get_number( inst.sprite_index ) ) );
		inst.x = xx + random_range( -16, 16 ) + lengthdir_x( 8, dir );
		inst.y = yy + random_range( -16, 16 ) + lengthdir_y( 8, dir );
		inst.debris_spd = random_range( 2, 4 );
		inst.debris_frc = random_range( 0.1, 0.3 );
		inst.flying = true;
		inst.flyspeed = random_range( 2, 18 );
		inst.direction = dir + random_range( -45, 45 );
		inst.image_angle += inst.direction;
	}
	#endregion
	
	#region Particles
	repeat( random_range( 10, 12 ) )
	{
		spawn_particle(
			obj_particle_generic,
			spr_effect_glassbreak,
			0.2,
			dir - 180 + random_range( -360, 360 ),
			dir,
			0.8,
			xx,
			yy,
			random_range( 2, 4 ),
			random_range( 0.1, 0.2 ),
			1,
			false,
			true,
			-15,
			true,
			0.05
		);
	}
	#endregion
}