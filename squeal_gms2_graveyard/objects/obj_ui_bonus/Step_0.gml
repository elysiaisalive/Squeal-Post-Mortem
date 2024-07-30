#region Input Detection
INPUT_UP			= clamp(keyboard_check_pressed(ord("W")) + keyboard_check_pressed(vk_up) + mouse_wheel_up(), 0, 1)
INPUT_DOWN			= clamp(keyboard_check_pressed(ord("S")) + keyboard_check_pressed(vk_down) + mouse_wheel_down(), 0, 1)
INPUT_LEFT			= clamp(keyboard_check_pressed(ord("A")) + keyboard_check_pressed(vk_left) + mouse_wheel_up(), 0, 1)
INPUT_RIGHT			= clamp(keyboard_check_pressed(ord("D")) + keyboard_check_pressed(vk_right) + mouse_wheel_down(), 0, 1)
INPUT_LEFTCLICK		= clamp(keyboard_check_pressed(vk_enter) + mouse_check_button_pressed(mb_left), 0, 1)
INPUT_RIGHTCLICK	= clamp(keyboard_check_pressed(vk_escape) + mouse_check_button_pressed(mb_right), 0, 1)
INPUT_SPACE			= clamp(keyboard_check_pressed(vk_space), 0, 1)
#endregion

if ( INPUT_LEFT )
{
	selected --;
	
	if ( selected >= array_length( trophy ) )
	{
		str_index = 1;
		str_typed = "";
		
		str2_index = 1;
		str2_typed = "";
		
		timer = 0;
	}
}
if ( INPUT_RIGHT )
{
	selected ++;
	
	if ( selected <= array_length( trophy ) )
	{
		str_index = 1;
		str_typed = "";
		
		str2_index = 1;
		str2_typed = "";
		
		timer = 0;
	}
}

selected = clamp( selected, 0, array_length( trophy ) );

//switch( selected )
//{
//	case 0 :
//		trophy_spr = spr_ui_collectible_generic;
//		str_target = trophy[0][0][2];
//		str2_target = trophy[0][0][3];
//		break;
//	case 1 :
//		trophy_spr = spr_ui_collectible_asire;
//		str_target = trophy[0][1][2];
//		str2_target = trophy[0][1][3];
//		break;
//}

timer = max( 0, timer - 1 );

if ( timer <= 0 )
{	
	str_typed += string_char_at( str_target, str_index );
	str_index ++;

	if ( string_length( str_typed ) < string_length( str_target ) )
	{
		timer = timer_max;
	}
			
	str2_typed += string_char_at( str2_target, str2_index );
	str2_index ++;

	if ( string_length( str2_typed ) < string_length( str2_target ) )
	{
		timer = timer_max;
	}
}