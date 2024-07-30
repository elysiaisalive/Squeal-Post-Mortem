function effects_generic_itemhit( obj_id = noone, repeats = 0, xx = obj_id.x, yy = obj_id.y, dir = obj_id.direction ) 
{
	repeat( repeats )
	{
		spawn_particle(
			obj_particle_generic,
			choose( spr_effect_smoke_tiny2 ),
			0.2,
			dir - 180 + random_range( -90, 90 ),
			dir,
			0.8,
			xx,
			yy,
			random_range( 1, 2 ),
			random_range( 0.1, 0.2 ),
			1,
			false,
			true,
			-15,
			true,
			0.05
		);
	};
};