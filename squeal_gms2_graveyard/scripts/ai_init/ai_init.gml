function ai_init( _hp = 100, _type = EBEHAVIOUR.WANDER, candie = true, canpath = true, _vision	= 16 * 18 )
{
	// AI Type Init
	can_die			= candie
	can_path		= canpath
	enemy_state		= EALERT.UNALERT
	enemy_behaviour	= _type
	ai_visiondist	= _vision
}