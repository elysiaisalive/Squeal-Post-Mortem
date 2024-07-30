function gore_explosionouter( object ) {
	
	var body = instance_create_depth( object.x, object.y, -15, obj_deadbody );
	var _dist = point_distance( other.x, other.y, body.x, body.y );
	var _dir = point_direction( other.x, other.y, body.x, body.y );
	body.sprite_index = charGetSpriteFromIndex( object, "DeadExplosionOuter" ) ?? FALLBACK_SPRITE;
	body.image_index = floor( random( sprite_get_number( body.sprite_index ) ) );
	body.gore_spd = random_range( 3, 4 ) * ( _dist * 0.01 );
	body.gore_frc = random_range( 0.1, 0.2 );
	body.create_bloodpool = true;
	body.direction = _dir + random_range( -30, 30 );
	body.image_angle = body.direction;
	
	repeat( random_range( 6, 8 ) )
	{
		var inst = instance_create_depth( object.x, object.y, -15, obj_gore_generic );
		inst.sprite_index = choose( sprBloodSmudge, sprBloodSmudge3, sprBloodSmudge4 );
		inst.surfacetype = obj_surface_manager.GetSurf();
		inst.done = false;
		inst.animated = true;
		inst.advancespeed = random_range( 0.1, 0.3 );
		inst.gore_spd = random_range( 2, 3 );
		inst.gore_frc = random_range( 0.1, 0.2 );
		inst.direction = random_range( -360, 360 );
		inst.image_angle = inst.direction;
	}
	repeat( random_range( 4, 8 ) )
	{
		var inst = instance_create_depth( object.x, object.y, -15, obj_gore_generic );
		inst.sprite_index = choose( sprBloodSplat2, sprBloodSplat3, sprBloodSplat4, sprBloodSplat5 );
		inst.surfacetype = obj_surface_manager.GetSurf();
		inst.done = false;
		inst.animated = true;
		inst.advancespeed = random_range( 0.1, 0.2 );
		inst.gore_spd = random_range( 1, 3 );
		inst.gore_frc = random_range( 0.2, 0.3 );
		inst.direction = random_range( -360, 360 );
		inst.image_angle = inst.direction;
	}
	
	switch( object.char )
	{
		default :
			println( "BOOM" );
			break;
		#region Joe
		case "Joe" :
			switch( body.image_index )
			{
				case 0 :					
					var inst = instance_create_depth( object.x, object.y, -15, obj_gore_generic );
					inst.sprite_index = charGetSpriteFromIndex( object, "GoreExplosionLeg" );
					inst.image_index = random( image_number );
					inst.x = object.x + lengthdir_x( 12, inst.image_angle );
					inst.y = object.y + lengthdir_y( 8, inst.image_angle );
					inst.surfacetype = obj_surface_manager.GetBodySurf();
					inst.splat = true;
					inst.gore_spd = random_range( 3, 4 );
					inst.gore_frc = random_range( 0.1, 0.2 );
					inst.flying = true;
					inst.flying_speed = random_range( 3, 6 );
					inst.done = false;
					inst.direction = body.direction - 180 + random_range( -5, 10 );
					inst.image_angle = inst.direction;
					break;
				case 1 :
					var inst = instance_create_depth( object.x, object.y, -15, obj_gore_generic );
					inst.sprite_index = charGetSpriteFromIndex( object, "GoreExplosionArm" );
					inst.image_index = random( image_number );
					inst.x = object.x + lengthdir_x( 8, inst.image_angle );
					inst.y = object.y + lengthdir_y( 16, inst.image_angle );
					inst.surfacetype = obj_surface_manager.GetBodySurf();
					inst.splat = true;
					inst.gore_spd = random_range( 3.5, 4 );
					inst.gore_frc = random_range( 0.1, 0.2 );
					inst.flying = true;
					inst.flying_speed = random_range( 6, 8 );
					inst.done = false;
					inst.direction = body.direction + random_range( 20, 30 );
					inst.image_angle = inst.direction;
					break;
			}
			break;
		#endregion
	}
}