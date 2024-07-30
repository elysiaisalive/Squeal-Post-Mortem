function effects_explode_barrel() {
			
	var inst1 = instance_create_depth( x, y, -10, obj_debris_generic )
	inst1.flying = true;
	inst1.flyspeed = random_range( 4, 5 );
	inst1.animated = false;
	inst1.flaming = true;
	inst1.sprite_index = spr_debris_barrel_big;
	inst1.image_index = 0;
	inst1.debris_spd = random_range( 3, 4 );
	inst1.debris_frc = random_range( 0.1, 0.2 );
	inst1.direction = random_range( 0, 360 );
	inst1.image_angle = random( 360 );
	
	var inst = instance_create_depth( x, y, -10, obj_debris_generic )
	inst.flying = true;
	inst.flyspeed = random_range( 4, 5 );
	inst.animated = false;
	inst.flaming = true;
	inst.sprite_index = spr_debris_barrel_big;
	inst.image_index = 1;
	inst.debris_spd = random_range( 3, 4 );
	inst.debris_frc = random_range( 0.1, 0.2 );
	inst.direction = inst1.direction - 180 + random_range( -60, 60 );
	inst.image_angle = random( 360 );
	
	
	repeat( random_range( 4, 6 ) )
	{
		var inst = instance_create_depth( x, y, -10, obj_debris_generic )
		inst.flying = true;
		inst.flyspeed = random_range( 3, 4 );
		inst.animated = false;
		inst.sprite_index = spr_debris_barrel_med;
		inst.image_index = random( 2 );
		inst.debris_spd = random_range( 4, 6 );
		inst.debris_frc = random_range( 0.2, 0.3 );
		inst.direction = random_range( -360, 360 );
		inst.image_angle = random( 360 );
	}
	
	repeat( random_range( 8, 12 ) )
	{
		var inst = instance_create_depth( x, y, -10, obj_debris_generic )
		inst.sprite_index = spr_debris_barrel_small;
		inst.image_index = random( 4 );
		inst.animated = false;
		inst.flaming = true;
		inst.debris_spd = random_range( 6, 8 );
		inst.debris_frc = random_range( 0.2, 0.3 );
		inst.direction = random_range( -360, 360 );
		inst.image_angle = random( 360 );
	}
	
	repeat( random_range( 12, 16 ) )
	{
		var inst = instance_create_depth( x, y, -10, obj_debris_generic )
		inst.sprite_index = spr_debris_barrel_tiny;
		inst.image_index = random( 4 );
		inst.animated = false;
		inst.debris_spd = random_range( 4, 8 );
		inst.debris_frc = random_range( 0.2, 0.3 );
		inst.direction = random_range( -360, 360 );
		inst.image_angle = random( 360 );
	}
}
