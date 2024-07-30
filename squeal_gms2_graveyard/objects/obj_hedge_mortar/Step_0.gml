c_timer = max( 0, c_timer - 1 * delta );

if ( c_timer == 0 )
{
	c_mortar = choose( c_red, c_orange, c_white );
	c_timer = c_maxtime;
}

alpha = max( 0, alpha + 0.1 * delta );

alpha = clamp( alpha, 0, alpha_max );
mortaralpha = clamp( mortaralpha, 0, mortaralpha_max );
c_timer = clamp( c_timer, 0, c_maxtime );

mortar_delay = max( 0, mortar_delay - 1 * delta );

if ( mortar_delay == 0 )
{
	mortaralpha = max( 0, mortaralpha + 0.008 * delta );
	mortar_starty = clamp( mortar_starty + 16 * delta, mortar_starty, mortar_targety );
	mortar_startx = clamp( mortar_startx + 16 * delta, mortar_startx, mortar_targetx );
}

mortar_delay = clamp( mortar_delay, 0, mortar_maxdelay );