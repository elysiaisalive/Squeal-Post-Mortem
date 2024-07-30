function effects_explode_debris(  ) {
	
	repeat( random_range( 4, 5 ) )
	{
		var inst = instance_create_depth( x, y, -15, obj_debris_dirt );
		inst.sprite_index = spr_debris_dirt_big;
		inst.image_index = floor( random( sprite_get_number( sprite_index ) ) );
		inst.debris_spd = random_range( 8, 12 );
		inst.debris_frc = random_range( 0.6, 0.8 );
		inst.flying = true;
		inst.flyspeed = 8;
		inst.animated = false;
		inst.direction = random( 360 );
	}
	repeat( random_range( 6, 8 ) )
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
	repeat( random_range( 8, 12 ) )
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