function gore_explosioninner( object ) 
{
	var _dir = point_direction( object.x, object.y, x, y );
	
	repeat( random_range( 7, 12 ) )
	{
		var inst = instance_create_depth( object.x, object.y, -15, obj_gore_generic );
		inst.sprite_index = choose( sprBloodSmudge, sprBloodSmudge3, sprBloodSmudge4 );
		inst.surfacetype = obj_surface_manager.GetSurf();
		inst.done = false;
		inst.animated = true;
		inst.advancespeed = random_range( 0.1, 0.3 );
		inst.gore_spd = random_range( 3, 4 );
		inst.gore_frc = random_range( 0.1, 0.2 );
		inst.direction = _dir - 180 + random_range( -360, 360 );
		inst.image_angle = inst.direction;
	}
	repeat( random_range( 16, 24 ) )
	{
		var inst = instance_create_depth( object.x, object.y, -15, obj_gore_generic );
		inst.sprite_index = choose( sprBloodSplat2, sprBloodSplat3, sprBloodSplat4, sprBloodSplat5 );
		inst.surfacetype = obj_surface_manager.GetSurf();
		inst.done = false;
		inst.animated = true;
		inst.advancespeed = random_range( 0.1, 0.2 );
		inst.gore_spd = random_range( 2, 5 );
		inst.gore_frc = random_range( 0.2, 0.3 );
		inst.direction = _dir - 180 + random_range( -360, 360 );
		inst.image_angle = inst.direction;
	}
	
	
	repeat( 32 )
	{
		spawn_particle(
			obj_particle_generic,
			choose( sprBloodWave1, sprBloodWave2, sprBloodWave3 ),
			0.3,
			_dir - 180 + random_range( -90, 90 ),
			0,
			1,
			other.x,
			other.y,
			5, 
			0.2,
			1,
			false,
			true,
			-95,
			true
			);
	}
	
	switch( object.char )
	{
		#region Basic Gore
		default :
			repeat( 2 )
			{
				var inst = instance_create_depth( object.x, object.y, -15, obj_gore_bloodtrail );
				inst.trail_sprite = spr_bloodtrail_small;
				inst.sprite_index = charGetSpriteFromIndex( object, "GoreExplosionLeg" ) ?? FALLBACK_SPRITE;
				inst.image_index = floor( random( sprite_get_number( inst.sprite_index ) ) );
				inst.surfacetype = obj_surface_manager.GetBodySurf();
				inst.splat = true;
				inst.gore_spd = random_range( 4, 5 );
				inst.gore_frc = random_range( 0.1, 0.2 );
				inst.flying = true;
				inst.flying_speed = random_range( 6, 8 );
				inst.done = false;
				inst.direction = _dir - 180 + random_range( -90, 90 );
				inst.image_angle = inst.direction;
			}
			repeat( random_range( 8, 12 ) )
			{
				var torso = instance_create_depth( object.x, object.y, -15, obj_gore_bloodtrail );
				torso.trail_sprite = spr_bloodtrail_small;
				torso.sprite_index = charGetSpriteFromIndex( object, "GoreExplosionTorso" ) ?? FALLBACK_SPRITE;
				torso.image_index = floor( random( sprite_get_number( torso.sprite_index ) ) );
				torso.surfacetype = obj_surface_manager.GetBodySurf();
				torso.splat = true;
				torso.gore_spd = random_range( 4, 4.5 );
				torso.gore_frc = random_range( 0.1, 0.2 );
				torso.flying = true;
				torso.flying_speed = random_range( 3, 6 );
				torso.done = false;
				torso.direction = _dir - 180 + random_range( -90, 90 );
				torso.image_angle = torso.direction;
			}
			repeat( 2 )
			{
				var inst = instance_create_depth( object.x, object.y, -15, obj_gore_generic );
				inst.sprite_index = charGetSpriteFromIndex( object, "GoreExplosionArm" ) ?? FALLBACK_SPRITE;
				inst.image_index = floor( random( sprite_get_number( inst.sprite_index ) ) );
				inst.surfacetype = obj_surface_manager.GetBodySurf();
				inst.splat = true;
				inst.gore_spd = random_range( 3.5, 4 );
				inst.gore_frc = random_range( 0.1, 0.2 );
				inst.flying = true;
				inst.flying_speed = random_range( 6, 8 );
				inst.done = false;
				inst.direction = _dir - 180 + random_range( -90, 90 );
				inst.image_angle = inst.direction;
			}
			repeat( 2 )
			{
				var inst = instance_create_depth( object.x, object.y, -15, obj_gore_generic );
				inst.sprite_index = charGetSpriteFromIndex( object, "GoreExplosionForeArm" ) ?? FALLBACK_SPRITE;
				inst.image_index = floor( random( sprite_get_number( inst.sprite_index ) ) );
				inst.surfacetype = obj_surface_manager.GetBodySurf();
				inst.splat = true;
				inst.gore_spd = random_range( 3.5, 4 );
				inst.gore_frc = random_range( 0.1, 0.2 );
				inst.flying = true;
				inst.flying_speed = random_range( 6, 8 );
				inst.done = false;
				inst.direction = _dir - 180 + random_range( -90, 90 );
				inst.image_angle = inst.direction;
			}
			
			repeat( random_range( 12, 16 ) )
			{
				var inst = instance_create_depth( object.x, object.y, -15, obj_gore_bloodtrail );
				inst.trail_sprite = spr_bloodtrail_small;
				inst.sprite_index = spr_gore_guts ?? FALLBACK_SPRITE;
				inst.image_index = floor( random( sprite_get_number( inst.sprite_index ) ) );
				inst.surfacetype = obj_surface_manager.GetBodySurf();
				inst.splat = true;
				inst.gore_spd = random_range( 2, 5 );
				inst.gore_frc = random_range( 0.1, 0.2 );
				inst.flying = true;
				inst.flying_speed = random_range( 6, 8 );
				inst.done = false;
				inst.direction = _dir - 180 + random_range( -90, 90 );
				inst.image_angle = inst.direction;
			}
			
			repeat( random_range( 12, 16 ) )
			{
				var inst = instance_create_depth( object.x, object.y, -15, obj_gore_generic );
				inst.trail_sprite = spr_bloodtrail_small;
				inst.sprite_index = spr_gore_fleshchunkhuman ?? FALLBACK_SPRITE;
				inst.image_index = floor( random( sprite_get_number( inst.sprite_index ) ) );
				inst.surfacetype = obj_surface_manager.GetBodySurf();
				inst.splat = true;
				inst.gore_spd = random_range( 2, 6 );
				inst.gore_frc = random_range( 0.1, 0.2 );
				inst.flying = true;
				inst.flying_speed = random_range( 6, 8 );
				inst.done = false;
				inst.direction = _dir - 180 + random_range( -90, 90 );
				inst.image_angle = inst.direction;
			}
			
			repeat( random_range( 8, 12 ) )
			{
				var inst = instance_create_depth( object.x, object.y, -15, obj_gore_bloodtrail );
				inst.trail_sprite = spr_bloodtrail_small;
				inst.sprite_index = choose( spr_gore_flyinggut, spr_gore_flyinggut2, spr_gore_flyinggut3, spr_gore_flyinggut4 ) ?? FALLBACK_SPRITE;
				inst.surfacetype = obj_surface_manager.GetBodySurf();
				inst.done = false;
				inst.animated = true;
				inst.advancespeed = random_range( 0.1, 0.2 );
				inst.splat = true;
				inst.gore_spd = random_range( 2, 6 );
				inst.gore_frc = random_range( 0.1, 0.2 );
				inst.flying = true;
				inst.flying_speed = random_range( 8, 12 );
				inst.direction = _dir - 180 + random_range( -90, 90 );
				inst.image_angle = inst.direction;
			}
			
			var inst = instance_create_depth( x, y, -15, obj_gore_generic );
			inst.sprite_index = charGetSpriteFromIndex( object, "GoreExplosionHead" ) ?? FALLBACK_SPRITE;
			inst.image_index = floor( random( sprite_get_number( inst.sprite_index ) ) );
			inst.surfacetype = obj_surface_manager.GetBodySurf();
			inst.splat = true;
			inst.gore_spd = random_range( 3.5, 4 );
			inst.gore_frc = random_range( 0.1, 0.2 );
			inst.flying = true;
			inst.flying_speed = random_range( 6, 8 );
			inst.done = false;
			inst.direction = _dir - 180 + random_range( -90, 90 );
			inst.image_angle = inst.direction;
			
			break;
		#endregion
		#region Hazmat
		case "Hazmat" :
			#region Debris
			repeat( 2 )
			{
				var inst = instance_create_depth( x, y, -15, obj_gore_generic );
				inst.sprite_index = spr_debris_hazmat_mask;
				inst.image_index = floor( random( image_number ) )
				inst.surfacetype = obj_surface_manager.GetBodySurf();
				inst.gore_spd = random_range( 5, 6 );
				inst.gore_frc = random_range( 0.3, 0.4 );
				inst.flying = true;
				inst.flying_speed = random_range( 8, 10 );
				inst.done = false;
				inst.direction = random_range( -360, 360 );
				inst.image_angle = random_range( -360, 360 );
			}
			repeat( 4 )
			{
				var inst = instance_create_depth( x, y, -15, obj_gore_generic );
				inst.sprite_index = spr_debris_hazmat_tank;
				inst.image_index = floor( random( image_number ) )
				inst.surfacetype = obj_surface_manager.GetBodySurf();
				inst.gore_spd = random_range( 5, 6 );
				inst.gore_frc = random_range( 0.3, 0.4 );
				inst.flying = true;
				inst.flying_speed = random_range( 4, 6 );
				inst.done = false;
				inst.direction = random_range( -360, 360 );
				inst.image_angle = random_range( -360, 360 );
			}
			repeat( random_range( 4, 6 ) )
			{
				var inst = instance_create_depth( x, y, -15, obj_gore_generic );
				inst.sprite_index = spr_debris_hazmat_vest_med;
				inst.image_index = floor( random( image_number ) )
				inst.surfacetype = obj_surface_manager.GetBodySurf();
				inst.gore_spd = random_range( 6, 8 );
				inst.gore_frc = random_range( 0.4, 0.5 );
				inst.flying = true;
				inst.flying_speed = random_range( 4, 6 );
				inst.done = false;
				inst.direction = random_range( -360, 360 );
				inst.image_angle = random_range( -360, 360 );
			}
			repeat( 2 )
			{
				var inst = instance_create_depth( x, y, -15, obj_gore_generic );
				inst.sprite_index = spr_debris_hazmat_vest_big;
				inst.image_index = floor( random( image_number ) )
				inst.surfacetype = obj_surface_manager.GetBodySurf();
				inst.gore_spd = random_range( 4, 5 );
				inst.gore_frc = random_range( 0.2, 0.3 );
				inst.flying = true;
				inst.flying_speed = random_range( 4, 6 );
				inst.done = false;
				inst.direction = random_range( -360, 360 );
				inst.image_angle = random_range( -360, 360 );
			}
			repeat( random_range( 18, 22 ) )
			{
				var inst = instance_create_depth( x, y, -15, obj_gore_generic );
				inst.sprite_index = spr_debris_hazmat_rubber;
				inst.image_index = floor( random( image_number ) )
				inst.surfacetype = obj_surface_manager.GetSurf();
				inst.gore_spd = random_range( 4, 5 );
				inst.gore_frc = random_range( 0.3, 0.4 );
				inst.flying = true;
				inst.flying_speed = random_range( 8, 12 );
				inst.done = false;
				inst.direction = random_range( -360, 360 );
				inst.image_angle = random_range( -360, 360 );
			}
			repeat( random_range( 8, 12 ) )
			{
				var inst = instance_create_depth( x, y, -15, obj_gore_generic );
				inst.sprite_index = choose( spr_debris_hazmat_rubberfly, spr_debris_hazmat_rubberfly2 );
				inst.advancespeed = random_range( 0.1, 0.2 );
				inst.surfacetype = obj_surface_manager.GetBodySurf();
				inst.gore_spd = random_range( 4, 5 );
				inst.gore_frc = random_range( 0.2, 0.3 );
				inst.animated = true;
				inst.done = false;
				inst.direction = random_range( -360, 360 );
				inst.image_angle = inst.direction;
			}
			#endregion
			#region Gore
			repeat( 2 )
			{
				var inst = instance_create_depth( x, y, -15, obj_gore_bloodtrail );
				inst.trail_sprite = spr_bloodtrail_small;
				inst.sprite_index = charGetSpriteFromIndex( object, "GoreExplosionLeg" ) ?? FALLBACK_SPRITE;
				inst.image_index = floor( random( image_number ) );
				inst.surfacetype = obj_surface_manager.GetBodySurf();
				inst.splat = true;
				inst.gore_spd = random_range( 4, 5 );
				inst.gore_frc = random_range( 0.1, 0.2 );
				inst.flying = true;
				inst.flying_speed = random_range( 6, 8 );
				inst.done = false;
				inst.direction = random_range( -360, 360 );
				inst.image_angle = inst.direction;
			}
			repeat( 4 )
			{
				var inst = instance_create_depth( x, y, -15, obj_gore_bloodtrail );
				inst.trail_sprite = spr_bloodtrail_small;
				inst.sprite_index = charGetSpriteFromIndex( object, "GoreExplosionTorso" ) ?? FALLBACK_SPRITE;
				inst.image_index = floor( random( image_number ) );
				inst.surfacetype = obj_surface_manager.GetBodySurf();
				inst.splat = true;
				inst.gore_spd = random_range( 4, 4.5 );
				inst.gore_frc = random_range( 0.1, 0.2 );
				inst.flying = true;
				inst.flying_speed = random_range( 3, 6 );
				inst.done = false;
				inst.direction = random_range( -360, 360 );
				inst.image_angle = inst.direction;
			}
			repeat( 2 )
			{
				var inst = instance_create_depth( x, y, -15, obj_gore_generic );
				inst.sprite_index = charGetSpriteFromIndex( object, "GoreExplosionArm" ) ?? FALLBACK_SPRITE;
				inst.image_index = floor( random( image_number ) );
				inst.surfacetype = obj_surface_manager.GetBodySurf();
				inst.splat = true;
				inst.gore_spd = random_range( 3.5, 4 );
				inst.gore_frc = random_range( 0.1, 0.2 );
				inst.flying = true;
				inst.flying_speed = random_range( 6, 8 );
				inst.done = false;
				inst.direction = random_range( -360, 360 );
				inst.image_angle = inst.direction;
			}
			repeat( 2 )
			{
				var inst = instance_create_depth( x, y, -15, obj_gore_generic );
				inst.sprite_index = charGetSpriteFromIndex( object, "GoreExplosionForeArm" ) ?? FALLBACK_SPRITE;
				inst.image_index = floor( random( image_number ) );
				inst.surfacetype = obj_surface_manager.GetBodySurf();
				inst.splat = true;
				inst.gore_spd = random_range( 3.5, 4 );
				inst.gore_frc = random_range( 0.1, 0.2 );
				inst.flying = true;
				inst.flying_speed = random_range( 6, 8 );
				inst.done = false;
				inst.direction = random_range( -360, 360 );
				inst.image_angle = inst.direction;
			}
			repeat( random_range( 12, 16 ) )
			{
				var inst = instance_create_depth( x, y, -15, obj_gore_bloodtrail );
				inst.trail_sprite = spr_bloodtrail_small;
				inst.sprite_index = spr_gore_guts;
				inst.image_index = floor( random( image_number ) );
				inst.surfacetype = obj_surface_manager.GetBodySurf();
				inst.splat = true;
				inst.gore_spd = random_range( 2, 5 );
				inst.gore_frc = random_range( 0.1, 0.2 );
				inst.flying = true;
				inst.flying_speed = random_range( 6, 8 );
				inst.done = false;
				inst.direction = random_range( -360, 360 );
				inst.image_angle = inst.direction;
			}
			#endregion
			
			break;
		#endregion
	}
}