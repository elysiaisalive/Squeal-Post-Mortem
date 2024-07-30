function ai_bh_hider( searchx, searchy ) 
{
	var searchdir = point_direction( x, y, searchx, searchy );
	var dist = point_distance( x, y, searchx, searchy );

	if ( obj_player.char_state == CSTATE.ALIVE )
	{	
		if ( CheckVisionLoS( obj_player ) )
		{
			charLookDir = rotate_to( charLookDir, searchdir, 0.09 );
			target_x = lerp( target_x, searchx, 0.2 );
			target_y = lerp( target_y, searchy, 0.2 );
			
			if ( ( sprite_index == charGetSpriteFromIndex( self, currentWeapon.hide_sprite ) ) && floor( anim_index != image_number - 1 ) )
			{
				anim_index = lerp( anim_index, image_number - 1, 0.09 * delta );
			}
			
			if ( floor( anim_index == image_number - 1 ) || floor( anim_index >= image_number - 2 ) )
			{
				can_collide_proj = true;
			}
		}
		else
		{		
			if ( floor( anim_index != 0 ) )
			{
				sprite_index = charGetSpriteFromIndex( self, currentWeapon.hide_sprite );
				can_collide_proj = false;
				
				anim_index = lerp( anim_index, 0, 0.05 * delta );
			}	
		}
	}
}