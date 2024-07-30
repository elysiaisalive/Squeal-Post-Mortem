event_inherited();

if ( char_state != CSTATE.DEAD && instance_exists( tank ) )
{
	tank.x = x + lengthdir_x( 0, charLookDir );
	tank.y = y + lengthdir_y( 0, charLookDir );
	tank.image_angle = charLookDir;
	tank.image_index = image_index;
}