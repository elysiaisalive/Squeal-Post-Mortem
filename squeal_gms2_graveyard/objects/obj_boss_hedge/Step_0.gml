event_inherited();

var target_dir	= point_direction( x, y, currentTarget.x, currentTarget.y )
var target_dis	= point_distance( x, y, currentTarget.x, currentTarget.y )
var turn_spd	= 0.08;
var stop_dist	= 16 * 10;
var back_dist	= 16 * 8;
var melee_dist	= 16 * 4;

var spot_x		= 0;
var spot_y		= 0;
var heat_amount = 0.005;

siner += 0.05;

currentTriggerReset = clamp( currentTriggerReset - delta / 60, 0, 10000 );

#region Boss Stage Logic
if ( stats.hp <= 750 )
{
	boss_stage = STAGE.TWO;
}

switch( boss_stage )
{
	case STAGE.ONE :
		
		break;
	case STAGE.TWO :
		if ( !smoke_deployed )
		{
			instance_create_depth( x, y, -15, obj_item_smokegrenade );
			
			smoke_deployed = true;
		}
		break;
}
#endregion

if ( obj_player.char_state == CSTATE.ALIVE )
{
	#region Attacking While Player is in LoS
	if ( CheckVisionLoS( obj_player ) )
	{
		track_timer = track_maxtimer;
		idle_timer = idle_maxtimer;
		
		target_spotted = true;
		
		currentTarget = obj_player;
		spot_x = currentTarget.x;
		spot_y = currentTarget.y;
	
		charLookDir = rotate_to( charLookDir, target_dir, turn_spd );
		
		if ( barrel_heat <= 0 )
		{
			movementDirection = target_dir;
			charVelocity = movement_acc;
		}
		
		var attack_angle = abs( angle_difference( target_dir, charLookDir ) ) < 15;
	
		#region Backpedaling / Stopping Behaviour
		if ( target_dis < stop_dist )
		{
			charVelocity = 0;
		}

		if ( target_dis <= back_dist )
		{
			charVelocity = movement_acc * 2.5;
			movementDirection = target_dir - 180;
		}
		#endregion
		#region MELEE if too close
		if ( target_dis < melee_dist )
		{
			if ( attack_angle )
			{
				//currentWeapon = scr_melee_m2();
				currentWeapon.trigger_pressed = true;
			
				charAttackWeapon( false );
				charVelocity = 0;
			}
		}
		else
		{
			currentWeapon = scr_gun_m2();
		}
		#endregion
	
		if ( attack_angle && currentWeapon.itemName == "M2" )
		{
			currentWeapon.trigger_pressed = true;
			
			charAttackWeapon( false );
			
			if ( !barrel_cool )
			{
				barrel_heat = max( 0, barrel_heat + heat_amount * delta );
			}
		}
	}
	#endregion
	#region Tracking Player Through Solid Objects
	else
	if ( target_spotted )
	{
		track_timer = max( 0, track_timer - 1 * delta );
		
		currentTarget = obj_player;
		charVelocity = 0;
		
		spot_x = currentTarget.x;
		spot_y = currentTarget.y;
		
		charLookDir = rotate_to( charLookDir, target_dir, turn_spd );
		
		if ( track_timer > 0 )
		{
			var attack_angle = abs( angle_difference( target_dir, charLookDir ) ) < 15;
	
			if ( attack_angle && currentWeapon.itemName == "M2" )
			{
				currentWeapon.trigger_pressed = true;
			
				charAttackWeapon( false );
				
				if ( !barrel_cool )
				{
					barrel_heat = max( 0, barrel_heat + heat_amount * delta );
				}
			}
		}
		
		if ( track_timer == 0 )
		{
			target_spotted = false;
		}
	}
	else
	idle_timer = max( 0, idle_timer - 1 );
		// temp
	if ( idle_timer == 0 )
	{
		bomb_delay = max( 0, bomb_delay - 1 );
			
		if ( bomb_delay == 0 )
		{
			repeat( random_range( 1, 4 ) )
			{
				instance_create_depth( obj_player.x + random_range( -32, 32 ), obj_player.y + random_range( -32, 32 ), -15, obj_hedge_mortar );
			}
			
			bomb_delay = bomb_maxdelay;
		}
	}
	#endregion	
}
else
{
	charVelocity = 0;
}

#region Barrel Overheat	
if ( sprite_index = charGetSpriteFromIndex( self, "WalkM2" ) )
{
	barrel_sprite = charGetSpriteFromIndex( self, "WalkM2OverHeat" );
}
else
if ( sprite_index = charGetSpriteFromIndex( self, "AttackM2" ) )
{
	barrel_sprite = charGetSpriteFromIndex( self, "AttackM2OverHeat" );
}

if ( barrel_heat >= 0.6 )
{
	var dist = point_distance( 0, 0, 46, 15 );	
	var dir = point_direction( 0, 0, 46, 15 );
	
	var offset_x = lengthdir_x( dist, dir + charLookDir );
	var offset_y = lengthdir_y( dist, dir + charLookDir );
	
	heat_time = max( 0, heat_time - 1 * delta );
	
	if ( heat_time == 0 )
	{
		spawn_particle( 
			obj_particle_generic, 
			spr_impact_smoke2, 
			0.2, 
			random(360), 
			random(360), 
			random_range( 0.8, 1 ), 
			x + offset_x, 
			y + offset_y, 
			random_range( 1, 2 ), 
			random_range( 0.2, 0.3 ), 
			1, 
			true,
			false,
			-95
			);
			
		heat_time = random_range( 3, 6 );
	}
}

//
if ( barrel_heat >= 1 )
{
	playsound_at( snd_overheat, x, y );
	sprite_index = charGetSpriteFromIndex( self, "TroubleShootM2" )
	
	image_speed = 0.2 * delta;

	canMove = false;
	can_attack = false;
	barrel_cool	= true;
}

if ( barrel_cool )
{
	barrel_heat = max( 0, barrel_heat - heat_amount * delta );
	
	if ( barrel_heat == 0 && image_index <= image_number - 1 )
	{
		sprite_index = charGetSpriteFromIndex( self, "WalkM2" )
		
		image_speed = 0;
		barrel_cool = false;
		canMove = true;
		can_attack = true;
	}
}

barrel_heat = clamp( barrel_heat, 0, 1 );
#endregion

#region Death

if ( stats.armour == 0 && !shattered )
{
	playsound_at( snd_armor_shatter, x, y );

	gpu_set_blendmode( bm_subtract );
	
	spawn_particle( 
	obj_particle_generic, 
	spr_effect_shatter, 
	0.4, 
	0, 
	0, 
	1, 
	x, 
	y, 
	0, 
	0, 
	1, 
	true,
	false,
	-95
	);
	
	gpu_set_blendmode( bm_normal );
	
	shattered = true;
}

if ( stats.hp <= 0 )
{
	char_state = CSTATE.DEAD;
	instance_destroy();
}

#endregion
