function effects_generic_spark( obj_id = noone )
{
	spawn_particle(
		obj_particle_generic,
		spr_effect_impact_bullet,
		0.2,
		obj_id.direction - 180 + random_range( -10, 10 ),
		obj_id.direction,
		0.8,
		obj_id.x,
		obj_id.y,
		random_range( 1, 2 ),
		random_range( 0.1, 0.2 ),
		1,
		false,
		true,
		-15,
		true,
		0.05
	);
	
	repeat( random_range( 2, 3 ) )
	{
		spawn_particle(
			obj_particle_generic,
			choose( spr_effect_smoke_tiny2, spr_effect_smoke_tiny3 ),
			0.2,
			obj_id.direction - 180 + random_range( -90, 90 ),
			obj_id.direction,
			0.8,
			obj_id.x,
			obj_id.y,
			random_range( 2, 4 ),
			random_range( 0.1, 0.2 ),
			1,
			false,
			true,
			-15,
			true,
			0.05
		);
		spawn_particle(
			obj_particle_generic,
			spr_effect_spark,
			0.2,
			obj_id.direction - 180 + random_range( -90, 90 ),
			obj_id.direction,
			0.8,
			obj_id.x,
			obj_id.y,
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
}