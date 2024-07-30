event_inherited();
if ( grenade_spd > 0 )
{
	image_angle += 15 * delta;
}

#region Grenade Detonation

grenade_fuse = max( 0, grenade_fuse - 1 * delta );

if ( grenade_fuse == 0 )
{
	#region Explosion
	if ( !exploded )
	{
		global.shake = 25;
	
		playsound_at( snd_airburst_explode, x, y )
		spawn_particle(
			obj_particle_generic,
			spr_effect_airburstdetonate,
			0.8,
			0,
			random(360),
			1,
			x,
			y,
			0,
			0,
			1,
			true,
			false
		);
		exploded = true;
	}
	#region Particles
	smoke_timer = max( 0, smoke_timer - 1 * delta );
	
	if ( smoke_timer > 0 )
	{
		repeat( random_range( 1, 2 ) )
		{
			spawn_particle(
				obj_particle_generic,
				spr_effect_smokebomb,
				random_range( 0.001, 0.004 ),
				random_range( -360, 360 ),
				random_range( -360, 360 ),
				random_range( 0.1, 0.4 ),
				x + random( 32 ),
				y + random( 32 ),
				random_range( 1, 6 ),
				random_range( 0.2, 0.4 ),
				1,
				true,
				false,
				-95,
				false,
				0.0007
			);
			spawn_particle(
				obj_particle_generic,
				spr_effect_smokebomb,
				random_range( 0.001, 0.004 ),
				random_range( -360, 360 ),
				random_range( -360, 360 ),
				random_range( 0.1, 0.4 ),
				x + random( 32 ),
				y + random( 32 ),
				random_range( 6, 10 ),
				random_range( 0.3, 0.4 ),
				1,
				true,
				false,
				-95,
				false,
				0.0007
			);
		}
	}
	#endregion
	#endregion
}

if ( smoke_timer == 0 && exploded )
{
	instance_destroy();
}

grenade_fuse = clamp( grenade_fuse, 0, grenade_fusemax );
#endregion