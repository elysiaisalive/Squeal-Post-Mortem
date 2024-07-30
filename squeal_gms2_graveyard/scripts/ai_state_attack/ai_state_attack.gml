function ai_state_attack() {
	var seen_dir = point_direction( x, y, seen_x, seen_y );

	#region Attack
	switch( currentWeapon.attack_type ) {
		default :
			#region Melee Attack
			if ( CheckVisionLoS( currentTarget ) 
			&& CheckMovementLoS( currentTarget ) ) {
				charVelocity = 0.80;
				movementDirection = seen_dir;
				seen_x = currentTarget.x;
				seen_y = currentTarget.y;
							
				charLookDir = rotate_to( charLookDir, seen_dir, 0.10 * delta );
							
				if ( ( aiGetTargetDistance() <= currentWeapon.range ) 
				&& ( abs( angle_difference( seen_dir, charLookDir ) ) ) <= 25 ) {
					charVelocity = 0;
				
					charAttackWeapon( false );
				};
			}
			else
			if ( !CheckVisionLoS( currentTarget ) 
			&& !CheckMovementLoS( currentTarget ) ) {			
				enemy_state = ESTATE.SEARCH;
			}
			else
			if ( CheckVisionLoS( currentTarget ) 
			&& !CheckMovementLoS( currentTarget ) ) {			
				enemy_state = ESTATE.SEARCH;
			};
			#endregion
			break;
		case ATTACKTYPE.GUN :
			#region Gun Attack
			if ( ( currentTarget.currentWeapon.attack_type != ATTACKTYPE.GUN ) 
			&& ( aiGetTargetDistance() <= backpedal_dist ) ) {
				ai_bh_backpedal( currentTarget );
			};
			
			if ( CheckVisionLoS( currentTarget ) 
			|| CheckMovementLoS( currentTarget ) ) {
				if ( aiGetTargetDistance() <= backpedal_dist ) {
					ai_bh_backpedal();
				};
				
				seen_x = currentTarget.x;
				seen_y = currentTarget.y;
				charLookDir = rotate_to( charLookDir, seen_dir, 0.20 * delta );
				
				if ( aiGetTargetDistance() <= stop_dist ) {
					charVelocity = 0;
					charLookDir = rotate_to( charLookDir, seen_dir, 0.20 * delta );
					
					var angle_diff = abs( angle_difference( charLookDir, seen_dir ) );
					
					if ( angle_diff < 5 ) {
						movementDirection = seen_dir;
								
						charAttackWeapon( false );
					};
				}
				else {
					seen_x = currentTarget.x;
					seen_y = currentTarget.y;
					
					charLookDir = rotate_to( charLookDir, seen_dir, 0.20 * delta );
					
					var angle_diff = abs( angle_difference( charLookDir, seen_dir ) );
					
					if ( angle_diff < 5 ) {
						charVelocity = 0.65;
						movementDirection = seen_dir;
								
						charAttackWeapon( false );
					};
				};
			};
			
			if ( !CheckVisionLoS( currentTarget ) 
			&& !CheckMovementLoS( currentTarget ) 
			&& !no_chase ) {
				enemy_state = ESTATE.SEARCH;
			}
			else if ( !CheckVisionLoS( currentTarget ) 
			&& !CheckMovementLoS( currentTarget ) 
			&& no_chase ) {
				enemy_state = ESTATE.IDLE;
			};
			#endregion
			break;
	};
	#endregion

}