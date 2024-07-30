if ( keypress_clear )
{
	saved_string = "";
}

if ( CanType && keypress_submit )
{
	if ( saved_string != password )
	{
		playsound( snd_keypad_denied );
		
		saved_string = "----";
		password_accepted = false;
		keypad_timeout = keypad_timeoutmax;
		CanType = false;
		image_index = 2;
	}
}
if ( CanType && keypress_submit )
{
	if ( saved_string == password )
	{
		playsound( snd_keypad_accepted );
		
		saved_string = "----";
		password_accepted = true;
		keypad_timeout = keypad_timeoutmax;
		CanType = false
		image_index = 1;
	}
}

if ( !CanType )
{
	keypad_timeout = max( 0, keypad_timeout - 1 );
		
	if ( keypad_timeout == 0 )
	{
		CanType = true;
		saved_string = "";
		keypress_submit = false;
		image_index = 0;
	}
	
	keypad_timeout = clamp( keypad_timeout, 0 , keypad_timeoutmax );
}

if ( keyboard_check_pressed( vk_escape ) )
{
	
}

if ( password_accepted )
{
	keypad_enddelay = max( 0, keypad_enddelay - 1 );
	
	if ( keypad_enddelay == 0 )
	{
	
		keypad_enddelay = keypad_maxenddelay;
	}
}