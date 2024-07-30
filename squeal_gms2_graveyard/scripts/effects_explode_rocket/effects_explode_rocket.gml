function effects_explode_rocket(  ) {
 
	spawn_particle(
		obj_particle_smoke,
		spr_effect_explosion,
		1.5,
		random( 360 ),
		random( 360 ),
		1,
		x,
		y,
		0,
		0,
		1,
		false,
		false,
		-95,
		true,
		0.01
	);
	repeat( random_range( 2, 4 ) ) 
	{
		spawn_particle(
			obj_particle_generic,
			spr_effect_smoke_med,
			0.8,
			random( 360 ),
			random( 360 ),
			1,
			x,
			y,
			random_range( 4, 6 ),
			random_range( 0.2, 0.3 ),
			random_range( 2, 2.5 ),
			false,
			false,
			-95,
			true,
			0.01
		);
	}
	repeat( random_range( 8, 12 ) ) 
	{
		spawn_particle(
			obj_particle_generic,
			spr_effect_dragonsbreathfireball,
			0.3,
			random( 360 ),
			random( 360 ),
			1,
			x,
			y,
			random_range( 8, 9 ),
			random_range( 0.2, 0.3 ),
			1,
			false,
			false,
			-95
		);
	}
	repeat( random_range( 8, 12 ) ) 
	{
		spawn_particle(
			obj_particle_generic,
			spr_effect_dragonsbreathspit3,
			0.3,
			random( 360 ),
			random( 360 ),
			1,
			x,
			y,
			random_range( 8, 9 ),
			random_range( 0.2, 0.3 ),
			1,
			false,
			false,
			-95
		);
	}
	
	repeat( random_range( 8, 12 ) )
	{
		var inst = instance_create_depth( x, y, -15, obj_trail );
		inst.spd = random_range( 8, 10 );
		inst.frc = random_range( 0.2, 0.3 );
		inst.direction = random( 360 );
	}
}