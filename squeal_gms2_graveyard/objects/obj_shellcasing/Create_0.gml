z = depth;			// -30 is a good depth to have it at.
zsp = -random( 3 );	// how fast the object is launched upwards at
ground_z = 0;		// the depth the object bounces at
bounce = 0.6;		// multiplier for the bounce
bounce_frc = 0.6;	// multiplier for speed lost when bouncing

air_frc	= 0.02;		// friction in the air
ground_frc = 0.1;	// friction on the ground

angle_rot = random_range( -4, 4 );
spin = 1 * angle_rot;

height = 1;			// how tall the object is 
weight = 0.2;		// how fast the object falls

sound = snd_shellcasing_small;
sound_single = false; // only play a bounce sound once ( e.g: one sound with multiple bounces )
sound_played = false;

zscale_amount = ( 1 / 2 ); // the strength of the 3d effect in topdown
zscale_inc = ( zscale_amount / 15 ); // the amount added to the z scale every step until it reaches the amount
zscale = 0;

shell_sprite	= -1;
shell_index		= 0;
shell_spd		= 0;
shell_frc		= 0;
shell_dir		= 0;

shell_x = x;	// x visual position of the shell
shell_y = y;	// y visual position of the shell
shadow_x = x;	// x visual position of the shell
shadow_y = y;	// y visual position of the shell

smoke_timer		= 12;
smoke_maxtimer	= 12;

animated		= false;
