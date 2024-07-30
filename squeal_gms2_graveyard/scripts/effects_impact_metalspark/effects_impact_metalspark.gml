function effects_impact_metalspark( obj_id ) 
{
	spawn_particle(
		obj_particle_impactspark,
		choose( spr_impact_sparkbig, spr_impact_sparkbig2 ),
		random_range( 0.50, 0.70 ),
		obj_id.direction - 180,
		obj_id.direction,
		1,
		obj_id.x,
		obj_id.y,
		random_range( 1, 2 ),
		random_range( 0.1, 0.2 ),
		1,
		false,
		true,
		z - 2,
		true,
		0
	);
	
	repeat ( random_range( 2, 4 ) )
	{
		spawn_particle(
			obj_particle_generic,
			choose( spr_effect_sparkmetal, spr_effect_sparkmetal2, spr_effect_sparkmetal3, spr_effect_sparkmetal4 ),
			random_range( 0.60, 0.75 ),
			obj_id.direction - 180 + random_range( -30, 30 ),
			obj_id.direction,
			1,
			obj_id.x,
			obj_id.y,
			random_range( 2, 4 ),
			random_range( 0.1, 0.2 ),
			1,
			false,
			true,
			z - 2,
			true,
			0
		);		
		spawn_particle(
			obj_particle_generic,
			choose( spr_effect_wallchunk, spr_effect_wallchunk2, spr_effect_wallchunk3, spr_effect_wallchunk4, spr_effect_wallchunk5, spr_effect_wallchunk6 ),
			random_range( 0.20, 0.75 ),
			obj_id.direction - 180 + random_range( -30, 30 ),
			obj_id.direction,
			1,
			obj_id.x,
			obj_id.y,
			random_range( 2, 6 ),
			random_range( 0.1, 0.2 ),
			1,
			false,
			true,
			z - 2,
			true,
			0
		);
		spawn_particle(
			obj_particle_generic,
			spr_effect_sparkmetal4,
			random_range( 0.60, 0.75 ),
			obj_id.direction - 180 + random_range( -60, 60 ),
			obj_id.direction,
			1,
			obj_id.x,
			obj_id.y,
			random_range( 2, 4 ),
			random_range( 0.1, 0.2 ),
			1,
			false,
			true,
			z - 2,
			true,
			0
		);		
		spawn_particle(
			obj_particle_generic,
			choose( spr_effect_sparkmetal, spr_effect_sparkmetal4 ),
			random_range( 0.20, 0.55 ),
			obj_id.direction - 180 + random_range( -60, 60 ),
			obj_id.direction,
			1,
			obj_id.x,
			obj_id.y,
			random_range( 2, 4 ),
			random_range( 0.1, 0.2 ),
			1,
			false,
			true,
			z - 2,
			true,
			0
		);
	};
};