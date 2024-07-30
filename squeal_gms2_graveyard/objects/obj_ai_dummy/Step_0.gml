event_inherited();

suspicionTimer.Tick();
searchTimer.Tick();

if ( currentTarget == noone ) {
	currentTarget = aiGetClosestTarget( obj_character );
}

if ( stats.hp == 0 )
{
	char_state = CSTATE.DEAD;
	can_collide_proj = false;
	instance_destroy();
};

if ( no_chase && ( currentWeapon.attack_type != ATTACKTYPE.GUN ) )
{
	no_chase = false;
};

#region AI States
if ( entFlags.HasFlag( ENT_FLAGS.ACTIVE )
&& instance_exists( currentTarget )
&& global.input_target != self ) {
	currentTriggerReset = clamp( currentTriggerReset - delta / 60, 0, 10000 );

	if ( currentTarget.char_state == CSTATE.DEAD ) {
		enemy_state = ESTATE.IDLE;
		enemy_alert = EALERT.UNALERT;
		charVelocity = 0;
	};

	switch( enemy_alert )
	{
		case EALERT.UNALERT :
			turn_spd = 0.5;
			break;
		case EALERT.ALERTED :
			turn_spd = 0.8;
			break;
		case EALERT.READY :
			turn_spd = 0.9;
			break;
	};

	if ( ( char_state == CSTATE.ALIVE ) 
	&& ( char_status == STATUS.NEUTRAL ) )
	{
		// Check if we can find a weapon
		// if ( CheckFindWeapon() )
		// {
		// 	// If we find a target
		// 	var _wep = FindWeapon();
			
		// 	if ( _wep.result )
		// 	{
		// 		// Goto the weapon
		// 		GotoObject( _wep.target );
		// 	};
		// };
		
		switch( enemy_state )
		{
			case ESTATE.IDLE :
				ai_state_idle();
				break;
			case ESTATE.ATTACK :
				ai_state_attack();
				break;
			case ESTATE.SEARCH :
				ai_state_search( obj_player );
				break;
			#region Return state
			case ESTATE.RETURN :
				if ( player.char_state == CSTATE.ALIVE )
				{	
					if ( CheckVisionLoS( obj_player ) 
					&& CheckMovementLoS( obj_player ) )
					{
						if ( currentWeapon.itemName != "Unarmed" )
						{
							if ( currentWeapon.firemode_type != FIREMODE.MELEE )
							{
								enemy_state = ESTATE.ATTACK;
							}
							else if ( CheckMovementLoS( obj_player ) )
							{
								enemy_state = ESTATE.ATTACK;
							}
					
							if ( enemy_alert != EALERT.ALERTED 
							&& enemy_alert != EALERT.READY )
							{
								enemy_alert = EALERT.ALERTED;
							}
						}
					}
					else if ( CalculatePathToPoint( [xstart, ystart] ) )
					{
						MoveThroughPath( currentPath, 2.50, function() {
							charVelocity = 0;
							enemy_state = ESTATE.IDLE;
							enemy_alert = EALERT.READY;
						
							if ( enemy_behaviour == EBEHAVIOUR.PATROL ) 
							{
								enemy_state = ESTATE.IDLE;
								charLookDir = start_angle;
							};
						} );
					};
				};
				break;
			#endregion
		};
	};
};
#endregion