if ( hit_state )
{
	anim_spd += 0.15 * delta;
	
	if ( ( floor( anim_spd ) == image_number - 1 ) )
	{
		anim_spd = 0;
		hit_state = false;
	}
}