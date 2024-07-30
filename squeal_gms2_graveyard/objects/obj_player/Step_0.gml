event_inherited();

stats.style = 99;
charAbilitySlowMo();

pickup_target = charGetWeaponPickupTarget();

#region Pausing
// var input_esc = keyboard_check_pressed( vk_escape );

// if ( global.level )
// {
// 	if ( room == global.level.lvl.GetCurrentFloor() )
// 	{
// 		if ( input_esc && !global.pause )
// 		{	
// 			pause_game();
// 		}
// 	}
// }
#endregion
#region Character States
if ( stats.hp == 0 )
{
	currentState.ChangeState( deadState );
	char_state = CSTATE.DEAD;
	
}
if ( stats.hp > 0 )
{
	char_state = CSTATE.ALIVE;
}

switch ( char_state )
{
	case CSTATE.ALIVE :
		break;
}
#endregion

if (trigger_pressed && currentWeapon.loud)
{
	noise_radius = 16 * 10;

}

noise_radius -= noise_radius_decay;
noise_radius = clamp( noise_radius, 0, noise_radius_max );
noise_radius = clamp( noise_radius_decay, 0, 1 );