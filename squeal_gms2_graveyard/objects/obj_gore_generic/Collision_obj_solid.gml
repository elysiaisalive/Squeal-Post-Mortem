
if ( ( other.collision_flags & BLOCK_MOVEMENT ) && bounce )
{
	move_bounce_all( true );
	gore_spd *= 0.1;
};