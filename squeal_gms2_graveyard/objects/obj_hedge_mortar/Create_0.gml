merge			= 0;
delay_time		= 30;
delay_maxtime	= 30;

c_timer			= 3;
c_maxtime		= 3;

c_mortar		= c_white;

alpha			= 0;
alpha_max		= 1;

mortaralpha		= 0;
mortaralpha_max	= 0.5;

mortar_shot		= false;
mortar_delay	= 53;
mortar_maxdelay	= 53;

mortar_startx	= x - room_width;
mortar_targetx  = x;

mortar_starty	= y - room_height;
mortar_targety  = y;

playsound_at( snd_mortar_incoming, x, y );
instance_create_depth( x, y, -95, obj_hedge_mortarshadow );