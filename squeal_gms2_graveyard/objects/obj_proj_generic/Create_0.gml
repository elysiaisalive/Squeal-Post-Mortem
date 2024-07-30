currentFaction	= FACTION.SOLO;
hit 			= false;
color_1			= #fff01a;
color_2			= #ffead9;

z				= depth;
height			= 2;

var inst = instance_create_depth( x, y, depth + 1, obj_effect_bullettrail );
inst.bullet_instance = id;

bullet = new base_projectile();
bullet.Draw = function() {
	draw_sprite_ext( bullet.proj_sprite, bullet.proj_index, x + bullet.life * 0.25, y + bullet.life * 0.25, 1, 1, image_angle, c_black, 0.2 );
	
	gpu_set_blendmode( bm_add );
	
	draw_sprite_ext( bullet.proj_sprite, bullet.proj_index, x, y, max( 1, bullet.velocity / bullet.life ), 1, image_angle, merge_colour( c_white, c_yellow, bullet.life ), 0.1 * bullet.life );
	
	gpu_set_blendmode( bm_normal );
};

EndStep = function() {
	#region Solid Collisions
	var entity_hit = collision_solid();
	var hit_wall = noone;

	if ( entity_hit.result ) {
		for( var i = 0; i < array_length( entity_hit.id ); ++i ) {
			entity_hit.id[i].proj_hit_id = id;
			
			if ( entity_hit.id[i].on_proj_hit() )
			&& ( entity_hit.id[i].collision_flags & BLOCK_PROJECTILE ) {
				hit_wall = entity_hit.id[i].proj_hit_id;
				
				while( place_meeting( x, y, entity_hit.id[i] ) ) {
					x  -= lengthdir_x( 0.25, direction );
					y  -= lengthdir_y( 0.25, direction );
				};
			};
		};
	};
	#endregion
	#region Entity Collisions
	entity_hit = collision_entity();
		
	if ( entity_hit.result 
	&& ( hit_wall == noone ) )
	{
		var _lenx = lengthdir_x( -8, direction );
		var _leny = lengthdir_y( -8, direction );
		
		for( var i = 0; i < array_length( entity_hit.id ); ++i )
		{
			if ( entity_hit.id[i].can_collide_proj 
			&& charCheckFactionIsAllied( bullet.owner, entity_hit.id[i] ) 
			&& !hit
			&& bullet.GetLife() > 0 )
			{
				bullet.pen_power = clamp( bullet.pen_power, 0, 64 );
				--bullet.pen_power;
				
				#region HP Hit
				if ( entity_hit.id[i].stats.armour <= 0 )
				{
					entity_hit.id[i].proj_hit_id = id;
					
					if ( entity_hit.id[i].on_proj_hit() )
					{
						if ( bullet.pen_power <= 0 )
						{
							while( place_meeting( x, y, entity_hit.id[i] ) )
							{
								x  -= lengthdir_x( 2, direction );
								y  -= lengthdir_y( 2, direction );
							}
						}
						
						++entity_hit.id[i].proj_hits;
						entity_hit.id[i].stats.hp -= ( bullet.GetHPDMG() );
						
						if ( ( entity_hit.id[i].stats.hp <= 1 ) 
						|| ( bullet.GetHPDMG() > entity_hit.id[i].stats.hp ) )
						{
							if ( ( entity_hit.id[i].proj_hits <= 0 ) )
							{
								entity_hit.id[i].on_proj_death();
							}
							else
							if ( ( entity_hit.id[i].proj_hits > 6 ) 
							|| ( bullet.GetValue( bullet.pen_power ) >= 12 ) )
							{
								entity_hit.id[i].on_proj_overload();
							}
						}
					}
				}
				#endregion
				else
				#region Armour Hit
				if ( entity_hit.id[i].stats.armour >= 0 )
				{	
					entity_hit.id[i].proj_hit_id = id;
					entity_hit.id[i].on_proj_hit_armour();
					
					var inst = playsound_at( snd_armor_hit, x, y, , , random_range( 0.5, 1 ) );
					inst.CullSound( 16 * 2 );
					
					if ( ( entity_hit.id[i].stats.armour <= 1 ) 
					|| ( bullet.GetArmourDMG() >= entity_hit.id[i].stats.armour ) )
					{
						entity_hit.id[i].stats.armour = 0;
						entity_hit.id[i].on_armour_break();
					}
					
					entity_hit.id[i].stats.armour -= bullet.GetArmourDMG();
					entity_hit.id[i].damageTaken = 8 * ( bullet.hp_dmg / 4 );
				
					entity_hit.id[i].damageTaken = clamp( entity_hit.id[i].damageTaken, 0, 32 );
				}
				#endregion
				if ( bullet.pen_power <= 0 )
				{
					hit = true;
				}
			}
			
			if ( hit 
			&& ( bullet.GetPenPower() <= 0 ) )
			{
				bullet.OnImpact( x, y );
				instance_destroy();
			}
		}
	}
	#endregion
	
	if ( hit_wall )
	{
		instance_destroy();
	}
}