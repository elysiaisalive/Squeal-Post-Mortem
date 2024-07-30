shockwave_timer += ( 1 / game_get_speed( 0 ) ) * delta;
shockwave_amount = ( shockwave_timer / shockwave_duration );

if ( shockwave_amount >= 1 )
{
	instance_destroy();
	exit;
}

depth = z - ( shockwave_size * shockwave_amount );
