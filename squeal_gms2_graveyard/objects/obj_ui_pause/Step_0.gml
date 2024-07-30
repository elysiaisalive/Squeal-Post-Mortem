if ( start_x != target_x )
{
	start_x = lerp( start_x, target_x, move );
	start_rot = lerp( start_rot, target_rot, 0.09 );
}

siner = max( 0, siner + 0.005 );

if ( !unpausing )
{
	alpha = max( 0, alpha + 0.05 );
	alpha = clamp( alpha, 0, 0.85 );
	
	start_x = lerp( start_x, target_x, move );
	start_rot = lerp( start_rot, target_rot, move );
}

var input_esc = keyboard_check_pressed( vk_escape );

if ( input_esc && global.pause )
{
	unpausing = true;
}

if ( unpausing )
{
	alpha = max( 0, alpha - 0.05 );

	if ( alpha == 0 )
	{
		unpause_game();
	}
}

controller.step();