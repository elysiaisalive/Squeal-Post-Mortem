function gore_melee( victim )
{	
	switch( attack_type )
	{
		case ATTACKTYPE.BLUNT :		
		
			playsound_at( snd_hit_item, victim.x, victim.y );
			playsound_at( snd_cut2, victim.x, victim.y );
			global.shake = 5;
			
			var body = instance_create_depth( victim.x, victim.y, -15, obj_deadbody );
			
			body.sprite_index = charGetSpriteFromIndex( victim, "DeadBlunt" ) ?? FALLBACK_SPRITE;
			body.image_index = floor( random( victim.image_index ) );
			body.gore_spd = random_range( 4, 6 );
			body.gore_frc = random_range( 0.3, 0.4 );
			body.create_bloodpool = true;
			body.done = false;
			body.direction = victim.charLookDir;
			body.image_angle = body.direction;
			
			repeat( random_range( 6, 8 ) )
			{
				var inst = instance_create_depth( victim.x, victim.y, -15, obj_gore_blood_drop );
				
				inst.sprite_index = spr_blood_drop;
				inst.done = false;
				inst.advancespeed = random_range( 0.1, 0.3 );
				inst.gore_spd = random_range( 5, 6 );
				inst.gore_frc = random_range( 0.4, 0.5 );
				inst.direction = random_range( -360, 360 );
				inst.image_angle = inst.direction;
			}
			
			switch( victim.charName )
			{
				#region Pig
				case "Pig" :
					repeat( random_range( 5, 7 ) )
					{
						var inst = instance_create_depth( victim.x, victim.y, -15, obj_gore_bloodstatic );
						
						inst.sprite_index = spr_gore_fleshchunkhuman;
						inst.image_index = floor( random( victim.image_index ) );
						inst.flying = true;
						inst.fly_speed = 20;
						inst.splat = true;
						inst.gore_spd = random_range( 4, 6 );
						inst.gore_frc = random_range( 0.2, 0.4 );
						inst.direction = random_range( -360, 360 );
						inst.image_angle = inst.direction;
					};
					break;
				#endregion
				#region Joe
				case "Joe" :
				switch( body.image_index )
				{
					case 0 :
						repeat( random_range( 10, 12 ) )
						{
							var inst = instance_create_depth( victim.x, victim.y, -15, obj_gore_bloodsplat );
							
							inst.gore_spd = random_range( 2, 5 );
							inst.gore_frc = random_range( 0.2, 0.4 );
							inst.direction = random_range( -360, 360 );
							inst.image_angle = inst.direction;
						};
						break;
					case 4 :
						#region Blood
						repeat( random_range( 10, 12 ) )
						{
							var inst = instance_create_depth( victim.x, victim.y, -15, obj_gore_generic );
							
							inst.sprite_index = choose( sprBloodSmudge, sprBloodSmudge2, sprBloodSmudge3 );
							inst.x = body.x + lengthdir_x( 48, body.direction );
							inst.y = body.y + lengthdir_y( 48, body.direction );
							inst.advancespeed = random_range( 0.1, 0.3 );
							inst.gore_spd = random_range( 2, 5 );
							inst.gore_frc = random_range( 0.2, 0.4 );
							inst.done = false;
							inst.animated = true;
							inst.direction = body.direction + random_range( 15, 35 );
							inst.image_angle = inst.direction;
						};
						repeat( random_range( 4, 6 ) )
						{
							var inst = instance_create_depth( victim.x, victim.y, -15, obj_gore_generic );
							
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
						};
						#endregion
						#region Brains
						repeat( random_range( 14, 18 ) )
						{
							var inst = instance_create_depth( victim.x, victim.y, -15, obj_gore_generic );
							
							inst.sprite_index = sprBrains;
							inst.image_index = floor( random( victim.image_index ) );
							inst.x = body.x + lengthdir_x( 48, body.direction );
							inst.y = body.y + lengthdir_y( 48, body.direction );
							inst.gore_spd = random_range( 2, 4 );
							inst.gore_frc = random_range( 0.1, 0.2 );
							inst.flying = true;
							inst.flying_speed = random_range( 8, 12 );
							inst.done = false;
							inst.direction = body.direction + random_range( 15, 35 );
							inst.image_angle = inst.direction;
						};
						repeat( random_range( 3, 4 ) )
						{
							var inst = instance_create_depth( victim.x, victim.y, -15, obj_gore_generic );
							
							inst.sprite_index = choose( sprBrainSplatter, sprBrainSplatter2 );
							inst.x = body.x + lengthdir_x( 48, body.direction );
							inst.y = body.y + lengthdir_y( 48, body.direction );
							inst.advancespeed = random_range( 0.1, 0.2 );
							inst.gore_spd = random_range( 3, 4 );
							inst.gore_frc = random_range( 0.1, 0.2 );
							inst.animated = true;
							inst.done = false;
							inst.direction = body.direction + random_range( 20, 35 );
							inst.image_angle = inst.direction;
						};
						repeat( random_range( 8, 12 ) )
						{
							var inst = instance_create_depth( victim.x, victim.y, -15, obj_gore_generic );
							
							inst.sprite_index = spr_gore_fleshchunkhuman;
							inst.image_index = floor( random( victim.image_index ) );
							inst.x = body.x + lengthdir_x( 38, body.direction );
							inst.y = body.y + lengthdir_y( 38, body.direction );
							inst.gore_spd = random_range( 4, 6 );
							inst.gore_frc = random_range( 0.3, 0.5 );
							inst.done = false;
							inst.direction = body.direction + random_range( 20, 35 );
							inst.image_angle = inst.direction;
						};
						#endregion
						break;
				};
					break;		
				#endregion
			};
			break;
	};
};
