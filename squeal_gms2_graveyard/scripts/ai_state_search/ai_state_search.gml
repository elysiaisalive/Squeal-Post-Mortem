function ai_state_search( searchfor = obj_player )
{
	if ( searchfor.char_state == CSTATE.ALIVE )
	{
		if ( CheckVisionLoS( searchfor ) 
		&& CheckMovementLoS( searchfor ) )
		{
			if ( currentWeapon.itemName != "Unarmed" )
			{
				//sprite_index = charGetSpriteFromIndex( self, currentWeapon.walk_sprite ) ?? FALLBACK_SPRITE;
				searchTimer.Pause();
				searchTimer.ResetTimer();
				enemy_state = ESTATE.ATTACK;
				anim_spd = 0;
					
				if ( enemy_alert != EALERT.ALERTED 
				&& enemy_alert != EALERT.READY )
				{
					enemy_alert = EALERT.ALERTED;
				};
			}
		}
		else if ( !CheckVisionLoS( searchfor ) 
		&& !CheckMovementLoS( searchfor ) )
		{
			if ( CalculatePathToPoint( [seen_x, seen_y] ) )
			{
				MoveThroughPath( currentPath, 2.50, function(){
					charVelocity = 0;
					searchTimer.Unpause();
					//sprite_index = charGetSpriteFromIndex( self, currentWeapon.search_sprite ) ?? FALLBACK_SPRITE;
					anim_spd = 0.25;
				} );
			};
		} // Melee vision check
		else if ( CheckVisionLoS( searchfor ) 
		&& !CheckMovementLoS( searchfor ) )
		{
			seen_x = searchfor.x;
			seen_y = searchfor.y;
						
			if ( CalculatePathToPoint( [seen_x, seen_y] ) )
			{
				MoveThroughPath( currentPath, 2.50, function(){
					charVelocity = 0;
					searchTimer.Unpause();
					//sprite_index = charGetSpriteFromIndex( self, currentWeapon.search_sprite ) ?? FALLBACK_SPRITE;
					anim_spd = 0.25;
				} );
			};
		};
	};
	
	if ( searchTimer.GetTime() <= 0 )
	{
		switch( enemy_behaviour )
		{
			default :
				enemy_state = ESTATE.IDLE;
				//sprite_index = charGetSpriteFromIndex( self, currentWeapon.walk_sprite ) ?? FALLBACK_SPRITE;
				anim_spd = 0;
				searchTimer.Pause();
				searchTimer.ResetTimer();
				break;
			case EBEHAVIOUR.PATROL :
				enemy_state = ESTATE.RETURN;
				//sprite_index = charGetSpriteFromIndex( self, currentWeapon.walk_sprite ) ?? FALLBACK_SPRITE;
				anim_spd = 0;
				searchTimer.Pause();
				searchTimer.ResetTimer();
				break;
		}
							
		enemy_alert = EALERT.READY;
	}
}