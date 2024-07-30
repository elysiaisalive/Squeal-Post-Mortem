if ( solid ) 
{
	exit;
}

swinger = 1;

if ( !locked && CanCollide )
{
	if ( abs( swing_spd ) > 3.5 )
	{
		exit;
	}

	if ( abs( swing_spd ) < 2 )
	{
		playsound_at( snd_env_door_open, x, y );
		CanCollide = false;
	}

	if ( ( x > other.x ) && ( other.y < y ) )
	{
		swing_spd = -7;
		exit;
	}

	if ( ( x > other.x ) && ( other.y > y ) )
	{
		swing_spd = 7;
		exit;
	}

	if ( ( other.y < y + lengthdir_y( 32, image_angle ) ) )
	{ 
		swing_spd = -7;
	}
	else
	{
		swing_spd = 7;
	}
}