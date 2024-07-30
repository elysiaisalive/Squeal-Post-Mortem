event_inherited();

if ( debris_spd == 0 )
{
	
	spawn_particle(
	obj_particle_generic,
	spr_effect_smoke_med,
	0.4,
	random_range( -360, 360 ),
	random_range( -360, 360 ),
	0.5,
	x,
	y,
	random_range( 2, 3 ),
	random_range( 0.1, 0.2 ),
	random_range( 0.5, 0.8 ),
	true,
	true,
	-95,
	true,
	0.05
	);
	
	repeat( random_range( 3, 4 ) )
	{
		var inst = instance_create_depth( x, y, -15, obj_debris_generic );
		inst.sprite_index = spr_debris_dirt_med;
		inst.image_index = floor( random( sprite_get_number( sprite_index ) ) );
		inst.debris_spd = random_range( 4, 5 );
		inst.debris_frc = random_range( 0.2, 0.3 );
		inst.flying = true;
		inst.flyspeed = 8;
		inst.animated = false;
		inst.direction = random( 360 );
	}
	repeat( random_range( 6, 8 ) )
	{
		var inst = instance_create_depth( x, y, -15, obj_debris_generic );
		inst.sprite_index = spr_debris_dirt_small;
		inst.image_index = floor( random( sprite_get_number( sprite_index ) ) );
		inst.debris_spd = random_range( 2, 3 );
		inst.debris_frc = random_range( 0.2, 0.3 );
		inst.flying = true;
		inst.flyspeed = 8;
		inst.animated = false;
		inst.direction = random( 360 );
	}
}