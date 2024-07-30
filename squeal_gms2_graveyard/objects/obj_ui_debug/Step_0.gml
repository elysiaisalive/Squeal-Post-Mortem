#region Input Detection
// clamping from 0 to 1 because inputs only go from 0 or 1 
input_up = clamp(keyboard_check_pressed(ord("W")) + keyboard_check_pressed(vk_up) + mouse_wheel_up(), 0, 1);
input_left = clamp(keyboard_check_pressed(ord("A")) + keyboard_check_pressed(vk_left) + mouse_wheel_up(), 0, 1);
input_down = clamp(keyboard_check_pressed(ord("S")) + keyboard_check_pressed(vk_down) + mouse_wheel_down(), 0, 1);
input_right = clamp(keyboard_check_pressed(ord("D")) + keyboard_check_pressed(vk_right) + mouse_wheel_down(), 0, 1);
input_click = clamp(keyboard_check_pressed(vk_enter) + mouse_check_button(mb_left), 0, 1);
#endregion

siner += 0.0050;

controller.step();

if ( input_down )
{
	selected ++;
}
if ( input_up )
{
	selected --;
}

if ( selected >= array_length( options ) )
{
	selected = 0;
}

if ( selected < 0 )
{
	selected = array_length( options ) - 1;
}

if ( keyboard_check_pressed( vk_enter ) )
{
	if ( selected < array_length( music ) )
	{
		//music_play( music[selected], true );
	};
	
	room_goto( options[selected] );
}