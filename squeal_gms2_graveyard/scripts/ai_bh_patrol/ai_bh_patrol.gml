function ai_bh_patrol() 
{
	var patrol_spd	= 0.25;
	var checkx = floor(	( x + ( currentXSpd * delta ) +  lengthdir_x( 8, patrol_dir ) ) * 16 ) / 16;
	var checky = floor(	( y + ( currentYSpd * delta ) +  lengthdir_y( 8, patrol_dir ) ) * 16 ) / 16;
	
	collision_enable( ,BLOCK_PATROL | BLOCK_MOVEMENT );
	
	if ( !place_free( checkx, checky ) ) 
	{
		patrol_dir += 90;
	}
	
	collision_disable();
	
	movementDirection = charLookDir;
	charVelocity = patrol_spd;
	
	charLookDir = rotate( charLookDir, patrol_dir, 8 * delta );
};