function gore_bullet( _proj, _dir, _id )
{
	repeat( random_range( 9, 12 ) )
	{
		var inst = instance_create_depth( x, y, -2, obj_gore_blood_drop );
		inst.sprite_index = spr_blood_drop;
		inst.done = false;
		inst.advancespeed = random_range( 0.1, 0.3 );
		inst.gore_spd = random_range( 2, 6 );
		inst.gore_frc = random_range( 0.4, 0.5 );
		inst.direction = random_range( -360, 360 );
		inst.image_angle = inst.direction;
	}
	
	repeat( random_range( 8, 12 ) )
	{
		var inst = instance_create_depth( x, y, -1, obj_gore_generic )
		inst.sprite_index = spr_gore_fleshchunkhuman;
		inst.image_index = floor( random( sprite_get_number( inst.sprite_index ) ) );
		inst.gore_spd = random_range( 4, 6 );
		inst.gore_frc = random_range( 0.3, 0.5 );
		inst.done = false;
		inst.splat = true;
		inst.direction = random_range( -360, 360 );
		inst.image_angle = inst.direction;
	}

	switch( _proj.pen_power )
	{
		default :	
			var body = instance_create_depth( x, y, -5, obj_deadbody );
			body.sprite_index = charGetSpriteFromIndex( _id, choose( "DeadRifleMeatShot", "DeadRifleHeadShot" ) ) ?? FALLBACK_SPRITE;
			body.image_index = floor( random( sprite_get_number( inst.sprite_index ) ) );
			body.gore_spd = random_range( 3, 4 );
			body.gore_frc = random_range( 0.1, 0.3 );
			body.create_bloodpool = true;
			body.done = false;
			body.direction = _dir;
			body.image_angle = body.direction;
			
			repeat( random_range( 4, 6 ) )
			{
				var inst = instance_create_depth( x, y, -1, obj_gore_generic )
				inst.sprite_index = choose( sprBloodSplat, sprBloodSplat2, sprBloodSplat3, sprBloodSplat4 );
				inst.x = body.x + lengthdir_x( 32, body.direction );
				inst.y = body.y + lengthdir_y( 32, body.direction );
				inst.advancespeed = random_range( 0.1, 0.3 );
				inst.gore_spd = random_range( 2, 5 );
				inst.gore_frc = random_range( 0.2, 0.4 );
				inst.done = false;
				inst.animated = true;
				inst.direction = body.direction + random_range( 5, 45 );
				inst.image_angle = inst.direction;
			}
			break;
		case BULLETCAL.PELLET :	
			var body = instance_create_depth( x, y, -5, obj_deadbody );
			body.sprite_index = charGetSpriteFromIndex( _id, choose( "DeadShotgunMeatShot", "DeadShotgunHeadShot", "DeadShotgunGutShot" ) ) ?? FALLBACK_SPRITE;
			body.image_index = floor( random( sprite_get_number( inst.sprite_index ) ) );
			body.gore_spd = random_range( 2, 4 );
			body.gore_frc = random_range( 0.3, 0.4 );
			body.create_bloodpool = true;
			body.done = false;
			body.direction = _dir;
			body.image_angle = body.direction;
			break;
		case BULLETCAL.HIGH :			
			var body = instance_create_depth( x, y, -5, obj_deadbody );
			body.sprite_index = charGetSpriteFromIndex( _id, choose( "DeadHighCalMeatShot", "DeadHighCalHeadShot" ) ) ?? FALLBACK_SPRITE;
			body.image_index = floor( random( sprite_get_number( inst.sprite_index ) ) );
			body.gore_spd = random_range( 2, 4 );
			body.gore_frc = random_range( 0.3, 0.4 );
			body.create_bloodpool = true;
			body.done = false;
			body.direction = _dir;
			body.image_angle = body.direction;
			break;
	}
}