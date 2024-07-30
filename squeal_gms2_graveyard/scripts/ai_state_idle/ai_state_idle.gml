function ai_state_idle() {
	if ( !looking_for_gun
	&& currentTarget.char_state != CSTATE.DEAD ) {
		// Only get aggro if the faction is not allied
		if ( CheckVisionLoS( currentTarget ) 
		|| CheckMovementLoS( currentTarget ) ) {
			// Reaction Delay
			suspicionTimer.Unpause();
			
			// Set variable suspicion timer based on target proximity
			var _target_dist = aiGetTargetDistance();
			var _default_spd = 1;
			var _max_spd = 5;
			var _scale = 1;
			var _variable_tick = _scale * _target_dist;
			
			suspicionTimer.SetTickSpeed( min( max( _variable_tick, _default_spd ) ), _max_spd );
				
			if ( suspicionTimer.GetTime() <= 0 ) {
				if ( currentWeapon.itemName != "unarmed" ) {
					if ( enemy_alert != EALERT.ALERTED 
					&& enemy_alert != EALERT.READY ) {
						enemy_alert = EALERT.ALERTED;
					}
						
					seen_x = currentTarget.x;
					seen_y = currentTarget.y;
						
					if ( enemy_behaviour != EBEHAVIOUR.HIDER ) {
						enemy_state = ESTATE.ATTACK;	
					};
				}
				else {
					/* 
						If we are unarmed, for now we will just temporarily look at the player.
						TODO: Enemies surrender/and or call a function that changes what they do when they are in this defenseless cState, e.x; pull out knife or something
					*/
					enemy_alert = EALERT.ALERTED;
					charLookDir = rotate_to( charLookDir, aiGetTargetDirection(), 0.15 );
				}
			}
		}
		else {
			suspicionTimer.set_time = min( suspicionTimer.set_maxtime, suspicionTimer.set_time + 1 );
			suspicionTimer.Pause();
		}
		
		currentBehaviour();
	};
};