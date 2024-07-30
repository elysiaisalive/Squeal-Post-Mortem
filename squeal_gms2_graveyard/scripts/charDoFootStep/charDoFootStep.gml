function charDoFootStep( _playFootsteps = false ) {
	if ( _playFootsteps ) {
		if ( charLegAnimIndex >= 16 ) {
			charLegAnimIndex = 0;
		}

		charLegAnimIndex = clamp( charLegAnimIndex, 0, 16 );

		var leg1 = charLegAnimIndex < 8 && ( charLegAnimIndex + ( point_distance( 0, 0, currentXSpd, currentYSpd ) ) >= 8 );
		var leg2 = charLegAnimIndex < 16 && ( charLegAnimIndex + ( point_distance( 0, 0, currentXSpd, currentYSpd ) ) >= 16 );

		var mat = get_tilematerial( x, y );
		var _materialVolume = 12;
		var step_snd = noone;

		switch( mat ) {
			case "Ground_Tile_MaterialTile" :
				step_snd = choose( snd_footstep_tile, snd_footstep_tile2, snd_footstep_tile3 );
				_materialVolume = 24;
				break;
			case "Ground_Tile_MaterialMetal" :
				step_snd = choose( snd_footstep_metal, snd_footstep_metal2, snd_footstep_metal3, snd_footstep_metal4 );
				_materialVolume = 48;
				break;
			case "Ground_Tile_MaterialDirt" :
				step_snd = choose( snd_footstep_dirt, snd_footstep_dirt2, snd_footstep_dirt3, snd_footstep_dirt4 );
				_materialVolume = 24;
				break;			
			case "Ground_Grass" :
				step_snd = choose( snd_footstep_grass, snd_footstep_grass2, snd_footstep_grass3, snd_footstep_grass4, snd_footstep_grass5 );
				_materialVolume = 12;
				break;
			default :
				step_snd = choose( snd_footstep_tile, snd_footstep_tile2, snd_footstep_tile3 );
				_materialVolume = 32;
				break;
		}

		if ( leg1 
		|| leg2 ) {
			if ( !stepped ) {
				// Reuse these for limping movements
				// currentXSpd *= 0.2;
				// currentYSpd *= 0.2;
				sfx_play_at( -1, step_snd, false, x, y, 16, 16 * 24 );
				MakeNoise( _materialVolume * charWalkSpd  );
				stepped = true;
			}
		}
		else {
			stepped = false;
		}
	}
}