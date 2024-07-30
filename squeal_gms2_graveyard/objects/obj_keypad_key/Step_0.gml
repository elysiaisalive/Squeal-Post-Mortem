var mouse_pos = point_distance( x, y, mouse_x, mouse_y );
var dist		= 8;
var keypad		= obj_keypad;

if ( mouse_pos <= dist ) 
{
	key_infocus = true;
}
else
{
	key_infocus = false;
}

#region Key Press
if ( key_infocus )
{
	// If Key Is NOT Pressed and Mouse input detected
	if ( keypad.CanType )
	{
		if ( !key_pressed && mouse_check_button( mb_left ) )
		{
			key_pressed = true;
		
			global.typed_char = key_number + 1;
			
			var pitch = 1;
			
			#region Specific Inputs
			switch( global.typed_char )
			{
				case 10 :
					global.typed_char = "";
					keypad.keypress_clear = true;
					break;
				case 11 :
					global.typed_char = 0;
					break;
				case 12 :
					global.typed_char = "";
					keypad.keypress_submit = true;
					break;
			}
			#endregion
			
			playsound( snd_keypad_press );
			audio_sound_pitch( snd_keypad_press, pitch );
			
			if ( string_length( keypad.saved_string ) < 4 )
			{
				keypad.saved_string = string_insert( keypad.saved_string, string( global.typed_char ), -string_length( keypad.saved_string ) + 1 );
			}
			
			key_sprite = spr_keypad_numbers_pressed;
			//audio_sound_pitch( snd_keypad_press, random_range( 0.8, 1 ) );
			image_index = 1;
		}
		else
		if ( key_pressed && mouse_check_button_released( mb_left ) )
		{		
			key_pressed = false;
			keypad.keypress_clear = false;
			keypad.keypress_submit = false;
			
			key_sprite = spr_keypad_numbers;
			image_index = 0;
		}
	}
	else
	{
		key_pressed = false;
		key_sprite = spr_keypad_numbers;
		image_index = 0;
	}
}
else
{
	key_pressed = false;
	key_sprite = spr_keypad_numbers;
	image_index = 0;
}
#endregion