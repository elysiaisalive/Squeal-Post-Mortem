event_inherited();

tank = instance_create_depth( x, y, -95, obj_hazmat_tank );

charInit( "Hazmat", FACTION.AITEAM2, 125, 50 );
initAIDummy();

on_proj_hit_armour	= function() {
	#region Particles
	var _lenx = lengthdir_x( 14, proj_hit_id.direction );
	var _leny = lengthdir_y( 14, proj_hit_id.direction );
	
	repeat( random_range( 6, 8 ) )
	{
		spawn_particle(
			obj_particle_generic,
			spr_effect_spark_armour,
			0.4,
			proj_hit_id.direction - 180 + random_range( -30, 30 ),
			0,
			1,
			x - _lenx,
			y - _leny,
			random_range( 4, 6 ), 
			random_range( 0.3, 0.6 ),
			1,
			false,
			true,
			-95,
			true
			);
	}
	#endregion
};