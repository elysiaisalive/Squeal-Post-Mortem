if ( hp <= 25 )
{
	flame_timer = max( 0, flame_timer - 1 * delta );
	
	if ( flame_timer == 0 )
	{
		repeat( random_range( 1, 2 ) )
		{
			spawn_particle(
				obj_particle_generic,
				choose( spr_effect_dragonsbreathfireball, spr_effect_ignited_small2 ),
				0.2,
				random( 360 ),
				random( 360 ),
				1,
				x + random_range( -8, 8 ),
				y + random_range( -8, 8 ),
				random_range( 1, 2 ),
				random_range( 0.1, 0.2 ),
				1,
				false,
				true,
				-256,
				true,
				0.05
			);
			
			hp -= 5;
			
			x += random_range( -2, 2 ) * delta;
			y += random_range( -2, 2 ) * delta;
		}
		
		flame_timer = random_range( 0.1, flame_maxtimer );		
		flame_timer = clamp( flame_timer, 0, flame_maxtimer );
	}
}

if ( hp == 0 )
{
	effects_explode_barrel();
	effects_explode_char();
	
	instance_create_depth( x, y, -15, obj_hazard_explosion );
	instance_create_depth( x, y, depth, obj_effect_shockwave );
	
	instance_destroy();
}

hp = clamp( hp, 0, hp_max );
