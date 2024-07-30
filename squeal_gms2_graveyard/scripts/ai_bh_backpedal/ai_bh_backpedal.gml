function ai_bh_backpedal( target = obj_player ) 
{
	var dir = point_direction( x, y, target.x, target.y );
	var dist = point_distance( x, y, target.x, target.y );
	var check = collision_line( x, y, x + lengthdir_x( 32, charLookDir - 180 ), y + lengthdir_y( 32, charLookDir - 180 ), obj_wall, false, true );
			
	// Will Probably redo later
	if ( ( target.currentWeapon.firemode_type == FIREMODE.MELEE ) && ( dist <= 16 * 8 ) )
	{
		charLookDir = rotate_to( charLookDir, dir, 0.8 );
			
		if ( check ) 
		{
			movementDirection = charLookDir - 180 + 90;
			charVelocity = 0.7;
		}
		else
		{
			movementDirection = charLookDir - 180;
			charVelocity = 0.6 * ( dist / 32 );
		}
	}
}