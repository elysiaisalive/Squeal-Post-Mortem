function ai_bh_wander()
{
	var _check_x = floor( ( x + ( currentXSpd * delta ) +  lengthdir_x( 8, fWanderDir ) ) * 16 ) / 16;
	var _check_y = floor( ( y + ( currentYSpd * delta ) +  lengthdir_y( 8, fWanderDir ) ) * 16 ) / 16;
	
	_delay_timer.Tick();
	
	if ( enemy_alert != EALERT.ALERTED ) {
		if ( _delay_timer.GetTime() <= 0 ) {
			_rotate_timer.Tick();
			
			if ( _rotate_timer.GetTime() <= 0
			&& charLookDir != fWanderDir )
			{
				charLookDir = fWanderDir;
			};
			
			if ( _walk_timer.GetTime() > 0 
			&& charLookDir == fWanderDir )
			{
				collision_enable();
				
				if ( !place_free ( _check_x, _check_y ) )
				{
					fWanderDir = charLookDir - 180 + random_range( -90, 90 );
					charLookDir = rotate( charLookDir, fWanderDir, 8 * delta );
					_walk_timer.SetTime( 0 );
					_rotate_timer.SetTime( 0 );
					
				}
				else
				{
					_walk_timer.Tick();
					charLookDir = rotate( charLookDir, fWanderDir, 8 * delta );
					movementDirection = charLookDir;
					charVelocity = 0.30;
				};
				
				collision_disable();
			};
			
			if ( _walk_timer.GetTime() <= 0 )
			{
				_walk_timer.ResetTimer( true );
				_rotate_timer.ResetTimer( true );
				_delay_timer.ResetTimer( true );
				
				fWanderDir = random_range( -360, 360 );
				charVelocity = 0;
			};
			
			charLookDir = rotate( charLookDir, fWanderDir, 8 * delta );
			fWanderDir = clamp( fWanderDir, -360, 360 );
		};
	}
};