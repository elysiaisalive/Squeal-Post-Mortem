var radius = 8;
var check = collision_circle( x, y, radius, obj_character, false, true );

image_speed		= 0.30 * delta;

if ( check && det_timer > 0 )
{
	det_timer = max( 0, det_timer - 1 );
	playsound_at( snd_landmine_beep, x, y );

}

if ( det_timer == 0 )
{
	playsound_at( snd_landmine_explode, x, y );
	
	var inst_explode = instance_create_depth( x, y, z - ( height ), obj_hazard_explosion );
	var inst_shockwave = instance_create_depth( x, y, z - ( height ), obj_effect_shockwave );
	
	effects_explode_mortar();
	
	spawn_particle(
	obj_particle_generic,
	spr_effect_explosion_med,
	random_range( 0.65, 0.75 ),
	random_range( -360, 360 ),
	random_range( -360, 360 ),
	1,
	x,
	y,
	0,
	0,
	random_range( 0.90, 1.35 ),
	false,
	true,
	z - 2,
	true,
	0.01
	);
	
	repeat( random_range( 24, 32 ) )
	{
		spawn_particle(
			obj_particle_generic,
			spr_effect_spark,
			0.2,
			random_range( -360, 360 ),
			random_range( -360, 360 ),
			0.8,
			x,
			y,
			random_range( 2, 4 ),
			random_range( 0.1, 0.2 ),
			1,
			false,
			true,
			z - 2,
			true,
			0.05
		);
	}
	
	instance_destroy();
}