currentState.Run();
movementTimer.Tick();
statuses.Tick();
charTick();

currentTriggerReset = clamp( currentTriggerReset - ( delta / GAME_FPS ), 0, 10000 );

#region Down / Recovery Logic
if ( instance_exists( obj_weapon_generic ) ) {
	var weapon = instance_nearest( x, y, obj_weapon_generic );
	
	if ( weapon 
	&& CanDown 
	&& can_collide_item 
	&& ( weapon.gun_spd >= 5 ) 
	&& place_meeting( x, y, weapon )
	&& ( char_state != CSTATE.DEAD ) )
	{
		if ( char_state != CSTATE.DOWN )
		{
			if ( weapon.gun.throw_dmg > 0 ) {
				stats.hp -= weapon.gun.throw_dmg;
			}
			
			charVelocity = 0;
			charLookDir = weapon.direction - 180;
			knocked_index = 0;
			enemy_state = ESTATE.IDLE;
			enemy_alert = EALERT.UNALERT;
			char_state = CSTATE.DOWN;
			height = 5;
			weapon.gun_spd = 0;	
			global.shake = 10;
			
			playsound_at( snd_hit_item, x, y, 16 * 8, 16 * 8, random_range( 0.8, 1.1 ) );
			path_end();
		}
	}
	else
	if ( !CanDown && can_collide_item && ( weapon.gun_spd >= 5 ) && place_meeting( x, y, weapon ) && ( char_state != CSTATE.DEAD ) )
	{
		weapon.direction = weapon.direction - 180;
		weapon.gun_spd *= 0.4;	
		global.shake = 10;
				
		playsound_at( snd_hit_item, x, y, 16 * 8, 16 * 8, random_range( 0.8, 1.1 ) );
	};
};

knocked_index = clamp( knocked_index, 0, 5 );
knocked_timer = clamp( knocked_timer, 0, knocked_timer_max );
#endregion
#region Character States
switch( char_state ) {	
	#region Execution
	case CSTATE.ALIVE :
		break;
	case CSTATE.DOWN :
		can_collide_item = false;
		can_collide_proj = false;
		charVelocity = 0;
		currentWeapon.trigger_pressed = false;
		charThrowWeapon( random_range( 2, 4 ) );
		knocked_timer = max( knocked_timer - 1 * delta );
		
		if ( knocked_timer <= 0 && CanGetUp == true )
		{
			knocked_index += recovery_spd * delta;
	
			if ( floor( knocked_index >= 5 ) )
			{
				char_state = CSTATE.ALIVE;
				can_collide_item = true;
				can_collide_proj = true;
				knocked_timer = knocked_timer_max;
				knocked_index = 0;
				height = character_height;
			};
		};
		break;
	case CSTATE.EXECUTE :
		break;
	#endregion
	#region Character Death
	case CSTATE.DEAD :
		// instead call this when the character actually gets killed
		KillCharacter();
		break;
	#endregion
};
#endregion

movement_impulse -= 1 * delta;
movement_impulse = clamp( movement_impulse, 0, 12 );

damageTaken = max( 0, damageTaken - 2 * delta );
damageTaken = clamp( damageTaken, 0, 32 );

stats.hp = clamp( stats.hp, 0, stats.hp_max );
stats.armour = clamp( stats.armour, 0, stats.armour_max );

currentXSpd += dcos( movement_impulsedir ) * movement_impulse * delta;
currentYSpd -= dsin( movement_impulsedir ) * movement_impulse * delta;